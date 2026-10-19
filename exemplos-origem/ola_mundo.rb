# Arquivo: 01_ola_mundo.rb
# Tema: Estrutura básica e saída de dados
# Aplicação: Exibição de mensagens de boas-vindas e dados cadastrais no terminal.
#
# Objetivo:
# Demonstrar a estrutura básica de um programa em Ruby, o uso dos métodos de saída
# (puts, print, p) e a interpolação de variáveis.
#
# Execução:
# ruby 01_ola_mundo.rb

# Variáveis para demonstrar a saída de dados
nome_usuario = "Maria"
idade = 22

# 'puts' imprime o texto e adiciona automaticamente uma quebra de linha no final
puts "=== Boas-vindas ao Sistema ==="
puts "Olá, mundo! Este é o primeiro script em Ruby."

# 'print' imprime o texto SEM adicionar quebra de linha
print "Nome do usuário: "
# Interpolação de variável em String usando "#{...}"
puts "#{nome_usuario}"

print "Idade: "
puts "#{idade} anos"

# 'p' exibe a representação interna do objeto (muito útil para depuração/debug)
puts "\n--- Exemplo do método p (inspeção) ---"
p nome_usuario
p idade