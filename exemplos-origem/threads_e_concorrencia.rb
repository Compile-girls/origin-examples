# Arquivo: threads_e_concorrencia.rb
# Tema: Threads e concorrência
# Aplicação: Sistema de processamento de relatórios de uma empresa

# Objetivo:
# Demonstrar Thread.new, a execução concorrente de tarefas independentes
# e o uso de join (e value) para aguardar a conclusão das Threads.

# Execução:
#   ruby threads_e_concorrencia.rb


puts "=== Sistema de Processamento de Relatórios ==="
puts

# Cada relatório é uma tarefa independente, com tempo de execução próprio.
# Não há dados mutáveis compartilhados entre eles (tema do arquivo de Mutex).
relatorios = [
  { nome: "Vendas",     registros: 120, duracao: 0.8 },
  { nome: "Estoque",    registros: 85,  duracao: 0.4 },
  { nome: "Financeiro", registros: 200, duracao: 1.2 },
  { nome: "Clientes",   registros: 150, duracao: 0.6 }
]

# Devolve a hora atual de um relógio próprio para medir intervalos de tempo.
def agora
  Process.clock_gettime(Process::CLOCK_MONOTONIC)
end

inicio = agora

# 1. CRIAÇÃO DAS THREADS (Thread.new)
# O relatório é passado como argumento para Thread.new, o que entrega a
# cada Thread a sua própria variável local.
threads = relatorios.map do |relatorio|
  Thread.new(relatorio) do |rel|
    puts "[#{rel[:nome]}] Iniciando processamento..."

    # sleep simula uma operação demorada (leitura de banco, arquivo, rede).
    sleep(rel[:duracao])

    resultado = rel[:registros] * 2
    puts "[#{rel[:nome]}] Concluído em #{rel[:duracao]}s."

    # O valor do bloco vira o resultado da Thread (lido com Thread#value).
    { nome: rel[:nome], resultado: resultado }
  end
end

puts
puts "Todas as tarefas foram iniciadas (#{threads.length} Threads)."
puts "A Thread principal continua executando enquanto elas trabalham."
puts

# 2. JOIN E VALUE
# value aguarda a conclusão da Thread e retorna o resultado do bloco.
# Se a Thread terminar com uma exceção não tratada, value pode repassá-la.
# A ordem de espera é a ordem da lista, mas as Threads terminam
# conforme a duração de cada uma.
resultados = threads.map(&:value)

tempo_total = agora - inicio
soma_duracoes = relatorios.sum { |r| r[:duracao] }

puts
puts "--- Resultados ---"
resultados.each do |item|
  puts "#{item[:nome]}: #{item[:resultado]}"
end

puts
puts "--- Concorrência ---"
puts "Soma dos tempos (execução sequencial): #{format('%.1f', soma_duracoes)}s"
# O esperado é um valor próximo do relatório mais demorado, mas o tempo
# real inclui o custo de criar e agendar as Threads.
puts "Tempo total medido: ~#{format('%.1f', tempo_total)}s " \
     "(esperado: próximo do relatório mais demorado)"
puts "Todos os relatórios foram processados."

# OBSERVAÇÃO:
# Em CRuby (MRI), o GVL permite que apenas uma Thread execute código Ruby por
# vez, mas ele é liberado durante esperas como sleep e E/S. Por isso a
# concorrência aparece aqui; paralelismo real em CPU depende da implementação.