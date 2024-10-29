dir <- "/home/raffaelmoreira/topas/mysim/Output/energia"
energia_csv <- list.files(path = dir, pattern = "*.csv", full.names = TRUE)
dados1 <- energia_csv %>%
  map_dfr(read_csv)
write_csv(dados1, "/home/raffaelmoreira/topas/mysim/Output/agrupado/energia.csv")

dir <- "/home/raffaelmoreira/topas/mysim/Output/histdose"
dose_csv <- list.files(path = dir, pattern = "*.csv", full.names = TRUE)
dados2 <- dose_csv %>%
  map_dfr(read_csv)
write_csv(dados2, "/home/raffaelmoreira/topas/mysim/Output/agrupado/dose.csv")
