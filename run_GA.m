
% Problem dimension
dim = 147;

% Lower and upper bounds
lb = zeros(1, dim);
ub = 6 * ones(1, dim);

% Global variable to store GA fitness history
global ga_fitness_history
ga_fitness_history = [];

% GA options
options = optimoptions('ga','PopulationSize', 20,'MaxGenerations', 15,'Display', 'iter','OutputFcn', @ga_output_function);

% Run Genetic Algorithm
[x_ga, f_ga] = ga(@fitness_fun, dim, [], [], [], [], lb, ub, [], options);

% Discretize final GA solution
best_solution_ga = floor(x_ga);
best_solution_ga = max(min(best_solution_ga, 6), 0);

best_fitness_ga = f_ga;
fitness_history_ga = ga_fitness_history;

% Display results
disp('Best GA fitness achieved:');
disp(best_fitness_ga);

disp('Best GA solution:');
disp(best_solution_ga);

% Save results
results_filename = 'ga_results.mat';
save(results_filename, 'best_solution_ga', 'best_fitness_ga', 'fitness_history_ga');

% Save readable text files
writematrix(best_solution_ga, 'ga_best_solution.txt');
writematrix(best_fitness_ga, 'ga_best_fitness.txt');
writematrix(fitness_history_ga, 'ga_fitness_history.txt');