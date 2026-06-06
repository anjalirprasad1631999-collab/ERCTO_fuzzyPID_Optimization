%clc;
%clear;
%close all;

format long g

%%=============================================================
% Problem Definition
%%=============================================================

dim = 147;

numParticles = 60;
maxIter = 30;

lb = zeros(1, dim);
ub = 6 * ones(1, dim);

%%=============================================================
% Run VF-PSO
%%=============================================================

[best_solution, best_fitness, fitness_history] = VFPSO(@myFuzzyObjective, dim, numParticles, maxIter, lb, ub);

%%=============================================================
% Display Results
%%=============================================================

disp('====================================================');
disp('Best Fitness Achieved (Minimum ITAE):');
disp(best_fitness);

disp('====================================================');
disp('Best VF-PSO Solution:');
disp(best_solution);

%%=============================================================
% Plot Fitness History
%%=============================================================

figure;

plot(fitness_history, '-o', 'LineWidth', 2, 'MarkerSize', 5);

xlabel('Iteration');
ylabel('Best Fitness (ITAE)');
title('Fitness Value vs Iteration - VF-PSO');

grid on;

%%=============================================================
% Save Results
%%=============================================================

results_filename = 'vfpso_results.mat';

save(results_filename, 'best_solution', 'best_fitness', 'fitness_history');

%%=============================================================
% Save Readable Text Files
%%=============================================================

writematrix(best_solution,'vfpso_best_solution.txt');

writematrix(best_fitness, 'vfpso_best_fitness.txt');

writematrix(fitness_history, 'vfpso_fitness_history.txt');