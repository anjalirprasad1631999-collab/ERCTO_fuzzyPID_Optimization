dim = 147;                          % Total decision variables (e.g. 49 rules * 3 outputs)
numStudents = 60;                  % Number of students (population size)
numClusters = 3;                   % Number of clusters (was numSections)
maxIter = 30;                       % Number of iterations
lb = zeros(1, dim);               
ub = 6 * ones(1, dim);             % Kp, Ki, Kd range [0, 6]

[best_solution, best_fitness, fitness_history] = SCTOA_KMeans_DualCrossover(@myFuzzyObjective, dim, numStudents, numClusters, maxIter, lb, ub);

disp('Best fitness achieved (minimum ITAE):');
disp(best_fitness);

disp('Best Solution (combinations of Kp, Ki and Kd):');
disp(best_solution);

%Assuming these variables exist after your optimization:
%best_solution (1xN vector)
%best_fitness (scalar)
%fitness_history (1xma_iter or similar)

results_filename='sctoa_results.mat'; % sets the filename for results
save(results_filename, 'best_solution','best_fitness','fitness_history');

%Also save readable text versions (for terminal access)
writematrix(best_solution,'best_solution.txt');
writematrix(best_fitness,'best_fitness.txt');
writematrix(fitness_history,'fitness_history.txt'); %transponded for readability
