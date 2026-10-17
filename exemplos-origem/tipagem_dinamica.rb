
# Arquivo: tipagem_dinamica.rb
# Tema: Tipagem dinâmica
# Aplicação: Sistema de registro de pagamentos.
#
# Objetivo:
# Demonstrar como uma variável pode referenciar objetos
# de diferentes tipos durante a execução de um programa Ruby.
#
# Execução:
# ruby tipagem_dinamica.rb

def exibir_dado(nome, valor)
  puts "#{nome}: #{valor.inspect}"
  puts "Classe do objeto: #{valor.class}"
  puts
end

puts "=== Sistema de registro de pagamentos ==="
puts

# 1. A variável armazena um valor numérico.
# Ruby identifica o objeto como Integer.
pagamento = 150

puts "--- Etapa 1: Valor da compra ---"
exibir_dado("Pagamento", pagamento)

# 2. A mesma variável passa a referenciar um Float.
# Não é necessário declarar um novo tipo para a variável.
pagamento = 150.75

puts "--- Etapa 2: Valor atualizado ---"
exibir_dado("Pagamento", pagamento)

# 3. Agora, a variável armazena uma String.
# O conteúdo passa a representar o status do pagamento.
pagamento = "Aguardando confirmação"

puts "--- Etapa 3: Status do pagamento ---"
exibir_dado("Pagamento", pagamento)

# 4. Por fim, a variável recebe um valor booleano.
# Esse valor indica se o pagamento foi aprovado.
pagamento = true

puts "--- Etapa 4: Confirmação do pagamento ---"
exibir_dado("Pagamento aprovado", pagamento)

puts "Processamento finalizado!"
