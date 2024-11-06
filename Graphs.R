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

# Set the directory where your datasets are located (this is mine)
setwd("C:/Users/sofia/Desktop/Mujeres")

# Load the datasets
femicide_rate <- read.csv("Tasa_bruta_homicidio.csv", encoding = "latin1")
income_gap_men_women <- read.csv("tdr05_brecha_hom_muj.csv", encoding = "latin1")
violence_aggressor <- read.csv("Violencia_cualquier_agresor_largo_de_su_vida.csv", encoding = "latin1")
women_in_executive_positions <- read.csv("MujeresEnPuestosDirectivos.csv", encoding = "latin1")

# Basic cleaning for each dataset
datasets <- list(perception_of_insecurity, femicide_rate, income_gap_men_women, violence_help, 
                 violence_aggressor, physical_sexual_violence, lifetime_violence, public_sector_executives, 
                 women_in_executive_positions, women_without_income)

# Perform basic cleaning (remove empty rows and columns)
datasets_cleaned <- lapply(datasets, function(df) {
  df <- df[complete.cases(df), ]   # Remove rows with NA values
  df <- df[, colSums(is.na(df)) < nrow(df)] # Remove completely empty columns
  return(df)
})

# Assign the cleaned datasets back to the original variables
perception_of_insecurity <- datasets_cleaned[[1]]
femicide_rate <- datasets_cleaned[[2]]
income_gap_men_women <- datasets_cleaned[[3]]
violence_help <- datasets_cleaned[[4]]
violence_aggressor <- datasets_cleaned[[5]]
physical_sexual_violence <- datasets_cleaned[[6]]
lifetime_violence <- datasets_cleaned[[7]]
public_sector_executives <- datasets_cleaned[[8]]
women_in_executive_positions <- datasets_cleaned[[9]]
women_without_income <- datasets_cleaned[[10]]

###########################################

# Check column names
names(income_gap_men_women)

# Ensure correct columns for men's and women's income
income_gap_men_women$Income_Women <- as.numeric(income_gap_men_women$Ingreso.promedio.por.hora.trabajada.de.la.población.ocupada.de.mujeres)
income_gap_men_women$Income_Men <- as.numeric(income_gap_men_women$Ingreso.promedio.por.hora.trabajada.de.la.población.ocupada.de.hombres)

# Define the regions and assign each state to a region
regions <- list(
  North = c("Baja California", "Sonora", "Chihuahua", "Coahuila de Zaragoza", "Nuevo León", "Tamaulipas"),
  Center = c("Aguascalientes", "San Luis Potosí", "Guanajuato", "Querétaro", "Hidalgo", "Estado de México", "Ciudad de México", "Morelos"),
  South = c("Michoacán", "Guerrero", "Oaxaca", "Puebla", "Tlaxcala"),
  Southeast = c("Veracruz", "Tabasco", "Campeche", "Yucatán", "Quintana Roo", "Chiapas")
)

# Create a new column in the dataset to assign each state to a region
income_gap_men_women$Region <- sapply(income_gap_men_women$Entidad.federativa, function(state) {
  if (state %in% regions$North) return("North")
  if (state %in% regions$Center) return("Center")
  if (state %in% regions$South) return("South")
  if (state %in% regions$Southeast) return("Southeast")
  return(NA)
})

# Filter data to remove any state without a region assignment
income_gap_men_women <- income_gap_men_women[!is.na(income_gap_men_women$Region), ]

ggplot(income_gap_men_women, aes(x = Periodo)) +
  geom_line(aes(y = Income_Women, color = Region, linetype = "Women"), linewidth = 1.2) +
  geom_line(aes(y = Income_Men, color = Region, linetype = "Men"), linewidth = 1.2) +
  labs(title = "Evolution of Average Income of Men and Women by Region",
       x = "Year",
       y = "Average Income",
       color = "Region",
       linetype = "Gender") +
  theme_minimal() +
  theme(legend.position = "bottom")

###########################################

names(women_in_executive_positions)

# Rename the column X._women for clarity
colnames(women_in_executive_positions)[colnames(women_in_executive_positions) == "X._mujeres"] <- "Leadership_Percentage"

# Convert the percentage of women in leadership positions column to numeric
women_in_executive_positions$Leadership_Percentage <- as.numeric(women_in_executive_positions$Leadership_Percentage)

# Assign each state to a region using the previously defined list of regions
women_in_executive_positions$Region <- sapply(women_in_executive_positions$Entidad.federativa, function(state) {
  if (state %in% regions$North) return("North")
  if (state %in% regions$Center) return("Center")
  if (state %in% regions$South) return("South")
  if (state %in% regions$Southeast) return("Southeast")
  return(NA)
})

# Filter data to remove any state without a region assignment
women_in_executive_positions <- women_in_executive_positions[!is.na(women_in_executive_positions$Region), ]

# Calculate the average percentage of women in leadership by region and year
regional_women_in_executive_positions <- aggregate(Leadership_Percentage ~ Año + Region, data = women_in_executive_positions, FUN = mean)

ggplot(regional_women_in_executive_positions, aes(x = Año, y = Leadership_Percentage, color = Region)) +
  geom_line(size = 1.2) +
  labs(title = "Evolution of the Percentage of Women in Leadership Positions by Region",
       x = "Year",
       y = "Percentage of Women in Leadership (%)",
       color = "Region") +
  theme_minimal() +
  theme(legend.position = "bottom")

###########################################

names(violence_aggressor)

# Obtain Mexico's map at the state level
mexico_map <- ne_states(country = "Mexico", returnclass = "sf")

# Convert state names to uppercase to ensure consistency
mexico_map$name <- toupper(mexico_map$name)

unique(mexico_map$name)

# Convert to uppercase in `violence_aggressor`
violence_aggressor$Entidad.federativa <- toupper(violence_aggressor$Entidad.federativa)

# Join the violence index with Mexico's map
map_data <- mexico_map %>%
  left_join(violence_aggressor, by = c("name" = "Entidad.federativa"))

# Change specific names to match the map
violence_aggressor$Entidad.federativa <- gsub("MICHOACÁN DE OCAMPO", "MICHOACÁN", violence_aggressor$Entidad.federativa)
violence_aggressor$Entidad.federativa <- gsub("VERACRUZ DE IGNACIO DE LA LLAVE", "VERACRUZ", violence_aggressor$Entidad.federativa)
violence_aggressor$Entidad.federativa <- gsub("COAHUILA DE ZARAGOZA", "COAHUILA", violence_aggressor$Entidad.federativa)
violence_aggressor$Entidad.federativa <- gsub("CIUDAD DE MÉXICO", "DISTRITO FEDERAL", violence_aggressor$Entidad.federativa)
violence_aggressor$Entidad.federativa <- gsub("SAN LUIS POTOSÍ", "SAN LUIS POTOSÍ", violence_aggressor$Entidad.federativa)

# Create a heatmap using the `X2016` column
ggplot(data = map_data) +
  geom_sf(aes(fill = X2016), color = "black", lwd = 0.2) +
  labs(title = "Violence Heat Map by State in Mexico",
       subtitle = "Average Violence Index by State in 2016",
       fill = "Violence Index") +
  scale_fill_gradient(low = "yellow", high = "red", na.value = "grey50") +  # Optional: change na.value if you want a different color for NA values
  theme_minimal() +
  theme(panel.background = element_rect(fill = "white"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

###########################################

names(femicide_rate)

# Filter data for the most recent year available
femicide_rate <- femicide_rate %>% 
  filter(Año == max(Año))

# Calculate the national average homicide rate
national_average <- mean(femicide_rate$Tasa)

# Create a column to highlight states above the average
femicide_rate <- femicide_rate %>%
  mutate(Above_Average = ifelse(Tasa > national_average, "Above Average", "Below Average"))

# Replace "Veracruz de Ignacio de la Llave" with "Veracruz" in the dataframe
femicide_rate <- femicide_rate %>%
  mutate(Entidad = ifelse(Entidad == "Veracruz de Ignacio de la Llave", "Veracruz", Entidad))

# Bar chart
ggplot(femicide_rate, aes(x = reorder(Entidad, Tasa), y = Tasa, fill = Above_Average)) +
  geom_bar(stat = "identity") +
  geom_hline(yintercept = national_average, linetype = "dashed", color = "red") +
  labs(
    title = "Comparison of Femicide Rate by State Against National Average",
    subtitle = "Highlighting states with femicide rates above the 2019 average",
    x = "Entity",
    y = "Homicide Rate",
    fill = "Comparison"
  ) +
  scale_fill_manual(values = c("Above Average" = "red", "Below Average" = "lightblue")) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  annotate("text", x = 1, y = national_average, label = paste("National Average:", round(national_average, 2)), 
           vjust = -1, color = "red", size = 3)