# Static Aeroelasticity & Aircraft Trim Analysis

This MATLAB project investigates the impact of structural flexibility on the longitudinal equilibrium (trim) of a symmetric aircraft. It compares a rigid-body model with a flexible-body model to evaluate how elastic deformations alter trim parameters and control effectiveness.

## Key Features
- **Rigid vs. Flexible Comparison**: Analysis of trim incidence ($\alpha$) and elevator deflection ($\eta$) for a load factor $n=1.9$.
- **Aerodynamic Derivatives**: Computation of stability and control derivatives accounting for aeroelastic effects.
- **Structural Modeling**: Implementation of fuselage and wing bending modes using generalized coordinates.
- **Visualizations**: Scripts for plotting trim variations over a range of natural frequencies and 3D-like views of the deformed aircraft (Front/Side views).

## Project Structure
- `Pgm_H1_Rigid_Aircraft_Data.m`: Defines mass properties and geometry.
- `Pgm_H2_Flexible_Aircraft_Data.m`: Defines modal shapes and structural stiffness.
- `Pgm_H4_Aero_Derivatives.m`: Computes aerodynamic derivatives (Z and M derivatives).
- `Pgm_H5_Equilibrium_Manoeuvres.m`: Main solver for the equilibrium equations.
- `AircraftViews.m`: Generates visual representations of the deformed structure.
- `ReportPlots.m`: Automated generation of technical plots for the aeroelastic report.

## Results
The solver demonstrates that structural flexibility typically requires higher trim incidence and different elevator deflections compared to the rigid case, especially near critical modal frequencies. The project includes:
- Generalized elastic coordinate evaluation.
- Wing and fuselage deflection profiles.
- Variation of trim angles over the natural frequency range.
