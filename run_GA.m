
% Problem dimension
dim = 147;

% Lower and upper bounds
lb = zeros(1, dim);
ub = 6 * ones(1, dim);


global ga_fitness_history
ga_fitness_history = [];


options = optimoptions('ga','PopulationSize', 20,'MaxGenerations', 15,'Display', 'iter','OutputFcn', @ga_output_function);


[x_ga, f_ga] = ga(@fitness_fun, dim, [], [], [], [], lb, ub, [], options);


best_solution_ga = floor(x_ga);
best_solution_ga = max(min(best_solution_ga, 6), 0);

best_fitness_ga = f_ga;
fitness_history_ga = ga_fitness_history;


disp('Best GA fitness achieved:');
disp(best_fitness_ga);

disp('Best GA solution:');
disp(best_solution_ga);


results_filename = 'ga_results.mat';
save(results_filename, 'best_solution_ga', 'best_fitness_ga', 'fitness_history_ga');

