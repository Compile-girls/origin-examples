
# Arquivo: metodos_e_parametros.rb
# Tema: Métodos e parâmetros
# Aplicação: Sistema interativo de emissão de recibos.
#
# Objetivo:
# Demonstrar métodos, retorno implícito, parâmetros
# posicionais, valores padrão, parâmetros nomeados,
# argumentos variáveis e blocos.
#
# Execução:
# ruby metodos_e_parametros.rb

# Método com parâmetros posicionais.
def calcular_total(preco, quantidade)
  preco * quantidade
end

# Método com parâmetro de valor padrão.
def calcular_desconto(total, percentual = 10)
  total * percentual / 100.0
end

# Método com parâmetros nomeados e valores padrão.
def gerar_resumo(produto:, quantidade:, preco:, moeda: "R$")
  total = calcular_total(preco, quantidade)

  puts "\n=== Resumo do recibo ==="
  puts "Produto: #{produto}"
  puts "Quantidade: #{quantidade}"
  puts "Preço unitário: #{moeda} #{format('%.2f', preco)}"
  puts "Total: #{moeda} #{format('%.2f', total)}"
end

# Método com quantidade variável de argumentos.
def listar_produtos(*produtos)
  puts "\n=== Produtos cadastrados ==="

  produtos.each do |produto|
    puts "- #{produto}"
  end
end

# Método com opções nomeadas adicionais.
def configurar_recibo(**opcoes)
  puts "\n=== Configurações do recibo ==="

  opcoes.each do |chave, valor|
    puts "#{chave}: #{valor}"
  end
end

# Método que recebe um bloco e pode executá-lo com yield.
def emitir_recibo(total)
  puts "\nRecibo emitido com sucesso!"

  yield(total) if block_given?
end

# Retorno implícito: retorna a última expressão.
def mensagem_final
  "Todos os dados foram processados."
end

puts "=== Sistema de emissão de recibos ==="

# Entrada dos dados do produto.
print "Digite o nome do produto: "
produto = gets.chomp

print "Digite o preço unitário: R$ "
preco = gets.chomp.to_f

print "Digite a quantidade: "
quantidade = gets.chomp.to_i

# Entrada do percentual de desconto.
print "Digite o percentual de desconto (Enter para 10%): "
entrada_desconto = gets.chomp

percentual = if entrada_desconto.empty?
  10
else
  entrada_desconto.to_f
end

# Entrada da forma de pagamento.
print "Digite a forma de pagamento: "
forma_pagamento = gets.chomp

# Entrada de outros produtos para demonstrar *produtos.
print "Digite outros produtos disponíveis, separados por vírgula: "
entrada_produtos = gets.chomp

outros_produtos = entrada_produtos
  .split(",")
  .map(&:strip)
  .reject(&:empty?)

# Cálculos usando métodos.
total = calcular_total(preco, quantidade)
desconto = calcular_desconto(total, percentual)
total_final = total - desconto

# Demonstração de parâmetros nomeados.
gerar_resumo(
  produto: produto,
  quantidade: quantidade,
  preco: preco
)

puts "Percentual de desconto: #{percentual}%"
puts "Valor do desconto: R$ #{format('%.2f', desconto)}"
puts "Total com desconto: R$ #{format('%.2f', total_final)}"

# Demonstração de argumentos posicionais variáveis.
listar_produtos(produto, *outros_produtos)

# Demonstração de opções nomeadas variáveis.
configurar_recibo(
  forma_pagamento: forma_pagamento,
  percentual_desconto: percentual,
  status: "Processado"
)

# Demonstração de bloco passado para o método.
emitir_recibo(total_final) do |valor|
  puts "Valor registrado no fechamento: R$ #{format('%.2f', valor)}"
end

puts "\n#{mensagem_final}"
