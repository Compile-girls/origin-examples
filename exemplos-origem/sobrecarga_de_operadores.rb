# Arquivo: 07_sobrecarga_de_operadores.rb
# Tema: Sobrecarga de operadores
# Aplicação: Somatório e comparação de carteiras financeiras em moedas personalizadas.
#
# Objetivo:
# Demonstrar como redefinir operadores padrão (como +, - e ==) em uma classe customizada
# para permitir sintaxe expressiva e intuitiva.
#
# Execução:
# ruby 07_sobrecarga_de_operadores.rb

class Carteira
  attr_reader :saldo, :moeda

  def initialize(saldo, moeda = "BRL")
    @saldo = saldo
    @moeda = moeda
  end

  # Sobrecarga do operador de adição (+): permite somar duas carteiras
  def +(outra_carteira)
    raise "Não é possível somar moedas diferentes!" if self.moeda != outra_carteira.moeda

    # Retorna uma nova instância da Carteira com o valor somado
    Carteira.new(self.saldo + outra_carteira.saldo, self.moeda)
  end

  # Sobrecarga do operador de subtração (-): permite subtrair valores de carteiras
  def -(outra_carteira)
    raise "Não é possível subtrair moedas diferentes!" if self.moeda != outra_carteira.moeda

    Carteira.new(self.saldo - outra_carteira.saldo, self.moeda)
  end

  # Sobrecarga do operador de igualdade (==): compara carteiras pelo saldo e moeda
  def ==(outra_carteira)
    self.saldo == outra_carteira.saldo && self.moeda == outra_carteira.moeda
  end

  def to_s
    "#{moeda} #{'%.2f' % saldo}"
  end
end

# Testando a sobrecarga de operadores
carteira1 = Carteira.new(150.0, "BRL")
carteira2 = Carteira.new(50.5, "BRL")
carteira3 = Carteira.new(200.5, "BRL")

puts "=== Sobrecarga de Operadores ==="
puts "Carteira 1: #{carteira1}"
puts "Carteira 2: #{carteira2}"

# Uso do operador '+' redefinido
total = carteira1 + carteira2
puts "Soma (carteira1 + carteira2): #{total}"

# Uso do operador '-' redefinido
diferenca = carteira1 - carteira2
puts "Diferença (carteira1 - carteira2): #{diferenca}"

# Uso do operador '==' redefinido
puts "carteira1 + carteira2 é igual à carteira3? #{total == carteira3}"