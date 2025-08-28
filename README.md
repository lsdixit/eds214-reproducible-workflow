# EDS 214: Reproducible Workflow

![Reproduced Figure 3](figs/figure-3.jpg)

## Background
This repository contains the code for the EDS 214 class project on reproducible workflows. This project is based on the paper by Schaefer et. al., assessing the effects of hurricane disturbance on stream water concentrations in the forest watersheds of Puerto Rico. We are reproducing figure 3 from the paper and documenting our workflow.

This work is done by Leela Dixit, in collaboration with Max Czapanskiy, Alessandra Vidal Meza, with help from the students of MEDS 2026.

[![DOI](https://www.cambridge.org/core/journals/journal-of-tropical-ecology/article/effects-of-hurricane-disturbance-on-stream-water-concentrations-and-fluxes-in-eight-tropical-forest-watersheds-of-the-luquillo-experimental-forest-puerto-rico/2511D4A53DA2C95406014ED75441E77B)](https://doi.org/10.1017/s0266467400001358)

# 1) Data
- [:file\_folder: data](/data_raw): raw data for all 4 sites sampled and used in reproduced figure.

- [:file\_folder: data](/data_clean): clean data following tidy, wrangling, and 9 week moving average calculation. These data were used in creation of the figure 3 plot.

# 2) Data Cleaning
- [:file\_folder: analysis](/data_cleaning): This script contains the loading and all combining and modifying of the 4 raw data files. 

# 3) Functions
- [:file\_folder: R](/moving_average): contains the function to calculate the 9 week moving average.
- [:file\_folder: R](/plot): contains the functions for creating the reproduced figure 3 plot.

# 4) Figures
- [:file\_folder: figs](/figure-3.jpg): final reproduced plot saved as a .jpg.