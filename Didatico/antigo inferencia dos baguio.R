library(ggplot2)
library(gridExtra)
setwd("/home/raffaelmoreira/topas/mysim/Output/tratado")

# Definir caminhos dos arquivos com os novos nomes
arquivos <- c(
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada1_Run_0.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada2_Run_0.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada3_Run_0.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada4_Run_0.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada1_Run_1.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada2_Run_1.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada3_Run_1.csv",
  "/home/raffaelmoreira/topas/mysim/Output/dose/DoseCamada4_Run_1.csv"
)

# Função para ajustar cabeçalho, se necessário
ajustar_cabecalho <- function(caminho) {
  conteudo <- readLines(caminho)
  if (conteudo[1] != "X, Y, Z, Dose") {  # Checar se o cabeçalho já está ajustado
    novo_cabecalho <- c("X, Y, Z, Dose")
    conteudo_modificado <- c(novo_cabecalho, conteudo[-(1:8)])
    writeLines(conteudo_modificado, caminho)
  }
}

# Ajustar cabeçalhos em todos os arquivos
lapply(arquivos, ajustar_cabecalho)

# Carregar dados em uma lista de data frames
dados_camadas <- lapply(arquivos, read.csv)

# Função para plotar mapa de calor com título ajustado
plotar_mapa_calor <- function(data, camada, tipo) {
  ggplot(data, aes(x = X, y = Y, fill = Dose)) +
    geom_raster() +
    scale_fill_gradient(low = "blue", high = "red") +
    labs(x = "Coordenada X", y = "Coordenada Y", fill = "Dose") +
    ggtitle(paste("Camada", camada, "-", tipo)) +
    theme_minimal() +
    coord_fixed()
}

# Separar arquivos por tipo de radiação e camadas
tipos_radiacao <- c("AL", "Co-60")
mapa_calor_por_tipo <- list(AL = list(), Co60 = list())

# Loop para gerar gráficos e salvar individualmente
for (i in seq_along(arquivos)) {
  camada <- gsub(".*DoseCamada(\\d+)_.*", "\\1", arquivos[i])
  tipo_radiacao <- ifelse(grepl("Run_0", arquivos[i]), "AL", "Co-60")
  
  # Adicionar gráfico à lista correta
  grafico <- plotar_mapa_calor(dados_camadas[[i]], camada, tipo_radiacao)
  
  if (tipo_radiacao == "AL") {
    mapa_calor_por_tipo$AL[[camada]] <- grafico
    ggsave(paste0("Mapa_Camada_", camada, "_AL.png"), plot = grafico)
  } else {
    mapa_calor_por_tipo$Co60[[camada]] <- grafico
    ggsave(paste0("Mapa_Camada_", camada, "_Co60.png"), plot = grafico)
  }
}

# Agrupar e salvar os gráficos em uma grade para cada tipo de radiação
grid.arrange(grobs = mapa_calor_por_tipo$AL, ncol = 2)
ggsave("Mapa_Grade_AL.png", plot = arrangeGrob(grobs = mapa_calor_por_tipo$AL, ncol = 2))

grid.arrange(grobs = mapa_calor_por_tipo$Co60, ncol = 2)
ggsave("Mapa_Grade_Co60.png", plot = arrangeGrob(grobs = mapa_calor_por_tipo$Co60, ncol = 2))

# Mostrar gráficos para o tipo AL
for (i in seq_along(mapa_calor_por_tipo$AL)) {
  print(mapa_calor_por_tipo$AL[[i]])
}

# Mostrar gráficos para o tipo Co-60
for (i in seq_along(mapa_calor_por_tipo$Co60)) {
  print(mapa_calor_por_tipo$Co60[[i]])
}
