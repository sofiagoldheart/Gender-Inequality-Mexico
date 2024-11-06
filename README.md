# Gender Inequality Analysis in Mexico: Security, Income, and Regional Leadership

**Author:** Sofia Ruvalcaba de la Noval  
**Institution:** Universidad del Caribe, Cancún, Quintana Roo, Mexico  

## Overview

This project investigates gender inequality in Mexico across areas such as income, safety, and leadership representation by region. The analysis focuses on identifying the states that provide better conditions for women regarding security, income, and leadership opportunities. Using historical data, this project examines income disparities between men and women across regions, homicide and violence rates by state, and the presence of women in leadership roles.

### Key Objectives

1. **Identify Income Gaps:** Examine the evolution of income disparities between men and women.
2. **Analyze Violence and Homicide Rates:** Evaluate state-wise distribution of violence and homicide rates.
3. **Assess Female Leadership Participation:** Analyze the percentage change in leadership positions held by women over time.
4. **Identify Best States for Women:** Determine the top three states offering the most favorable conditions for women’s professional and personal development in Mexico.

## Methodology

The analysis follows an observational, descriptive approach using historical data from INMUJERES on gender inequality in Mexico. Data was meticulously cleaned to ensure consistency and accuracy, with empty rows/columns removed and state names adjusted for alignment across datasets and maps.

- **Income Gap Analysis:** Average hourly income for men and women was assessed, with confidence intervals for reliability. A line chart visualizes income trends across genders and regions.
- **Violence Index Mapping:** A heat map visualizes violence levels by state, highlighting areas with higher prevalence.
- **Homicide Rate Comparison:** A bar chart contrasts state homicide rates with the national average, highlighting disparities.
- **Female Leadership Trends:** Line charts illustrate the regional trends in women’s representation in leadership over time.

## Results and Discussion

This analysis reveals significant gender inequality in Mexico, particularly regarding income, security, and leadership representation:

- **Income Disparity:** The North and South regions show the highest male-favoring wage gaps, while the Center and Southeast exhibit smaller gaps or even slight advantages for women in certain cases.
- **Security and Violence:** The North reports the highest homicide rates, followed by the South and Center, while the Southeast is the safest. Violence indexes follow a similar trend, with the Center reporting the highest and the Southeast the lowest violence rates.
- **Female Leadership:** The North leads in female representation in executive positions, whereas the Southeast lags.

## Conclusions

This study highlights the varying levels of gender inequality across Mexico’s regions, impacting women’s equitable development. Although the Southeast and Center regions show lower income gaps and safer conditions, female leadership representation remains a challenge, particularly in the Southeast. Conversely, the North and South face higher wage inequalities and security issues. These findings emphasize the need for region-specific policies to promote wage equity, security, and female leadership, particularly in lagging areas, to foster women’s growth across all regions of Mexico.

## Installation

To replicate this analysis, the following R libraries are required. You can install them as follows:

```r
# Install and load necessary packages
if (!require("rnaturalearth")) install.packages("rnaturalearth")
if (!require("rnaturalearthdata")) install.packages("rnaturalearthdata")
if (!require("sf")) install.packages("sf")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")

# Load necessary libraries
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(ggplot2)
library(dplyr)
```
## References

1. *Brecha en el ingreso entre hombres y mujeres. Derecho al trabajo. Igualdad y no discriminación - datos.gob.mx/busca*. https://datos.gob.mx/busca/dataset/brecha-en-el-ingreso-entre-hombres-y-mujeres-derecho-al-trabajo-igualdad-y-no-discriminacion 
2. *Estadísticas de mujeres: indicadores de inclusión social, igualdad y empoderamiento - Personas en puestos directivos de la administración pública por sexo. - datos.gob.mx/busca*. https://datos.gob.mx/busca/dataset/estadisticas-de-mujeres-indicadores-de-inclusion-social-igualdad-y-empoderamiento/resource/0ed31ac0-c438-4938-8bc4-af4522c2234d 
3. *Estadísticas de mujeres: indicadores de inclusión social, igualdad y empoderamiento - Prevalencia de la violencia física y/o sexual contra las mujeres de 15 años y más, infligida por cualquier agresor a lo largo de su vida - datos.gob.mx/busca*. https://datos.gob.mx/busca/dataset/estadisticas-de-mujeres-indicadores-de-inclusion-social-igualdad-y-empoderamiento/resource/7ea46930-a647-4b26-9750-15fb67fafb8a 
4. *Estadísticas de mujeres: indicadores de inclusión social, igualdad y empoderamiento - Tasa bruta anual de defunciones por homicidio de mujeres - datos.gob.mx/busca*. https://datos.gob.mx/busca/dataset/estadisticas-de-mujeres-indicadores-de-inclusion-social-igualdad-y-empoderamiento/resource/d54ea5aa-418e-4640-9e3f-70f1d1d8f3b9 
