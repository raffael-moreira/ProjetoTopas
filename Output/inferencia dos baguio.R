library (ggplot2)
#Tratamento dos dados (RODAR SOMENTE UMA VEZ!!!!!)
arquivos <- c(
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada1.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada2.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada3.csv",
  "/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada4.csv"
)

ajustar_cabecalho <- function(caminho) {
  conteudo <- readLines(caminho) # Lê todo o conteúdo do arquivo como texto
  novo_cabecalho <- c("X, Y, Z, Dose") # Substitui as primeiras 8 linhas pelo novo cabeçalho
  conteudo_modificado <- c(novo_cabecalho, conteudo[-(1:8)]) # Substitui as primeiras 8 linhas pelo novo cabeçalho
  writeLines(conteudo_modificado, caminho)  # Salva o arquivo com o novo cabeçalho
}

lapply(arquivos, ajustar_cabecalho)# Aplica a função para cada arquivo na lista

#Inferência dos Dados
camada1 <- read.csv("/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada1.csv")

# Gráfico de mapa de calor
ggplot(camada1, aes(x = X, y = Y, fill = Dose)) +
  geom_raster() +  # Ou geom_raster() para maior eficiência em grandes datasets
  scale_fill_gradient(low = "blue", high = "red") +
  labs(x = "Coordenada X", y = "Coordenada Y", fill = "Dose Camada 1") +
  theme_minimal() +
  coord_fixed()  # Manter as proporções iguais para X e Y

camada2 <- read.csv("/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada2.csv")

# Gráfico de mapa de calor
ggplot(camada2, aes(x = X, y = Y, fill = Dose)) +
  geom_tile() +  # Ou geom_raster() para maior eficiência em grandes datasets
  scale_fill_gradient(low = "blue", high = "red") +  # Ajuste as cores conforme necessário
  labs(x = "Coordenada X", y = "Coordenada Y", fill = "Dose Camada 2") +
  theme_minimal() +
  coord_fixed()  # Manter as proporções iguais para X e Y

camada3 <- read.csv("/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada3.csv")

# Gráfico de mapa de calor
ggplot(camada3, aes(x = X, y = Y, fill = Dose)) +
  geom_tile() +  # Ou geom_raster() para maior eficiência em grandes datasets
  scale_fill_gradient(low = "blue", high = "red") +  # Ajuste as cores conforme necessário
  labs(x = "Coordenada X", y = "Coordenada Y", fill = "Dose Camada 3") +
  theme_minimal() +
  coord_fixed()  # Manter as proporções iguais para X e Y

camada4 <- read.csv("/home/topas/topas/ProjetoTopas/Output/dose/DoseCamada4.csv")

# Gráfico de mapa de calor
ggplot(camada4, aes(x = X, y = Y, fill = Dose)) +
  geom_tile() +  # Ou geom_raster() para maior eficiência em grandes datasets
  scale_fill_gradient(low = "blue", high = "red") +  # Ajuste as cores conforme necessário
  labs(x = "Coordenada X", y = "Coordenada Y", fill = "Dose Camada 4") +
  theme_minimal() +
  coord_fixed()  # Manter as proporções iguais para X e Y

