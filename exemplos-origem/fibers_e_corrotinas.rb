# Arquivo: 12_fibers_e_corrotinas.rb
# Tema: Fibers e corrotinas
# Aplicação: Processamento cooperativo com gerador de fichas/senhas e workflow pausável.
#
# Objetivo:
# Demonstrar o uso de Fibers (corrotinas leves) para pausar (yield) e retomar (resume)
# a execução de fluxos de forma cooperativa e sob demanda.
#
# Execução:
# ruby 12_fibers_e_corrotinas.rb

require 'fiber'

# Criando um Fiber que atua como um gerador cooperativo de fichas de atendimento
gerador_fichas = Fiber.new do
  numero_ficha = 100

  loop do
    # O Fiber.yield pausa a execução da corrotina e envia o valor de volta para quem a chamou
    Fiber.yield "Ficha-#{numero_ficha}"
    numero_ficha += 1
  end
end

puts "=== Gerador Cooperativo de Fichas (Fibers) ==="

# O método '.resume' inicia ou retoma a execução do Fiber até o próximo 'yield'
puts "Atendimento 1 chama: #{gerador_fichas.resume}"
puts "Atendimento 2 chama: #{gerador_fichas.resume}"
puts "Atendimento 3 chama: #{gerador_fichas.resume}"

# Exemplo 2: Fiber para processamento em etapas (workflow pausável)
workflow = Fiber.new do |pedido_id|
  puts "\n--- [Fiber Workflow] Processando Pedido ##{pedido_id} ---"
  
  # Etapa 1
  puts "Etapa 1: Estoque reservado."
  status = Fiber.yield "Aguardando Pagamento"

  # Etapa 2
  puts "Etapa 2: Pagamento recebido com status: #{status}."
  Fiber.yield "Pronto para Envio"

  # Etapa 3
  puts "Etapa 3: Pedido enviado à transportadora."
  "Concluído"
end

# Inicia o workflow passando o ID do pedido
estado = workflow.resume(8492)
puts "Estado atual: #{estado}"

# Avança para a próxima etapa enviando dados adicionais
estado = workflow.resume("APROVADO")
puts "Estado atual: #{estado}"

# Conclui o workflow
estado = workflow.resume
puts "Estado final: #{estado}"