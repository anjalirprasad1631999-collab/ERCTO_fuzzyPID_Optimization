# ERCTO_fuzzyPID_Optimization
MATLAB implementation of ERCTO, simplified-RCTO, simplified-PSO, and GA for FIS optimization in a fuzzy-PID-based nonlinear intracranial pressure controller.

This repository contains the MATLAB implementation of the optimization algorithms used in the study on optimizing fuzzy PID controllers for intracranial pressure (ICP) regulation.

## Contents

The repository includes:

* ERCTO (Enhanced Reshaped Class Topper Optimization Algorithm)
* Simplified-RCTO (Simplified-Reshaped Class Topper Optimization Algorithm)
* Simplified-PSO (Simplified-Particle Swarm Optimization)
* GA (Genetic Algorithm)
* Supporting MATLAB functions for fuzzy-rule optimization

## Repository Structure

The following files constitute the core implementation of the optimization framework presented in the manuscript:

* `SCTOA.m` – Main implementation of the Simplified-RCTO algorithm
* `ex_run_simplified_RCTO.m` – Script for executing Simplified-RCTO
* `VFPSO.m` – Main implementation of the Simplified-PSO algorithm
* `ex_run_VF_PSO.m` – Script for executing Simplified-PSO
* `run_GA.m` – Script for executing the Genetic Algorithm
* `SCTOA_KMeans_DualCrossover.m` - Main implementation of the ERCTO algorithm
* `ex_run_ERCTO.m` – Script for executing ERCTO
* `myFuzzyObjective.m` – Objective function used during optimization of Simplified-RCTO, ERCTO, and Simplified-PSO
* `fitness_fun.m` – Objective function used during optimization of GA
* `applyOutputsToFIS.m` – Function for updating fuzzy rule consequents

These files collectively implement the optimization procedures and fitness evaluation framework described in the manuscript.

## Requirements

* MATLAB
* Fuzzy Logic Toolbox
* Global Optimization Toolbox
* Simulink

## Additional Information

The fuzzy inference system structure, controller architecture, and simulation framework associated with this work are described in the accompanying manuscript. The repository is intended to provide the optimization framework and supporting MATLAB codes used in the study. Additional implementation details may be obtained from the corresponding author upon reasonable request.

## Citation

If you use this code in your research, please cite the associated publication.
