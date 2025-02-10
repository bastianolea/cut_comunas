cut_comuna <- readxl::read_xls("datos/datos_originales/CUT_2018_v04.xls") |> 
  janitor::clean_names() |> 
  dplyr::rename(codigo_comuna = codigo_comuna_2018) 

readr::write_csv2(cut_comuna, "cut_comuna.csv")

# library(pins)
# board <- board_folder("xxx")
# board |> pin_write(cut_comuna, "cut_comuna")
# board |> pin_read("cut_comuna")