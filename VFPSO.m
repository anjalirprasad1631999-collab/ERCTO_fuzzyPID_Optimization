function [best_solution, best_fitness, fitness_history] = VFPSO(objFunc, dim, numParticles, maxIter, lb, ub)

    c1 = 1;
    c2 = 1;

    mutation_rate = 0.01;

    particles = repmat(lb, numParticles, 1) + rand(numParticles, dim) .* repmat((ub - lb), numParticles, 1);

    fitness = zeros(numParticles,1);

    pbest = particles;
    pbestFitness = inf(numParticles,1);

    gbest = zeros(1, dim);
    gbestFitness = inf;

    fitness_history = zeros(maxIter,1);

    % Initial fitness evaluation
    for i = 1:numParticles

        val = floor(particles(i,:));
        val = max(min(val,6),0);

        fitness(i) = objFunc(val);

        pbest(i,:) = particles(i,:);
        pbestFitness(i) = fitness(i);

        if fitness(i) < gbestFitness

            gbestFitness = fitness(i);
            gbest = particles(i,:);

        end

    end

    % Main loop
    for iter = 1:maxIter

        for i = 1:numParticles

            r1 = rand(1, dim);
            r2 = rand(1, dim);

            % VF-PSO position update
            particles(i,:) = particles(i,:) + c1 .* r1 .* (pbest(i,:) - particles(i,:)) + c2 .* r2 .* (gbest - particles(i,:));

            % Mutation
            mutation = mutation_rate .* (ub - lb) .* randn(1, dim);

            particles(i,:) = particles(i,:) + mutation;

            % Bounds
            particles(i,:) = max(min(particles(i,:), ub), lb);

            % Fitness
            val = floor(particles(i,:));
            val = max(min(val,6),0);

            currentFitness = objFunc(val);

            fitness(i) = currentFitness;

            % Personal best update
            if currentFitness < pbestFitness(i)

                pbest(i,:) = particles(i,:);
                pbestFitness(i) = currentFitness;

            end

            % Global best update
            if currentFitness < gbestFitness

                gbest = particles(i,:);
                gbestFitness = currentFitness;

            end

        end

        % Monotonic fitness history
        if iter == 1
            fitness_history(iter) = gbestFitness;
        else
            fitness_history(iter) = min(fitness_history(iter-1), gbestFitness);
        end

        fprintf('Iteration %d/%d completed | Best Fitness: %.6f\n',iter, maxIter, gbestFitness);

    end

    best_solution = floor(gbest);
    best_solution = max(min(best_solution,6),0);

    best_fitness = gbestFitness;

end