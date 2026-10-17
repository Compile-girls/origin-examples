
# Arquivo: variaveis_e_referencias.rb
# Tema: Variáveis, escopo e referências
# Aplicação: Sistema de cadastro de integrantes de um projeto.
#
# Objetivo:
# Demonstrar categorias de variáveis em Ruby, seus escopos
# e o compartilhamento de referências a objetos.
#
# Execução:
# ruby variaveis_e_referencias.rb

# Constante: armazena o nome do sistema.
NOME_SISTEMA = "Sistema de Cadastro do Projeto"

# Variável global: pode ser acessada em diferentes partes do programa.
$mensagem_sistema = "Bem-vindas ao projeto de Compiladores!"

class Integrante
  # Variável de classe: compartilhada entre as instâncias.
  @@total_integrantes = 0

  def initialize(nome)
    # Variável de instância: pertence a cada objeto.
    @nome = nome
    @@total_integrantes += 1
  end

  def apresentar
    # Variável local: existe apenas dentro deste método.
    nome_formatado = @nome.upcase
    puts "Integrante: #{nome_formatado}"
  end

  # Método de classe para consultar o total de integrantes.
  def self.total_integrantes
    @@total_integrantes
  end
end

puts "=== Cadastro de integrantes ==="
puts NOME_SISTEMA
puts $mensagem_sistema
puts

# Criando os objetos com os nomes das integrantes.
carol = Integrante.new("Carol")
aretuza = Integrante.new("Aretuza")
sthefanny = Integrante.new("Sthefanny")
clara = Integrante.new("Clara")

carol.apresentar
aretuza.apresentar
sthefanny.apresentar
clara.apresentar

puts "Total de integrantes: #{Integrante.total_integrantes}"
puts

# Demonstração de referências a objetos.
# As duas variáveis apontam para o mesmo Array.
integrantes = ["Carol", "Aretuza"]
outras_integrantes = integrantes

puts "Antes da alteração:"
puts "Lista original: #{integrantes.inspect}"
puts "Outra referência: #{outras_integrantes.inspect}"
puts

# Modificar o Array por uma referência afeta a outra,
# pois ambas apontam para o mesmo objeto.
outras_integrantes << "Sthefanny"
outras_integrantes << "Clara"

puts "Depois da alteração:"
puts "Lista original: #{integrantes.inspect}"
puts "Outra referência: #{outras_integrantes.inspect}"
puts

# Atribuir uma nova String à variável não altera
# a String anteriormente referenciada pela outra variável.
nome_original = "Carol"
outro_nome = nome_original
outro_nome = "Aretuza"

puts "Nome original: #{nome_original}"
puts "Outro nome: #{outro_nome}"
puts

puts "Exemplo concluído!"
