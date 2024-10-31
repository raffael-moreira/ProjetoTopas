# Valores para TransX e TransY conforme especificado
transX_vals <- c(-74.52, -65.54, -56.56, -47.58, -38.6, -29.62, -20.64, -11.66, 11.66, 20.64, 29.62, 38.6, 47.58, 56.56, 65.54, 74.52)
transY_vals <- c(-112.27, -103.29, -94.31, -85.33, -76.35, -67.37, -58.39, -49.41, -40.51, -31.53, -22.55, -13.54, 
                 13.54, 22.55, 31.53, 40.51, 49.41, 58.39, 67.37, 76.35, 85.33, 94.31, 103.29, 112.27)

# Nome do arquivo
arquivo_saida <- "poços_configuração.txt"

# Abre o arquivo
sink(arquivo_saida)

# Loop para gerar as linhas do arquivo
for (linha in 1:length(transX_vals)) {
  for (coluna in 1:length(transY_vals)) {
    # Nome do poço
    poco <- sprintf("Poco%de%d", linha, coluna)
    
    # Escrever os parâmetros
    cat(sprintf("s:Ge/%s/Material\t\t\t= \"G4_WATER\"\n", poco))
    cat(sprintf("s:Ge/%s/Parent\t\t\t= \"Camada1\"\n", poco))
    cat(sprintf("s:Ge/%s/Type\t\t\t= \"TsCylinder\"\n", poco))
    cat(sprintf("d:Ge/%s/RMax\t\t\t= 3.375 mm\n", poco))
    cat(sprintf("d:Ge/%s/RMin\t\t\t= 0. mm\n", poco))
    cat(sprintf("d:Ge/%s/HL\t\t\t= 5.455 mm\n", poco))
    cat(sprintf("d:Ge/%s/TransX\t\t\t= %.2f mm\n", poco, transX_vals[linha]))
    cat(sprintf("d:Ge/%s/TransY\t\t\t= %.2f mm\n", poco, transY_vals[coluna]))
    cat(sprintf("d:Ge/%s/TransZ\t\t\t= 1.785 mm\n\n", poco))
  }
}

# Fecha o arquivo
sink()

cat("Arquivo gerado com sucesso em", arquivo_saida, "\n")
