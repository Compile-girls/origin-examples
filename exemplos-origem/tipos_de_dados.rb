# Arquivo: 02_tipos_de_dados.rb
# Tema: Tipos de dados em Ruby
# Aplicação: Cadastro e verificação das propriedades de um produto em estoque.
#
# Objetivo:
# Demonstrar os principais tipos primitivos em Ruby (String, Integer, Float, Symbol, Boolean e NilClass),
# além da verificação dinâmica de tipos com o método .class.
#
# Execução:
# ruby 02_tipos_de_dados.rb

# Declarando variáveis de diferentes tipos de dados
nome_produto = "Teclado Mecânico"  # String
quantidade_estoque = 15            # Integer (Número inteiro)
preco_unitario = 250.50            # Float (Número decimal)
categoria_id = :eletronicos        # Symbol (Identificador único e imutável, economiza memória)
em_promocao = true                 # TrueClass (Booleano)
desconto_aplicado = nil            # NilClass (Representa a ausência de valor)

puts "=== Detalhes do Produto ==="
puts "Produto: #{nome_produto}"
puts "Estoque: #{quantidade_estoque}"
puts "Preço: R$ #{preco_unitario}"
puts "Categoria (Symbol): #{categoria_id}"
puts "Em Promoção?: #{em_promocao}"
puts "Desconto: #{desconto_aplicado.inspect}"

# Em Ruby, tudo é objeto! Usamos o método '.class' para identificar o tipo do dado.
puts "\n=== Verificação dos Tipos de Dados (.class) ==="
puts "nome_produto é da classe: #{nome_produto.class}"
puts "quantidade_estoque é da classe: #{quantidade_estoque.class}"
puts "preco_unitario é da classe: #{preco_unitario.class}"
puts "categoria_id é da classe: #{categoria_id.class}"
puts "em_promocao é da classe: #{em_promocao.class}"
puts "desconto_aplicado é da classe: #{desconto_aplicado.class}"