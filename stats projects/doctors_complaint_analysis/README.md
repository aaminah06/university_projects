# Doctors' Complaint Analysis

## Overview
This project analyzes the relationship between the number of complaints against doctors in an emergency department and various demographic factors. The analysis employs several statistical models to predict complaint numbers based on these factors.

## Data
The dataset includes information on 94 doctors, covering:
- Number of complaints
- Number of patient visits
- Residency training status
- Gender
- Hourly income
- Total hours worked

## Methods
Five different Poisson models were fitted and compared:
1. Poisson Model
2. Quasi-Poisson Model
3. Negative Binomial Poisson (NBP) Model
4. Zero-Inflated Poisson Regression (ZIPR) Model
5. Zero-Inflated Negative Binomial (ZINB) Model

Models were evaluated using AIC, dispersion tests, rootograms, and Pearson's Residual Plots. For more detailed information and analysis refer to the report `doctors_complaint_analysis.pdf`.

## Files
- `doctors_complaint_analysis.pdf`: Full report including methodology, results, discussion, and code appendix
- `compdat.txt`: Dataset used for the analysis

## Tools Used
```R
    install.packages(c("pscl", "AER", "MASS", "vcd", "countreg"))
 ```


## Author
Aaminah Irfan

## Note
This project was completed as part of the STAT2402 course examination.
