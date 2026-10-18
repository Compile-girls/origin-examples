# Arquivo: repeticao_e_controle_de_fluxo.rb
# Tema: Estruturas de repetição e controle de fluxo
# Aplicação: Sistema de processamento de pedidos de uma loja

# Objetivo:
# Demonstrar while, until, for, each, break, next e redo em situações de
# processamento de pedidos: percorrer pedidos, ignorar os cancelados,
# interromper o processamento quando necessário e repetir uma tentativa
# em uma situação controlada.

# Execução:
#   ruby repeticao_e_controle_de_fluxo.rb


puts "=== Sistema de Processamento de Pedidos ==="
puts

pedidos = [
  { id: 101, produto: "Teclado",  valor: 120.00,  status: "pago" },
  { id: 102, produto: "Mouse",    valor: 65.00,   status: "cancelado" },
  { id: 103, produto: "Monitor",  valor: 850.00,  status: "pago" },
  { id: 104, produto: "Headset",  valor: 180.00,  status: "pendente" },
  { id: 105, produto: "Notebook", valor: 3200.00, status: "pago" }
]

# 1. EACH + NEXT + BREAK
# EACH percorre os pedidos do lote.
# NEXT ignora os cancelados.
# BREAK interrompe o lote quando o limite de valor seria ultrapassado.
# Os pedidos seguintes não são avaliados, mesmo que algum coubesse no limite;
# é uma decisão da lógica da aplicação, não uma regra do Ruby.
puts "--- Processamento do lote (limite de R$ 1500,00) ---"

LIMITE_LOTE = 1500.00
total_lote = 0.0

pedidos.each do |pedido|
  next if pedido[:status] == "cancelado"

  if total_lote + pedido[:valor] > LIMITE_LOTE
    puts "Pedido ##{pedido[:id]} (#{pedido[:produto]}) excede o limite do lote."
    puts "Processamento do lote interrompido."
    break
  end

  total_lote += pedido[:valor]
  puts "Pedido ##{pedido[:id]}: #{pedido[:produto]} " \
       "- R$ #{format('%.2f', pedido[:valor])} (#{pedido[:status]})"
end

puts "Total processado no lote: R$ #{format('%.2f', total_lote)}"
puts

# 2. FOR
# Percorre os pedidos pagos para emitir a nota de separação.
# (select apenas prepara a lista de pedidos pagos; o foco aqui é o for.)
puts "--- Pedidos pagos para separação (for) ---"

pedidos_pagos = pedidos.select { |pedido| pedido[:status] == "pago" }

for pedido in pedidos_pagos
  puts "Separar: #{pedido[:produto]} (pedido ##{pedido[:id]})"
end

puts

# 3. WHILE
# Repete enquanto a condição for verdadeira.
# Aqui, tenta cobrar o pedido pendente até o pagamento ser aprovado
# ou até chegar a 5 tentativas.
puts "--- Tentativas de pagamento do pedido #104 (while) ---"

tentativas = 0
pagamento_aprovado = false

while !pagamento_aprovado && tentativas < 5
  tentativas += 1
  # Simulação: o pagamento só é aprovado na terceira tentativa.
  pagamento_aprovado = tentativas >= 3
  resultado = pagamento_aprovado ? "aprovado" : "recusado"
  puts "Tentativa #{tentativas}: pagamento #{resultado}"
end

puts pagamento_aprovado ? "Pedido #104 pago." : "Pedido #104 continua pendente."
puts

# 4. UNTIL
# O until repete até a condição ficar verdadeira.
# Aqui, separa os pedidos da fila até ela esvaziar.
puts "--- Fila de separação (until) ---"

fila_separacao = pedidos_pagos.map { |pedido| pedido[:id] }

until fila_separacao.empty?
  id = fila_separacao.shift
  puts "Pedido ##{id} separado. Restam #{fila_separacao.length} na fila."
end

puts "Fila de separação vazia."
puts

# 5. REDO
# REDO reinicia o bloco do elemento atual, sem avançar para o próximo.
# O contador é incrementado antes da verificação, por isso a falha acontece só na
# 1ª tentativa e o redo roda uma única vez (sem essa
# guarda, o redo poderia gerar um laço infinito).

puts "--- Emissão de etiquetas (redo) ---"

tentativas_etiqueta = Hash.new(0)

pedidos_pagos.each do |pedido|
  tentativas_etiqueta[pedido[:id]] += 1

  # Simula uma falha na impressora apenas na 1ª tentativa do pedido 103.
  if pedido[:id] == 103 && tentativas_etiqueta[103] == 1
    puts "Falha ao gerar a etiqueta do pedido ##{pedido[:id]}. Tentando novamente..."
    redo
  end

  puts "Etiqueta do pedido ##{pedido[:id]} gerada " \
       "(tentativa #{tentativas_etiqueta[pedido[:id]]})."
end

puts

# 6. RESUMO (each + next)
# Soma o valor dos pedidos que não foram cancelados (o next pula os cancelados).
total_nao_cancelados = 0.0

pedidos.each do |pedido|
  next if pedido[:status] == "cancelado"

  total_nao_cancelados += pedido[:valor]
end

puts "--- Resumo financeiro ---"
puts "Pedidos recebidos: #{pedidos.length}"
puts "Valor dos pedidos não cancelados: R$ #{format('%.2f', total_nao_cancelados)}"