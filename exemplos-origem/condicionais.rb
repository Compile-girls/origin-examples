# Arquivo: condicionais.rb
# Tema: Estruturas condicionais
# Aplicação: Sistema de classificação de estudantes

# Objetivo:
# Demonstrar o uso de if, elsif, else, unless, case, when e do operador
# ternário para determinar a situação do estudante (aprovado,
# recuperação ou reprovado) e classificar o desempenho por faixa de
# notas, considerando nota, frequência e entrega de atividades.

# Execução:
#   ruby condicionais.rb
#   (O programa pergunta se deseja cadastrar um estudante: apertar Enter
#   mantém os valores padrão e dispensa qualquer digitação.)

puts "=== Sistema de Classificação de Estudantes ==="
puts

# Regras de aprovação (valores ilustrativos).
NOTA_APROVACAO    = 7.0
NOTA_RECUPERACAO  = 5.0
FREQUENCIA_MINIMA = 75

# Faz uma pergunta e devolve a resposta digitada. Se a pessoa apertar só
# Enter (ou não houver entrada), devolve o valor padrão.
# assim o programa roda inteiro sem precisar digitar nada.
def ler(pergunta, padrao)
  print "#{pergunta} [#{padrao}]: "
  entrada = ($stdin.gets || "").strip
  entrada.empty? ? padrao : entrada
end

# Estudantes da demonstração. Cada um é um hash (pares chave: valor).
# Os dados foram escolhidos para que todos os ramos das condicionais
# sejam executados: aprovado, recuperação, reprovado por nota e por falta.
estudantes = [
  { nome: "Mariana", nota: 9.5, frequencia: 95, trabalho_entregue: true  },
  { nome: "João",    nota: 7.5, frequencia: 80, trabalho_entregue: true  },
  { nome: "Beatriz", nota: 6.0, frequencia: 90, trabalho_entregue: false },
  { nome: "Carlos",  nota: 4.0, frequencia: 85, trabalho_entregue: true  },
  { nome: "Lucas",   nota: 8.0, frequencia: 60, trabalho_entregue: true  },
  { nome: "Rafael",  nota: 6.5, frequencia: 88, trabalho_entregue: true  }
]

# Cadastro opcional. Por padrão a resposta é "n" e nada muda, somente os estudantes acima são usados. 
# Se for "s", lê os dados e acrescenta o novo estudante à lista com <<.
puts "--- Cadastro opcional (Enter mantém o padrão) ---"

if ler("Cadastrar um estudante adicional? (s/n)", "n").downcase == "s"
  novo_nome       = ler("Nome", "Novo Estudante")
  nova_nota       = ler("Nota (0 a 10)", "6.0").to_f
  nova_frequencia = ler("Frequência (%)", "80").to_i
  novo_trabalho   = ler("Trabalho entregue? (s/n)", "s").downcase == "s"

  estudantes << {
    nome: novo_nome,
    nota: nova_nota,
    frequencia: nova_frequencia,
    trabalho_entregue: novo_trabalho
  }
end

puts

estudantes.each do |estudante|
  nome              = estudante[:nome]
  nota              = estudante[:nota]
  frequencia        = estudante[:frequencia]
  trabalho_entregue = estudante[:trabalho_entregue]

  puts "--- #{nome} ---"
  puts "Nota: #{format('%.1f', nota)} | Frequência: #{frequencia}%"

  # 1. IF, ELSIF E ELSE
  # Determina a situação: valida a nota, checa a frequência e depois as faixas de nota.
  if nota < 0.0 || nota > 10.0
    situacao = "Nota inválida"
  elsif frequencia < FREQUENCIA_MINIMA
    situacao = "Reprovado por falta"
  elsif nota >= NOTA_APROVACAO
    situacao = "Aprovado"
  elsif nota >= NOTA_RECUPERACAO
    situacao = "Recuperação"
  else
    situacao = "Reprovado por nota"
  end

  # 2. CASE E WHEN (com intervalos)
  # Classifica o desempenho por faixa de nota.
  # O case compara a nota com cada faixa (intervalo), na ordem.
  desempenho = case nota
               when 9.0..10.0 then "Excelente"
               when 7.0...9.0 then "Bom"
               when 5.0...7.0 then "Regular"
               when 0.0...5.0 then "Insuficiente"
               else "Nota inválida"
               end

  # 3. UNLESS
  # Executa o bloco apenas quando a condição é falsa.
  unless trabalho_entregue
    puts "Atenção: o trabalho de #{nome} não foi entregue."
  end

  # 4. OPERADOR TERNÁRIO
  # Escolhe entre dois valores a partir de uma condição.
  # Formato: condição ? valor_se_verdadeiro : valor_se_falso
  situacao_trabalho = trabalho_entregue ? "Entregue" : "Pendente"

  # 5. COMBINAÇÃO DE CONDIÇÕES (&&, || e !)
  # && (e): as duas condições precisam ser verdadeiras.
  # || (ou): basta uma ser verdadeira.
  # !  (não): inverte o valor (!trabalho_entregue = trabalho não entregue).

  # Pode fazer a recuperação quem está nessa situação e entregou o trabalho.
  pode_recuperar = situacao == "Recuperação" && trabalho_entregue

  # Precisa de acompanhamento quem não foi aprovado ou não entregou o trabalho.
  precisa_acompanhamento = situacao != "Aprovado" || !trabalho_entregue

  puts "Situação: #{situacao}"
  puts "Desempenho: #{desempenho}"
  puts "Trabalho: #{situacao_trabalho}"
  puts "Pode fazer recuperação? #{pode_recuperar ? 'Sim' : 'Não'}"
  puts "Precisa de acompanhamento? #{precisa_acompanhamento ? 'Sim' : 'Não'}"
  puts
end

# RESUMO DA TURMA
# count conta os estudantes que atendem às condições de aprovação.
# O operador ternário escolhe a mensagem exibida no resumo.
aprovados = estudantes.count do |e|
  # between? também descarta notas inválidas (acima de 10).
  e[:frequencia] >= FREQUENCIA_MINIMA && e[:nota].between?(NOTA_APROVACAO, 10.0)
end

puts "--- Resumo da turma ---"
puts "Estudantes: #{estudantes.length}"
puts "Aprovados: #{aprovados}"
puts(aprovados > estudantes.length / 2 ? "Maioria aprovada." : "Maioria não aprovada.")