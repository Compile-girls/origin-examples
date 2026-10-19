# Arquivo: eventos_e_callbacks.rb
# Tema: Eventos e callbacks
# Aplicação: Sistema de notificações de pedidos.
#
# Objetivo:
# Demonstrar o registro de callbacks com blocos,
# Procs e lambdas e sua execução quando ocorre um evento.
#
# Funcionamento:
# Registra ações para pedidos confirmados, enviados e cancelados.
# Simula esses eventos com dados predefinidos, sem solicitar entrada.
# As notificações aparecem no terminal; nenhum e-mail real é enviado.
# Os callbacks são executados na ordem de registro, sem concorrência.
#
# Execução:
# Dentro da pasta exemplos-origem, execute:
# ruby eventos_e_callbacks.rb

# Associa cada evento às ações que devem ser executadas quando ele ocorrer.
class CentralEventos
  def initialize
    # Cada evento recebe sua própria lista de callbacks.
    @callbacks = Hash.new { |eventos, evento| eventos[evento] = [] }
  end

  # &callback transforma o bloco recebido em um objeto Proc.
  # Registrar uma ação não a executa: apenas a guarda para depois.
  def registrar(evento, &callback)
    raise ArgumentError, "informe um callback" unless callback

    @callbacks[evento] << callback
  end

  # Executa todos os callbacks do evento, passando os dados do pedido.
  # Se não houver callbacks registrados, nenhuma ação será executada.
  def emitir(evento, pedido)
    @callbacks[evento].each do |callback|
      callback.call(pedido)
    end
  end
end

central = CentralEventos.new
historico = []

# Bloco: registra uma notificação para o evento de confirmação.
central.registrar(:confirmado) do |pedido|
  puts "E-mail simulado: #{pedido[:cliente]}, pedido ##{pedido[:id]} confirmado!"
end

# Proc: guarda uma ação reutilizável que registra o pedido no histórico.
# A variável historico permanece acessível dentro da Proc (closure).
registrar_confirmacao = Proc.new do |pedido|
  historico << "Pedido ##{pedido[:id]} confirmado"
  puts "Histórico atualizado para o pedido ##{pedido[:id]}."
end

# & converte a Proc em bloco para passá-la ao método registrar.
# O evento confirmado passa a ter dois callbacks.
central.registrar(:confirmado, &registrar_confirmacao)

# Lambda: define uma ação que exige um argumento, os dados do pedido.
notificar_envio = ->(pedido) do
  puts "Notificação: pedido ##{pedido[:id]} enviado para #{pedido[:cliente]}."
end

central.registrar(:enviado, &notificar_envio)

central.registrar(:cancelado) do |pedido|
  puts "Notificação: pedido ##{pedido[:id]} de #{pedido[:cliente]} cancelado."
end

puts "=== Simulação de eventos de pedidos ==="

pedido_ana = { id: 101, cliente: "Ana" }
pedido_bruna = { id: 102, cliente: "Bruna" }

# Um pedido é confirmado e depois enviado; outro é cancelado.
# Cada emissão aciona somente os callbacks associados àquele evento.
central.emitir(:confirmado, pedido_ana)
central.emitir(:enviado, pedido_ana)
central.emitir(:cancelado, pedido_bruna)

puts "\n=== Histórico de confirmações ==="
historico.each do |registro|
  puts registro
end