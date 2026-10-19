# Arquivo: tratamento_de_excecoes.rb
# Tema: Tratamento de exceções
# Aplicação: Sistema de importação de notas.
#
# Objetivo:
# Demonstrar begin, rescue, else, ensure e raise
# no tratamento de erros de conversão e validação.
#
# Funcionamento:
# Processa cinco registros predefinidos, sem solicitar dados.
# Aceita notas de 0 a 10 e informa os registros rejeitados.
# Um erro não interrompe a importação dos demais registros.
# Os resultados ficam na memória durante a execução.
#
# Execução:
# Dentro da pasta exemplos-origem, execute:
# ruby tratamento_de_excecoes.rb

# Converte a entrada e verifica se ela representa uma nota válida.
def converter_nota(entrada)
  # Float gera ArgumentError para textos inválidos e TypeError para nil.
  # Diferentemente de to_f, não transforma um texto inválido em zero.
  nota = Float(entrada)

  # raise sinaliza um erro quando o número está fora da faixa permitida.
  unless nota.between?(0, 10)
    raise ArgumentError, "a nota deve estar entre 0 e 10"
  end

  nota
end

# Os dados incluem notas válidas, texto inválido, nota fora da faixa
# e ausência de valor (nil), para demonstrar diferentes situações.
registros = [
  { aluno: "Ana", nota: "8.5" },
  { aluno: "Bruna", nota: "ausente" },
  { aluno: "Carla", nota: "12" },
  { aluno: "Diana", nota: nil },
  { aluno: "Elisa", nota: "7.0" }
]

notas_importadas = {}
rejeitados = 0

puts "=== Importação de notas ==="

registros.each do |registro|
  puts "\nAluno: #{registro[:aluno]}"

  # begin delimita a operação que pode gerar uma exceção.
  begin
    nota = converter_nota(registro[:nota])

  # rescue trata erros de conversão de texto e de faixa da nota.
  # A variável erro permite consultar a mensagem da exceção.
  rescue ArgumentError => erro
    rejeitados += 1
    puts "Registro rejeitado: #{erro.message}"

  # Este rescue trata especificamente a ausência de uma nota.
  rescue TypeError
    rejeitados += 1
    puts "Registro rejeitado: nota não informada."

  # else executa somente quando o bloco begin termina sem exceção.
  else
    notas_importadas[registro[:aluno]] = nota
    puts "Nota importada: #{nota}"

  # ensure executa tanto no sucesso quanto no erro.
  # Aqui, confirma o fim de cada tentativa de importação.
  ensure
    puts "Processamento deste registro finalizado."
  end
end

puts "\n=== Resultado da importação ==="

notas_importadas.each do |aluno, nota|
  puts "#{aluno}: #{nota}"
end

puts "Registros importados: #{notas_importadas.size}"
puts "Registros rejeitados: #{rejeitados}"