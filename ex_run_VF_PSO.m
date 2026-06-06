%clc;
%clear;
%close all;

format long g



dim = 147;

numParticles = 60;
maxIter = 30;

lb = zeros(1, dim);
ub = 6 * ones(1, dim);



[best_solution, best_fitness, fitness_history] = VFPSO(@myFuzzyObjective, dim, numParticles, maxIter, lb, ub);



disp('====================================================');
disp('Best Fitness Achieved (Minimum ITAE):');
disp(best_fitness);

disp('====================================================');
disp('Best VF-PSO Solution:');
disp(best_solution);



figure;

plot(fitness_history, '-o', 'LineWidth', 2, 'MarkerSize', 5);

xlabel('Iteration');
ylabel('Best Fitness (ITAE)');
title('Fitness Value vs Iteration - VF-PSO');

grid on;



results_filename = 'vfpso_results.mat';

save(results_filename, 'best_solution', 'best_fitness', 'fitness_history');

