library(dplyr)
library(janitor)
library(readxl)

# cargar
cut_comuna_0 <- read_xls("datos/datos_originales/CUT_2018_v04.xls")

cut_comuna_1 <- cut_comuna_0 |> 
  clean_names() |> 
  rename(codigo_comuna = codigo_comuna_2018) 

# corregir comunas
cut_comuna_2 <- cut_comuna_1 |> 
  mutate(nombre_comuna = recode(nombre_comuna,
                                "Los Alamos" = "Los Álamos",
                                "Los Angeles" = "Los Ángeles",
                                "Treguaco" = "Trehuaco"))

# guardar versión csv
readr::write_csv2(cut_comuna_2, "datos/cut_comuna.csv")

# guardar versión R
cut_comuna_3 <- cut_comuna_2 |> 
  select(-abreviatura_region, -ends_with("provincia")) |> 
  mutate(across(starts_with("codigo"), as.numeric)) |> 
  # ordenar regiones geográficamente
  mutate(nombre_region = factor(nombre_region,
                                levels = c("Arica y Parinacota",
                                           "Tarapacá",
                                           "Antofagasta",
                                           "Atacama",
                                           "Coquimbo",
                                           "Valparaíso",
                                           "Metropolitana de Santiago",
                                           "Libertador General Bernardo O'Higgins",
                                           "Maule",
                                           "Ñuble",
                                           "Biobío",
                                           "La Araucanía",
                                           "Los Ríos",
                                           "Los Lagos",
                                           "Aysén del General Carlos Ibáñez del Campo",
                                           "Magallanes y de la Antártica Chilena")))

readr::write_rds(cut_comuna_3, "datos/cut_comuna.rds")
