# Olympic Athletes Analysis Project

## Overview
This project analyzes historical Olympic data, focusing on medal achievements related to athletes' countries and sporting events. The analysis aims to derive actionable insights for strategic decision-making in sports investments, policy development, and understanding the relationship between economic factors and Olympic success.

## Objectives
1. Design and implement a data warehouse using dimensional modelling techniques
2. Perform ETL (Extract, Transform, Load) processes to prepare the data for analysis
3. Conduct multi-dimensional analysis using OLAP cubes
4. Visualize query results using Power BI
5. Apply association rule mining to uncover patterns in Olympic performance
6. Analyze the relationship between economic factors and Olympic success

## Data Sources
- Olympic hosts and medals data: Olympic Summer & Winter Games, 1896-2022
- Mental illness and life expectancy data: Our World in Data
- Global Population data: International Monetary Fund (IMF)
- Economic data: World Development Indicators
- Countries by continent: World Population Review

Note: All datasets have been modified from their original sources for this project.

## Tools and Technologies
- Python: For data cleaning, transformation, and analysis
- PostgreSQL: For database management and SQL queries
- Atoti: For multi-dimensional analysis and OLAP cube creation
- Power BI: For data visualization
- mlxtend: For association rule mining

## Setup and Execution
1. Clone this repository
2. Create a `.env` file in the project root with the following content:
   - `DB_NAME=your_database_name`
   - `DB_USER=your_username`
   - `DB_PASSWORD=your_password`
   - `DB_HOST=your_host`
   - `DB_PORT=your_port`
3. Extract code from the following files and run them in the order:
     - Contains code on ETL processes: `dw_project1.ipynb`
     - Contains code on Cube creation and multi-dimensional analysis: `cube.ipynb`
     - Contains code on  association rule mining: `apriorialgo.ipynb`
     - Contains SQL code on database creation and SQL Queries: `SQL CODE.txt`

## Author and Contributors
Aaminah Irfan
