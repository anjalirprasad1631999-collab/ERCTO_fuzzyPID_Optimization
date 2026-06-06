# ERCTO_fuzzyPID_Optimization
MATLAB implementation of ERCTO, simplified-RCTO, simplified-PSO, and GA for fuzzy PID optimization in a nonlinear intracranial pressure controller.

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

SCTOA.m – Main implementation of the Section-Class Topper Optimization Algorithm (SCTOA)
run_SCTOA.m – Script for executing SCTOA optimization
VFPSO.m – Main implementation of Velocity-Free Particle Swarm Optimization (VF-PSO)
run_VFPSO.m – Script for executing VF-PSO optimization
run_GA.m – Script for executing the Genetic Algorithm (GA)
myFuzzyObjective.m – Objective function used for fitness evaluation
applyOutputsToFIS.m – Function for updating fuzzy rule consequents


The following files constitute the core implementation of the optimization framework presented in the manuscript:


* `SCTOA.m` – Main implementation of the Simplified-RCTO algorithm
* `ex_run_simplified_RCTO.m` – Script for executing Simplified-RCTO
* `VFPSO.m` – Main implementation of the Simplified-PSO algorithm
* `run_VFPSO.m` – Script for executing VF-PSO
* `run_GA.m` – Script for executing the Genetic Algorithm
* `myFuzzyObjective.m` – Objective function used during optimization
* `applyOutputsToFIS.m` – Function for updating fuzzy rule consequents

These files collectively implement the optimization procedures and fitness evaluation framework described in the manuscript.

## Requirements

* MATLAB
* Fuzzy Logic Toolbox
* Global Optimization Toolbox
* Simulink

## Notes

The fuzzy inference system structure, membership functions, controller architecture, and associated model details are described in the corresponding manuscript. The repository is intended to provide the optimization framework and supporting MATLAB codes associated with the study.

## Citation

If you use this code in your research, please cite the associated publication.
