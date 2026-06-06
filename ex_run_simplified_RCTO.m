
dim = 147;                         
numStudents = 60;
numSections = 3;
maxIter = 30;
lb = zeros(1, dim);               
ub = 6 * ones(1, dim);            
[best_solution, best_fitness, fitness_history] = SCTOA(@myFuzzyObjective, dim, numStudents, numSections, maxIter, lb, ub);
disp('Best fitness achieved (minimum ITAE):');
disp(best_fitness);
disp('Best Solution (combinations of Kp, Ki and Kd');
disp(best_solution);



results_filename='sctoa_results.mat'; 
save(results_filename, 'best_solution','best_fitness','fitness_history');


