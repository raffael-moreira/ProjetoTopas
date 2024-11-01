library(ggplot2)

# Dimensões das placas e círculos
largura_placa <- 85.18  # mm
altura_placa <- 125.76  # mm
raio_circulo <- 3.375   # mm
espaco_entre_circulos <- 2.23  # mm

# Posições iniciais das placas
x_start <- 0
y_start <- 0
placas <- expand.grid(x = c(x_start, x_start + largura_placa), 
                      y = c(y_start, y_start + altura_placa))

# Criar um data frame para os círculos
circulos <- data.frame()

# Gerar as posições dos círculos para cada placa
for (i in 0:1) {
  for (j in 0:1) {
    # Calcula o deslocamento para cada placa
    x_offset <- i * largura_placa
    y_offset <- j * altura_placa
    
    # Coordenadas dos círculos dentro da placa
    for (col in 0:7) {
      for (lin in 0:11) {
        x_circulo <- 12.115 + col * (raio_circulo * 2 + espaco_entre_circulos) + x_offset
        y_circulo <- 13.115 + lin * (raio_circulo * 2 + espaco_entre_circulos) + y_offset
        circulos <- rbind(circulos, data.frame(x = x_circulo, y = y_circulo))
      }
    }
  }
}

# Criar a imagem de fundo
ggplot() +
  # Desenhar placas
  geom_rect(aes(xmin = 0, xmax = largura_placa * 2, ymin = 0, ymax = altura_placa * 2),
            fill = NA, color = "black", size = 1) +
  
  # Desenhar círculos com contorno
  geom_point(data = circulos, aes(x = x, y = y), shape = 1, size = 4, color = "black") +
  
  # Definir limites e tema
  xlim(-5, largura_placa * 2 + 5) +
  ylim(-5, altura_placa * 2 + 5) +
  theme_minimal() +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  labs(title = "Placas com Círculos", x = "Largura (mm)", y = "Altura (mm)")

# Salvar a imagem
ggsave("imagem_placas_circulos.png", width = 170.36 / 25.4, height = 251.52 / 25.4, dpi = 300)
getwd()
