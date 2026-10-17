
# Arquivo: expressoes_e_operadores.rb
# Tema: Expressões e operadores
# Aplicação: Calculadora de compras de uma papelaria.
#
# Objetivo:
# Demonstrar operadores aritméticos, relacionais, lógicos
# e de atribuição, além de precedência e associatividade.
#
# Execução:
# ruby expressoes_e_operadores.rb

# Calcula o valor total de uma compra.
def calcular_subtotal(preco, quantidade)
  preco * quantidade
end

# Formata valores monetários para exibição.
def formatar_moeda(valor)
  "R$ #{format('%.2f', valor)}"
end

puts "=== Papelaria Ruby ==="
puts

# Dados da compra.
orcamento = 200.00
preco_caderno = 25.00
preco_caneta = 5.00

quantidade_cadernos = 4
quantidade_canetas = 6

# 1. OPERADORES ARITMÉTICOS
# Multiplicação, adição e subtração.
subtotal_cadernos = calcular_subtotal(
  preco_caderno, quantidade_cadernos
)

subtotal_canetas = calcular_subtotal(
  preco_caneta, quantidade_canetas
)

subtotal = subtotal_cadernos + subtotal_canetas

# O desconto é de 10% quando o subtotal alcança R$ 100.
desconto = subtotal >= 100 ? subtotal * 0.10 : 0.0

total = subtotal - desconto

puts "--- Resumo da compra ---"
puts "Cadernos: #{formatar_moeda(subtotal_cadernos)}"
puts "Canetas: #{formatar_moeda(subtotal_canetas)}"
puts "Subtotal: #{formatar_moeda(subtotal)}"
puts "Desconto: #{formatar_moeda(desconto)}"
puts "Total: #{formatar_moeda(total)}"
puts

# 2. OPERADORES RELACIONAIS
# Comparam valores e produzem true ou false.
cabe_no_orcamento = total <= orcamento
atingiu_desconto = subtotal >= 100
tem_valor_para_pagar = total > 0

puts "--- Verificação de valores ---"
puts "O total cabe no orçamento? #{cabe_no_orcamento}"
puts "A compra atingiu o desconto? #{atingiu_desconto}"
puts "Existe valor a pagar? #{tem_valor_para_pagar}"
puts

# 3. OPERADORES LÓGICOS
# && exige que ambas as condições sejam verdadeiras.
# || exige que pelo menos uma condição seja verdadeira.
# ! inverte o resultado lógico.
cliente_cadastrado = true
estoque_disponivel = true

compra_autorizada =
  cliente_cadastrado && estoque_disponivel && cabe_no_orcamento

compra_prioritaria =
  atingiu_desconto || total >= 150

puts "--- Decisão da compra ---"
puts "Compra autorizada? #{compra_autorizada}"
puts "Compra prioritária? #{compra_prioritaria}"
puts "Compra fora do orçamento? #{!cabe_no_orcamento}"
puts

# 4. OPERADORES DE ATRIBUIÇÃO
saldo = orcamento
saldo -= total
saldo += 10.00

puts "--- Atualização do saldo ---"
puts "Saldo após a compra e um crédito de R$ 10,00: "
puts formatar_moeda(saldo)
puts

# 5. PRECEDÊNCIA E ASSOCIATIVIDADE
# A multiplicação tem precedência sobre a adição.
resultado_1 = 10 + 5 * 2

# Os parênteses alteram a ordem de avaliação.
resultado_2 = (10 + 5) * 2

puts "--- Precedência dos operadores ---"
puts "10 + 5 * 2 = #{resultado_1}"
puts "(10 + 5) * 2 = #{resultado_2}"
puts

# 6. OUTROS OPERADORES ARITMÉTICOS
puts "--- Outras operações ---"
puts "Resto de 17 dividido por 5: #{17 % 5}"
puts "2 elevado à terceira potência: #{2**3}"
puts "Divisão inteira de 17 por 5: #{17 / 5}"
puts "Divisão decimal de 17 por 5: #{17.0 / 5}"
puts

# 7. RESULTADO FINAL
if compra_autorizada
  puts "Compra finalizada com sucesso!"
else
  puts "Compra não autorizada. Verifique as condições."
end
