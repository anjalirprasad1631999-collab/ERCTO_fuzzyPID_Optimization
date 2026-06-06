
function [best_solution, best_fitness, fitness_history] = SCTOA(objFunc, dim, numStudents, numSections, maxIter, lb, ub)
    % --- Initialization ---
    students = repmat(lb, numStudents, 1) + rand(numStudents, dim) .* (repmat(ub - lb, numStudents, 1));
    fitness = zeros(numStudents, 1);
    for i = 1:numStudents
        val = floor(students(i, :));
        val = max(min(val, 6), 0);  
        fitness(i) = objFunc(val);
    end
    fitness_history = zeros(maxIter, 1);
    sectionSize = floor(numStudents / numSections);

    % --- Main loop ---
    for iter = 1:maxIter
        sectionToppers = zeros(numSections, dim);
        sectionFitness = zeros(numSections, 1);

        % Find section toppers
        for s = 1:numSections
            idx_start = (s - 1) * sectionSize + 1;
            if s == numSections
                idx_end = numStudents;  
            else
                idx_end = s * sectionSize;
            end

            group = students(idx_start:idx_end, :);
            groupFitness = fitness(idx_start:idx_end);

            [minVal, minIdx] = min(groupFitness);
            sectionToppers(s, :) = group(minIdx, :);
            sectionFitness(s) = minVal;
        end

        % Find class topper
        [best_fitness, bestIdx] = min(sectionFitness);
        classTopper = sectionToppers(bestIdx, :);

        % --- Monotonic fitness history update ---
        if iter == 1
            fitness_history(iter) = best_fitness;
        else
            fitness_history(iter) = min(fitness_history(iter-1), best_fitness);
        end

        fprintf("Iteration %d/%d completed\n", iter, maxIter);

        % --- Topper movement ---
        for s = 1:numSections
            if s ~= bestIdx
                r1 = rand(1, dim);
                sectionToppers(s, :) = sectionToppers(s, :) + r1 .* (classTopper - sectionToppers(s, :));
                sectionToppers(s, :) = max(min(sectionToppers(s, :), ub), lb);
            end
        end

        % --- Student update ---
        for s = 1:numSections
            idx_start = (s - 1) * sectionSize + 1;
            if s == numSections
                idx_end = numStudents;
            else
                idx_end = s * sectionSize;
            end

            for i = idx_start:idx_end
                r2 = rand(1, dim);
                students(i, :) = students(i, :) + r2 .* (sectionToppers(s, :) - students(i, :));

                mutation = 0.01 * (ub - lb) .* randn(1, dim);
                students(i, :) = students(i, :) + mutation;
                students(i, :) = max(min(students(i, :), ub), lb);

                val = floor(students(i, :));
                val = max(min(val, 6), 0); 
                fitness(i) = objFunc(val);
            end
        end

        % --- Dual crossover (student with section & class toppers) ---
        for idx = 1:numStudents
            student = students(idx, :);

            % Identify this student's section
            sec_id = ceil(idx / sectionSize);
            if sec_id > numSections
                sec_id = numSections;
            end
            sectionTopper = sectionToppers(sec_id, :);

            % Divide dimensions into 3 blocks (kp, ki, kd)
            kp_idx = 1:49;
            ki_idx = 50:98;
            kd_idx = 99:147;

            % Select 10 random genes from each block
            kp_sel = kp_idx(randperm(49, 10));
            ki_sel = ki_idx(randperm(49, 10));
            kd_sel = kd_idx(randperm(49, 10));
            cross_idx = [kp_sel ki_sel kd_sel];

            % --- Child 1: crossover with section topper ---
            child1 = student;
            child1(cross_idx) = sectionTopper(cross_idx);
            child1 = child1 + 0.01 * (ub - lb) .* randn(1, dim);
            child1 = max(min(child1, ub), lb);
            val1 = floor(child1);
            val1 = max(min(val1, 6), 0);
            fit1 = objFunc(val1);

            % --- Child 2: crossover with class topper ---
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
