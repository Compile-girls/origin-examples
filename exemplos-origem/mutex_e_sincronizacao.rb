# Arquivo: mutex_e_sincronizacao.rb
# Tema: Condições de corrida, dados compartilhados, seções críticas, Mutex e synchronize
# Aplicação: Controle de vagas de um evento

# Objetivo:
# Mostrar primeiro o PROBLEMA (condição de corrida na atualização das vagas,
# sem sincronização) e depois a SOLUÇÃO (seção crítica protegida por Mutex
# e synchronize), simulando solicitações concorrentes de reserva.

# Execução:
#   ruby mutex_e_sincronizacao.rb


puts "=== Controle de Vagas de um Evento ==="
puts

VAGAS_INICIAIS = 10
PARTICIPANTES  = 20

# Simula vários participantes tentando reservar vaga ao mesmo tempo.
# - vagas é o DADO COMPARTILHADO: todas as Threads leem e alteram o mesmo valor.
# - tentar_reservar é a SEÇÃO CRÍTICA: confere se há vaga e depois diminui a
#   quantidade. Essas duas etapas precisam acontecer juntas, sem outra Thread no meio.
# - O sleep representa o tempo de processamento (banco, pagamento) entre
#   conferir e atualizar; é ele que deixa a corrida visível.
def simular_reservas(vagas_iniciais:, participantes:, usar_mutex:)
  vagas = vagas_iniciais
  mutex = Mutex.new

  tentar_reservar = lambda do
    if vagas > 0          # 1) verifica se há vaga
      sleep(0.01)         # 2) tempo de processamento
      vagas -= 1          # 3) atualiza (com base numa verificação já antiga)
      true
    else
      false
    end
  end

  threads = (1..participantes).map do
    Thread.new do
      if usar_mutex
        # synchronize adquire o bloqueio, executa o bloco e libera o bloqueio
        # ao final, mesmo se ocorrer uma exceção.
        mutex.synchronize { tentar_reservar.call }
      else
        tentar_reservar.call
      end
    end
  end

  # value aguarda cada Thread e devolve true (reservou) ou false.
  confirmadas = threads.map(&:value).count(true)

  { confirmadas: confirmadas, vagas_restantes: vagas }
end

def exibir_resultado(titulo, resultado)
  # Esta checagem apenas verifica se a capacidade do evento foi ultrapassada;
  # ela não prova, sozinha, que todas as reservas foram contabilizadas.
  consistente = resultado[:vagas_restantes] >= 0 &&
                resultado[:confirmadas] <= VAGAS_INICIAIS

  puts "--- #{titulo} ---"
  puts "Vagas iniciais: #{VAGAS_INICIAIS} | Participantes: #{PARTICIPANTES}"
  puts "Reservas confirmadas: #{resultado[:confirmadas]}"
  puts "Vagas restantes: #{resultado[:vagas_restantes]}"
  puts(consistente ? "Resultado consistente." : "INCONSISTENTE: houve overbooking!")
  puts
end

# 1. SEM SINCRONIZAÇÃO
# Esta versão é insegura de propósito.
# Como há uma pausa entre conferir e atualizar, várias Threads podem ver vaga
# disponível ao mesmo tempo.
# O resultado depende do Ruby e de como as Threads são agendadas: o overbooking
# é provável, mas não garantido em toda execução.
resultado_inseguro = simular_reservas(
  vagas_iniciais: VAGAS_INICIAIS,
  participantes: PARTICIPANTES,
  usar_mutex: false
)
exibir_resultado("Sem Mutex (condição de corrida)", resultado_inseguro)

# 2. COM MUTEX
# Apenas uma Thread por vez executa a verificação E a atualização.
# Resultado esperado: exatamente 10 reservas e 0 vagas restantes.
resultado_seguro = simular_reservas(
  vagas_iniciais: VAGAS_INICIAIS,
  participantes: PARTICIPANTES,
  usar_mutex: true
)
exibir_resultado("Com Mutex (seção crítica protegida)", resultado_seguro)

# CONCLUSÃO:
# A verificação e a atualização precisam ser protegidas como uma única
# operação lógica. Mutex e synchronize garantem que apenas uma Thread
# por vez execute essa região crítica.
puts "O Mutex garante que a capacidade do evento nunca seja ultrapassada."