function [best_solution, best_fitness, fitness_history] = SCTOA_KMeans_DualCrossover(objFunc, dim, numStudents, numClusters, maxIter, lb, ub)

    % Initialize population
    students = repmat(lb, numStudents, 1) + rand(numStudents, dim) .* (repmat(ub - lb, numStudents, 1));
    fitness = zeros(numStudents, 1);

    for i = 1:numStudents
        val = floor(students(i, :));
        val = max(min(val, 6), 0);
        fitness(i) = objFunc(val);
    end

    fitness_history = zeros(maxIter, 1);
    cluster_idx = kmeans(students, numClusters);
    reclusterInterval = 5;

    for iter = 1:maxIter
        if mod(iter, reclusterInterval) == 0
            cluster_idx = kmeans(students, numClusters);
        end

        clusterToppers = zeros(numClusters, dim);
        clusterFitness = zeros(numClusters, 1);

        for c = 1:numClusters
            cluster_members = students(cluster_idx == c, :);
            cluster_fits = fitness(cluster_idx == c);

            if isempty(cluster_members)
                clusterToppers(c, :) = lb + rand(1, dim) .* (ub - lb);     % --- This code handles the case where a K-means cluster becomes empty. It reinitializes the cluster topper randomly within bounds and assigns it a large (bad) fitness value to maintain algorithm stability and diversity.
                clusterFitness(c) = inf;
            else
                [minVal, minIdx] = min(cluster_fits);
                clusterToppers(c, :) = cluster_members(minIdx, :);
                clusterFitness(c) = minVal;
            end
        end

        [best_fitness, bestIdx] = min(clusterFitness);
        classTopper = clusterToppers(bestIdx, :);

        % --- Monotonic fitness history update ---
        if iter == 1
            fitness_history(iter) = best_fitness;
        else
            fitness_history(iter) = min(fitness_history(iter-1), best_fitness);
        end

        fprintf("Iteration %d/%d completed | Best fitness: %.4f\n", iter, maxIter, best_fitness);

        % Topper movement
        for c = 1:numClusters
            if c ~= bestIdx
                r1 = rand(1, dim);
                clusterToppers(c, :) = clusterToppers(c, :) + r1 .* (classTopper - clusterToppers(c, :));
                clusterToppers(c, :) = max(min(clusterToppers(c, :), ub), lb);
            end
        end

        % Student update
        for c = 1:numClusters
            member_indices = find(cluster_idx == c);
            for i = member_indices'
                r2 = rand(1, dim);
                students(i, :) = students(i, :) + r2 .* (clusterToppers(c, :) - students(i, :));

                mutation = 0.01 * (ub - lb) .* randn(1, dim);
                students(i, :) = students(i, :) + mutation;
                students(i, :) = max(min(students(i, :), ub), lb);      % --- here cluster toppers are not exempted from getting updated, all students including the cluster topper are updated, so if needed we can change it later, codes are written in another file. 

                val = floor(students(i, :));
                val = max(min(val, 6), 0);
                fitness(i) = objFunc(val);
            end
        end

        % --- Dual crossover between student & toppers (RCTO style) ---
        for idx = 1:numStudents
            student = students(idx, :);
            cluster_id = cluster_idx(idx);
            sectionTopper = clusterToppers(cluster_id, :);

            % Indices for kp, ki, kd blocks
            kp_idx = 1:49;
            ki_idx = 50:98;
            kd_idx = 99:147;

            % Select 10 random genes from each block
            kp_sel = kp_idx(randperm(49, 10));
            ki_sel = ki_idx(randperm(49, 10));
            kd_sel = kd_idx(randperm(49, 10));
            cross_idx = [kp_sel ki_sel kd_sel];

            % --- Crossover with section topper ---
            child1 = student;
            child1(cross_idx) = sectionTopper(cross_idx);       % --- At these random positions, replace the student’s values with those of the section topper.
            child1 = child1 + 0.01 * (ub - lb) .* randn(1, dim);  % --- This introduces variability, helps escape local minima, and simulates biological “learning noise.”
            child1 = max(min(child1, ub), lb);                      % --- Ensures every element of child1 stays within the search space [lb, ub].
            val1 = floor(child1);                                       % --- This converts continuous-valued parameters into integer-like rule indices (0–6)
            val1 = max(min(val1, 6), 0);
            fit1 = objFunc(val1);

            % --- Crossover with class topper ---
            child2 = student;
            child2(cross_idx) = classTopper(cross_idx);
            child2 = child2 + 0.01 * (ub - lb) .* randn(1, dim);
            child2 = max(min(child2, ub), lb);
            val2 = floor(child2);
            val2 = max(min(val2, 6), 0);
            fit2 = objFunc(val2);

            % --- Original fitness ---
            val_orig = floor(student);
            val_orig = max(min(val_orig, 6), 0);
            fit_orig = fitness(idx);

            % --- Elitist selection ---
            [minFit, choice] = min([fit_orig, fit1, fit2]);
            if choice == 2
                students(idx, :) = child1;
                fitness(idx) = fit1;
            elseif choice == 3
                students(idx, :) = child2;
                fitness(idx) = fit2;
            end
        end
    end

    best_solution = classTopper;
end
