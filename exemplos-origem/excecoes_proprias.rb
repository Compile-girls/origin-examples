# Arquivo: excecoes_proprias.rb
# Tema: Exceções próprias, herança de StandardError e tratamento de exceções delegadas
# Aplicação: Sistema de empréstimo de livros de uma biblioteca

# Objetivo:
# Criar exceções específicas (livro indisponível, limite de empréstimos
# excedido e usuário não autorizado) que herdam de StandardError e mostrar
# como uma exceção levantada em uma camada (Biblioteca) é delegada a outras
# (Atendimento e programa principal), usando raise, rescue, re-raise e ensure.

# Execução:
#   ruby excecoes_proprias.rb


puts "=== Sistema de Empréstimo de Livros ==="
puts

# 1. EXCEÇÕES PERSONALIZADAS
# Todas herdam de BibliotecaError, que herda de StandardError. Assim é
# possível tratar um erro específico ou qualquer erro da biblioteca.
class BibliotecaError < StandardError
end

class LivroIndisponivelError < BibliotecaError
  attr_reader :titulo

  def initialize(titulo)
    @titulo = titulo
    super("O livro '#{titulo}' não está disponível.")
  end
end

class LimiteEmprestimosError < BibliotecaError
  attr_reader :usuario, :limite

  def initialize(usuario, limite)
    @usuario = usuario
    @limite = limite
    super("#{usuario} atingiu o limite de #{limite} empréstimos.")
  end
end

class UsuarioNaoAutorizadoError < BibliotecaError
  attr_reader :usuario

  def initialize(usuario)
    @usuario = usuario
    super("Usuário '#{usuario}' não está autorizado a realizar empréstimos.")
  end
end

# 2. CAMADA QUE LEVANTA AS EXCEÇÕES (raise)
# A Biblioteca levanta a exceção certa quando uma regra é quebrada.
class Biblioteca
  LIMITE_EMPRESTIMOS = 3

  def initialize(livros, usuarios_autorizados)
    @livros_disponiveis = livros.dup
    @usuarios_autorizados = usuarios_autorizados
    @emprestimos = Hash.new { |hash, usuario| hash[usuario] = [] }
  end

  def emprestar(usuario, titulo)
    unless @usuarios_autorizados.include?(usuario)
      raise UsuarioNaoAutorizadoError.new(usuario)
    end

    unless @livros_disponiveis.include?(titulo)
      raise LivroIndisponivelError.new(titulo)
    end

    if @emprestimos[usuario].length >= LIMITE_EMPRESTIMOS
      raise LimiteEmprestimosError.new(usuario, LIMITE_EMPRESTIMOS)
    end

    @emprestimos[usuario] << titulo
    @livros_disponiveis.delete(titulo)
    puts "  Empréstimo confirmado: '#{titulo}' para #{usuario}."
  end
end


# 3. CAMADA INTERMEDIÁRIA: DELEGAÇÃO E RE-RAISE
# O Atendimento anota o que precisa e repassa o mesmo erro para quem o chamou,
# usando raise sem argumentos.
# O ensure roda sempre ao sair do método, com ou sem erro.
# As outras exceções, que ele não captura, seguem direto para quem chamou.
class Atendimento
  def initialize(biblioteca)
    @biblioteca = biblioteca
  end

  def solicitar(usuario, titulo)
    puts "  Atendimento: processando pedido de #{usuario}..."
    @biblioteca.emprestar(usuario, titulo)
  rescue LivroIndisponivelError => erro
    puts "  Atendimento: registrando '#{erro.titulo}' para reposição."
    raise # repassa a exceção original para o chamador
  ensure
    puts "  Atendimento: pedido de #{usuario} encerrado."
  end
end

# 4. CAMADA FINAL: TRATAMENTO (rescue)
# Aqui o erro é tratado de fato. Os rescue mais específicos vêm primeiro e o
# mais geral (BibliotecaError) fica por último.
def executar_pedido(atendimento, usuario, titulo)
  atendimento.solicitar(usuario, titulo)
rescue UsuarioNaoAutorizadoError => erro
  puts "  [Autorização] #{erro.message}"
rescue LimiteEmprestimosError => erro
  puts "  [Limite] #{erro.message}"
rescue LivroIndisponivelError => erro
  puts "  [Disponibilidade] #{erro.message}"
rescue BibliotecaError => erro
  puts "  [Biblioteca] Erro inesperado: #{erro.message}"
end

# 5. EXECUÇÃO DOS CASOS
biblioteca = Biblioteca.new(
  [
    "Ruby para Iniciantes",
    "Estruturas de Dados",
    "Inteligência Artificial",
    "Compiladores",
    "Redes de Computadores",
    "Banco de Dados"
  ],
  %w[Ana Bruno Mariana]
)
atendimento = Atendimento.new(biblioteca)

puts "Hierarquia: #{LimiteEmprestimosError.ancestors.take(3).join(' < ')}"
puts

puts "Caso 1: empréstimo válido"
executar_pedido(atendimento, "Ana", "Ruby para Iniciantes")
puts

puts "Caso 2: livro indisponível (inexistente no acervo)"
executar_pedido(atendimento, "Bruno", "Banco de Dados Avançado")
puts

puts "Caso 3: usuário não autorizado"
executar_pedido(atendimento, "Carlos", "Estruturas de Dados")
puts

puts "Caso 4: livro já emprestado (indisponível)"
executar_pedido(atendimento, "Bruno", "Ruby para Iniciantes")
puts

puts "Caso 5: limite de empréstimos (3 permitidos, o 4º é recusado)"
["Inteligência Artificial", "Compiladores", "Redes de Computadores",
 "Banco de Dados"].each do |titulo|
  executar_pedido(atendimento, "Mariana", titulo)
end

puts
puts "Processamento dos empréstimos finalizado."