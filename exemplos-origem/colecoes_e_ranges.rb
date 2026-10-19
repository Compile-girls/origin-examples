# Arquivo: 03_colecoes_e_ranges.rb
# Tema: Arrays, Hashes e Ranges
# Aplicação: Gerenciamento de carrinho de compras, dados de cliente e faixas de desconto.
#
# Objetivo:
# Demonstrar a criação e manipulação das coleções estruturadas (Arrays e Hashes)
# e do recurso de intervalos (Ranges) em Ruby.
#
# Execução:
# ruby 03_colecoes_e_ranges.rb

# 1. ARRAYS (Listas ordenadas)
# Utilizado para armazenar coleções sequenciais de itens.
produtos = ["Notebook", "Mouse", "Headset"]
puts "=== Lista de Produtos (Array) ==="
puts "Produtos iniciais: #{produtos.join(', ')}"

# Adicionando um novo item ao Array com o operador '<<' (push)
produtos << "Teclado"
puts "Após adicionar item: #{produtos.inspect}"
puts "Primeiro produto: #{produtos.first}"
puts "Quantidade total de produtos: #{produtos.size}"

# 2. HASHES (Dicionários de Chave/Valor)
# Utilizado para mapear dados estruturados.
cliente = {
  nome: "Lucas Silva",
  email: "lucas@email.com",
  compras_realizadas: 12
}

puts "\n=== Dados do Cliente (Hash) ==="
# Acessando valores através das chaves (Symbols)
puts "Nome: #{cliente[:nome]}"
puts "E-mail: #{cliente[:email]}"
puts "Total de Compras: #{cliente[:compras_realizadas]}"

# 3. RANGES (Intervalos)
# Utilizado para definir faixas numéricas ou de caracteres.
faixa_desconto_vip = 10..50 # Intervalo inclusivo de 10 a 50
pontos_cliente = 25

puts "\n=== Validação de Desconto (Range) ==="
puts "Faixa de pontos para VIP: #{faixa_desconto_vip}"
# O método 'cover?' ou 'include?' verifica se o valor está contido no intervalo
if faixa_desconto_vip.cover?(pontos_cliente)
  puts "O cliente possui #{pontos_cliente} pontos e está ELEGÍVEL para desconto VIP!"
else
  puts "O cliente não atingiu a pontuação mínima."
end