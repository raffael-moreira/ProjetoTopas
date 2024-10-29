# Define as dimensões da matriz
rows <- 12
cols <- 8

# Nome do arquivo
file_name <- "PocoAeB_file.txt"

# Abre o arquivo para escrita
file_conn <- file(file_name, open = "wt")

# Loop pelas linhas e colunas da matriz
for (i in 1:rows) {
  for (j in 1:cols) {
    # Escreve os parâmetros no formato PocoAeB
    writeLines(sprintf("i:Ge/34Poco%de%d/RBins    = 3", i, j), file_conn)
    writeLines(sprintf("i:Ge/34Poco%de%d/PhiBins  = 3", i, j), file_conn)
    writeLines(sprintf("i:Ge/34Poco%de%d/ZBins    = 3", i, j), file_conn)
    writeLines("", file_conn) # Linha em branco entre os conjuntos
  }
}

# Fecha a conexão com o arquivo
close(file_conn)

# Exibe uma mensagem de sucesso e mostra o conteúdo do arquivo no console
cat("Arquivo 'PocoAeB_file.txt' gerado \n")
cat(readLines(file_name), sep = "\n")
