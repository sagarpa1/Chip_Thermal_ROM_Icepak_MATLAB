# Physics-Informed Reduced Order Thermal Model of High-Power Chip  
(ANSYS Icepak + MATLAB)

---

## Project Overview

This project develops a physics-informed Reduced Order Model (ROM) for predicting
maximum die temperature and heat flow of a high-power semiconductor chip.

High-fidelity CFD simulations are accurate but computationally expensive.
To enable rapid thermal evaluation, parametric CFD results are generated in ANSYS Icepak
and mapped into a regression-based ROM implemented in MATLAB.

The ROM enables instant prediction of:

- Maximum die temperature
- Heat flow
- Heat flux
- Thermal resistance
- Effective heat transfer coefficient

without rerunning CFD.

---

## Objectives

- Perform parametric conjugate heat transfer simulations
- Extract maximum die temperature and heat flow
- Build a multi-input ROM using MATLAB regression
- Predict temperature and heat flux
- Automatically compute thermal resistance and effective heat transfer coefficient
- Enable rapid thermal assessment without CFD

---

## System Description

The thermal model consists of:

- Silicon die
- Integrated heat spreader
- Cold plate
- Surrounding air domain

Physics included:

- Solid conduction
- Forced convection
- Conjugate heat transfer

---

## Parametric CFD Setup

### Inputs

- Die Power (P): 100–400 W  
- Inlet Air Velocity (V): 5–15 m/s  

### Boundary Conditions

- Die: volumetric heat generation  
- Inlet: specified velocity  
- Outlet: pressure outlet  
- Cold plate: fixed temperature  

Multiple operating points were solved and exported as CSV for ROM training.

---

## Reduced Order Model (ROM)

Linear least-squares regression:

Temperature model:

T = aP + bV + c

Heat flow model:

Q = aqP + bqV + cq

---

## Derived Thermal Quantities

Heat flux:

q'' = Q / A

Thermal resistance:

Rth = (T_die − T_plate) / P

Effective heat transfer coefficient:

h = q'' / (T_die − T_air)

---

## Sample Prediction

For:

Power = 180 W  
Velocity = 12 m/s  

Predicted results:

- Die Temperature ≈ 43.8 °C  
- Heat Flux ≈ 7.6 × 10³ W/m²  
- Thermal Resistance ≈ 0.0768 K/W  
- Effective h ≈ 405 W/m²K

- ## Key Learning Outcomes

- Electronics cooling using CFD
- Parametric simulation workflow
- Reduced Order Modeling
- MATLAB regression
- Thermal resistance extraction
- Heat transfer coefficient estimation

---

## Applications

- Semiconductor thermal design
- Fast cooling evaluation
- Early-stage package optimization
- ROM-based digital twins

---

## Future Work

- Nonlinear ROM
- Machine-learning based ROM
- Sensitivity analysis
- Cooling optimization
- Experimental validation


---
