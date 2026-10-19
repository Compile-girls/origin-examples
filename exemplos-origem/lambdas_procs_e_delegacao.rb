# Arquivo: lambdas_procs_e_delegacao.rb
# Tema: Lambdas, Procs, métodos como objetos e delegação
# Aplicação: Sistema de pagamentos com regras de desconto.
#
# Objetivo:
# Demonstrar regras de desconto com lambdas e Procs,
# métodos como objetos chamados com call e delegação
# de operações utilizando Forwardable.
#
# Funcionamento:
# Processa três compras predefinidas, sem solicitar dados.
# Exibe o desconto e o pagamento de cada cliente,
# além do total recebido pela loja.
# Os valores são armazenados em centavos:
# 15_000 representa 15000 centavos, ou R$ 150,00.
#
# Execução:
# Dentro da pasta exemplos-origem, execute:
# ruby lambdas_procs_e_delegacao.rb

# Carrega a biblioteca que permite delegar métodos a outro objeto.
require "forwardable"

# Aplica a regra de desconto recebida e acumula o total dos pagamentos.
class ProcessadorPagamento
  # Permite consultar o total recebido sem alterá-lo diretamente.
  attr_reader :total_recebido

  def initialize
    @total_recebido = 0
  end

  def pagar(valor_centavos, regra_desconto)
    # call executa a regra, que retorna o valor já com desconto.
    valor_final = regra_desconto.call(valor_centavos)
    @total_recebido += valor_final
    valor_final
  end
end

# A loja recebe as chamadas, mas o processador realiza as operações.
class Loja
  extend Forwardable

  # loja.pagar encaminha a chamada para @processador.pagar.
  # loja.total_recebido consulta o total registrado nesse mesmo objeto.
  def_delegators :@processador, :pagar, :total_recebido

  def initialize
    @processador = ProcessadorPagamento.new
  end
end

# Converte centavos para reais apenas na apresentação dos resultados.
def formatar_moeda(centavos)
  "R$ #{format('%.2f', centavos / 100.0).tr('.', ',')}"
end

# Lambda: um bloco de código guardado em um objeto, criado com ->.
# Recebe um valor e retorna o total após descontar 10%.
# Exige exatamente um argumento nesta definição.
desconto_percentual = ->(valor) { valor - (valor * 10 / 100) }

# Proc: também guarda um bloco de código para execução posterior.
# Usa cupom_centavos, definido fora do bloco, demonstrando uma closure.
# Aplica um cupom de R$ 20,00 e limita o pagamento mínimo a zero.
cupom_centavos = 2_000
desconto_cupom = Proc.new do |valor|
  [valor - cupom_centavos, 0].max
end

loja = Loja.new

# Obtém o método pagar como um objeto Method e o guarda na variável.
# Depois, call executa esse método com os argumentos informados.
efetuar_pagamento = loja.method(:pagar)

# Cada compra associa um cliente, um valor em centavos e uma regra.
# Ana recebe 10% de desconto; Bruna e Carla utilizam o cupom fixo.
compras = [
  { cliente: "Ana", valor: 15_000, regra: desconto_percentual },
  { cliente: "Bruna", valor: 15_000, regra: desconto_cupom },
  { cliente: "Carla", valor: 1_500, regra: desconto_cupom }
]

puts "=== Sistema de pagamentos ==="

compras.each do |compra|
  # Executa o Method, que chama o método delegado pela loja.
  # O processador aplica a lambda ou Proc associada à compra.
  valor_final = efetuar_pagamento.call(compra[:valor], compra[:regra])

  puts "\nCliente: #{compra[:cliente]}"
  puts "Valor original: #{formatar_moeda(compra[:valor])}"
  puts "Desconto: #{formatar_moeda(compra[:valor] - valor_final)}"
  puts "Total pago: #{formatar_moeda(valor_final)}"
end

# Consulta o total por delegação. O resultado esperado é R$ 265,00.
puts "\nTotal recebido pela loja: #{formatar_moeda(loja.total_recebido)}"