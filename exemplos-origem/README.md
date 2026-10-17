# Exemplos de Código-Fonte em Ruby

## Descrição

Esta pasta reúne exemplos de códigos-fonte desenvolvidos na linguagem Ruby para a disciplina de Compiladores, semestre 2026.2.

Os exemplos têm como objetivo demonstrar recursos da linguagem por meio de aplicações práticas, com códigos organizados, comentários explicativos e instruções de execução.

## Requisitos

Para executar os exemplos, é necessário ter:

- Ruby instalado;
- Um editor de código, como o Visual Studio Code;
- Terminal ou PowerShell para executar os comandos.

## Instalação do Ruby no Windows

1. Acesse o site oficial do [RubyInstaller](https://rubyinstaller.org/).
2. Baixe uma versão compatível do Ruby para Windows.
3. Execute o instalador e siga as instruções apresentadas.
4. Caso o instalador solicite componentes adicionais do MSYS2/Devkit, siga as instruções oficiais.
5. Abra um novo terminal e execute:

```powershell
ruby -v
```

O comando deverá exibir a versão do Ruby instalada.

Para verificar se o gerenciador de pacotes RubyGems está disponível, execute:

```powershell
gem -v
```

Se ambos os comandos funcionarem, o ambiente estará pronto para executar os exemplos básicos.

## Instalação de extensões no Visual Studio Code

A extensão **Ruby LSP**, disponível no Marketplace do Visual Studio Code, é recomendada para facilitar a edição dos arquivos Ruby, oferecendo recursos como análise de código, sugestões e identificação de possíveis erros.

A extensão é opcional: os arquivos podem ser executados diretamente pelo terminal, sem ela.

## Como executar os exemplos

1. Abra a pasta `exemplos-origem` no Visual Studio Code.
2. Abra o terminal integrado em **Terminal → Novo Terminal**.
3. Utilize o comando `ruby`, seguido do nome do arquivo que deseja executar.

Exemplo:

```powershell
ruby .\tipagem_dinamica.rb
```

Para executar outro exemplo, substitua o nome do arquivo pelo arquivo desejado. Por exemplo:

```powershell
ruby .\variaveis_e_referencias.rb
```

Cada arquivo foi organizado para ser executado individualmente, sem depender da execução prévia dos demais exemplos.


## Organização dos arquivos

Os arquivos estão separados por tema, com nomes descritivos e comentários explicativos no cabeçalho, identificando o assunto, a aplicação, o objetivo e o comando de execução.

Cada exemplo busca demonstrar o funcionamento dos recursos estudados por meio de uma aplicação prática.

