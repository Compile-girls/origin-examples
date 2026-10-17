
# Arquivo: programacao_assincrona_e_ractors.rb
# Tema: Programação assíncrona e Ractors
# Aplicação: Processamento de tarefas de um projeto acadêmico.
#
# Objetivo:
# Demonstrar tarefas assíncronas com a gem Async e
# execução isolada de tarefas utilizando Ractors.
#
# Dependência:
# gem install async
#
# Execução:
# ruby programacao_assincrona_e_ractors.rb

require "async"

puts "=== Processamento de tarefas do projeto ==="
puts

# --------------------------------------------------
# 1. PROGRAMAÇÃO ASSÍNCRONA COM A GEM ASYNC
# --------------------------------------------------
# As tarefas são executadas de forma cooperativa.
# Enquanto uma tarefa aguarda, outra pode avançar.

puts "--- Tarefas assíncronas ---"

Async do |parent|
  tarefa_documentacao = parent.async do
    3.times do |etapa|
      puts "[Documentação] Etapa #{etapa + 1} concluída."
      parent.sleep(0.2)
    end

    "Documentação finalizada"
  end

  tarefa_codigo = parent.async do
    3.times do |etapa|
      puts "[Código] Etapa #{etapa + 1} concluída."
      parent.sleep(0.2)
    end

    "Código finalizado"
  end

  puts tarefa_documentacao.wait
  puts tarefa_codigo.wait
end

puts

# --------------------------------------------------
# 2. RACTORS
# --------------------------------------------------
# Ractors são unidades de execução isoladas.
# Os dados são enviados como argumentos e os resultados
# podem ser recebidos por meio de take.

puts "--- Processamento com Ractors ---"

integrantes = ["Carol", "Aretuza", "Sthefanny", "Clara"]

tarefas = integrantes.map do |nome|
  Ractor.new(nome) do |integrante|
    "Tarefa de #{integrante} processada com sucesso!"
  end
end

tarefas.each do |tarefa|
  puts tarefa.value
end

puts
puts "Todas as tarefas foram processadas!"
