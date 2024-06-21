# Survival Analysis of House Sparrows

## Overview
This project analyzes the relationship between the survival rates of English sparrows and their morphological attributes using the Bumpus 1898 dataset. The analysis employs logistic linear models to predict survival based on various physical characteristics.

## Data
The dataset includes information on 136 sparrows, covering:
- Total Length
- Alar Extent
- Weight
- Beak to Head Length
- Length of Humerus
- Femur
- Tibiotarsus
- Skull Width
- Sternum
- Sex
- Survival status

## Methods
- Exploratory Data Analysis (EDA) using graphical and numerical summaries
- Logistic regression models (Generalized Linear Models in R)
- Model selection using Stepwise Akaike Information Criterion (stepAIC)
- Likelihood ratio tests for model comparison
- Assessment of model fit using Pearson's Residual plots.

For detailed information and analysis, refer to the report `bumpus_analysis_report.pdf`

## Files
- `bumpus.txt`: Dataset with measurements of house sparrows.
- `bumpus_analysis.R`: R script for data analysis.
- `bumpus_analysis_report.pdf`: Detailed analysis report.

## Instructions
1. Ensure you have the necessary R libraries installed:
    ```R
    install.packages(c("lmtest", "MASS"))
    ```
2. Run the R script to perform the analysis:
    ```R
    source('bumpus_analysis.R')
    ```
3. Refer to the report for detailed insights and conclusions from the analysis.

## Author
Aaminah Irfan

## Note
This project was completed as part of the STAT2402 university course assignment.
