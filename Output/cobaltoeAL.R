library(ggplot2)

# Definir caminhos dos arquivos e ajustar cabeçalho (rodar apenas uma vez)
arquivos <- c(
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada11_Run_0.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada21_Run_0.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada31_Run_0.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada41_Run_0.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada11_Run_1.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada21_Run_1.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada31_Run_1.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada41_Run_1.csv"
)

ajustar_cabecalho <- function(caminho) {
  conteudo <- readLines(caminho)
  novo_cabecalho <- c("X, Y, Z, Dose")
  conteudo_modificado <- c(novo_cabecalho, conteudo[-(1:8)])
  writeLines(conteudo_modificado, caminho)
}

# Ajustar cabeçalhos em todos os arquivos
lapply(arquivos, ajustar_cabecalho)

# Carregar dados em uma lista de data frames
dados_camadas <- lapply(arquivos, read.csv)

# Função para plotar mapa de calor
plotar_mapa_calor <- function(data, camada) {
  ggplot(data, aes(x = X, y = Y, fill = Dose)) +
    geom_raster() +
    scale_fill_gradient(low = "blue", high = "red") +
    labs(x = "Coordenada X", y = "Coordenada Y", fill = paste("Dose Camada", camada)) +
    theme_minimal() +
    coord_fixed()
}

# Gerar os gráficos de mapa de calor para cada camada
mapa_calor_camadas <- lapply(1:length(dados_camadas), function(i) {
  plotar_mapa_calor(dados_camadas[[i]], i)
})

# Exibir os gráficos
print(mapa_calor_camadas[[1]])
print(mapa_calor_camadas[[2]])
print(mapa_calor_camadas[[3]])
print(mapa_calor_camadas[[4]])
print(mapa_calor_camadas[[5]])
print(mapa_calor_camadas[[6]])
print(mapa_calor_camadas[[7]])
print(mapa_calor_camadas[[8]])
grid.arrange(grobs = mapa_calor_camadas, ncol = 2)
