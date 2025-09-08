# FLUXER, seu fluxo de dados

**Projeto:** Analisador Léxico com JFlex  
**Linguagem:** Fluxer  
**Autores(as):** Robson Guilherme Ferrarezi  |  Kauê dos Santos Andrade  
**Data:** Setembro de 2025  
**Versão: 1.1.3**

## 1. Introdução: Nome e Propósito

### 1.1. Nome da Linguagem
A linguagem foi batizada de **Fluxer**.

### 1.2. Conceito e Propósito
**Fluxer** é uma linguagem de programação declarativa, de alto nível, concebida para a descrição e processamento de *pipelines* (fluxos) de dados. O seu principal objetivo é fornecer uma sintaxe limpa, expressiva e de fácil leitura para tarefas comuns de manipulação de dados, como leitura, filtragem, transformação e agregação.

Inspirada em paradigmas de programação funcional e linguagens de consulta de dados, a Fluxer permite que o desenvolvedor descreva "o que" fazer com os dados, em vez de "como" fazer, abstraindo a complexidade de laços e estados intermediários.

#### Exemplo Geral de um Código em Fluxer
```fluxer
-- Define uma constante para o ano de maioridade
const MAIORIDADE = 18

(*
  Este pipeline lê um arquivo CSV de usuários,
  filtra apenas os que são maiores de idade,
  transforma os dados para um novo formato
  e salva o resultado em um arquivo JSON.
*)
fonte "usuarios.csv" ->
filtro (usuario) se usuario.idade >= MAIORIDADE ->
transforma (usuario) {
    nome_completo: usuario.nome + " " + usuario.sobrenome,
    status: "verificado"
} ->
saida "usuarios_verificados.json"
```

### **Especificação Léxica: Palavras Reservadas e Identificadores (Parte 2)**


## 2. Especificação Léxica

A especificação léxica define as menores unidades indivisíveis da linguagem, conhecidas como **tokens**.

### 2.1. Palavras Reservadas

Palavras reservadas (ou palavras-chave) possuem um significado fixo na gramática da linguagem e não podem ser utilizadas como identificadores. A linguagem Fluxer define 13 palavras reservadas:

| Palavra      | Função Principal na Linguagem                                        |
| :----------- | :--------------------------------------------------------------------- |
| `fonte`      | Define a origem dos dados para o pipeline.                             |
| `filtro`     | Filtra os elementos do fluxo com base em uma condição booleana.         |
| `transforma` | Aplica uma função para modificar cada elemento do fluxo.               |
| `agrega`     | Realiza uma operação de resumo sobre o fluxo (ex: soma, contagem).      |
| `saida`      | Especifica o destino final dos dados processados.                      |
| `const`      | Declara uma constante, associando um nome a um valor.                 |
| `se` / `senao` | Utilizadas para controle de fluxo condicional.                         |
| `para` / `em`  | Utilizadas para laços de iteração sobre coleções de dados.             |
| `verdadeiro` | Literal booleano para o valor "verdadeiro".                            |
| `falso`      | Literal booleano para o valor "falso".                                 |
| `nulo`       | Representa a ausência intencional de um valor.                         |

### 2.2. Identificadores

Identificadores são nomes criados pelo programador para se referir a constantes, variáveis ou outros elementos da linguagem.

* **Regras de Nomenclatura:**
    1.  Devem iniciar com uma letra (maiúscula ou minúscula, `a-z`, `A-Z`) ou um sublinhado (`_`).
    2.  Após o caractere inicial, podem conter qualquer sequência de letras, números (`0-9`) e sublinhados.
    3.  São ***case-sensitive***, o que significa que `DataSource` e `datasource` são considerados dois identificadores diferentes.

* **Exemplos de Uso:**
    ```fluxer
    const _VALOR_TEMPORARIO = 100
    const usuarios_ativos = fonte "dados.csv"
    ```
* **Exemplos Válidos:** `dados_brutos`, `_temp`, `usuario1`, `PI`.
* **Exemplos Inválidos:** `1nome` (começa com número), `meu-valor` (contém hífen).

### 2.3. Literais

Literais são representações de valores fixos no código-fonte.

#### 2.3.1. Literais Numéricos

A linguagem Fluxer suporta números inteiros e de ponto flutuante.

* **Inteiros:** Podem ser representados em quatro bases numéricas:
    * **Decimal:** Sequência de dígitos de 0 a 9.
        ```fluxer
        const IDADE = 30
        ```
    * **Hexadecimal:** Devem ser precedidos por `0x` ou `0X`.
        ```fluxer
        const COR_VERMELHA = 0xFF0000
        ```
    * **Binário:** Devem ser precedidos por `0b` ou `0B`.
        ```fluxer
        const MASCARA_BITS = 0b10101010
        ```
    * **Octal:** Devem ser precedidos por `0`.
        ```fluxer
        const PERMISSOES = 0755
        ```
* **Ponto Flutuante (Floats):** Representam números reais. Devem conter um ponto decimal (`.`) e/ou um expoente (`e` ou `E`).
    ```fluxer
    const PI = 3.14159
    const VELOCIDADE_LUZ = 2.99792e8 -- Notação científica
    ```

#### 2.3.2. Literais de String

* **Delimitadores:** Sequências de caracteres delimitadas por aspas duplas (`"`).
* **Strings Multilinha:** É permitido que o conteúdo de uma string se estenda por múltiplas linhas.
* **Caracteres de Escape:** Sequências especiais para representar caracteres de controle.

| Sequência | Significado        |
| :-------- | :----------------- |
| `\n`      | Nova Linha         |
| `\t`      | Tabulação          |
| `\"`      | Aspas Duplas       |
| `\\`      | Barra Invertida    |

* **Exemplo de Uso:**
    ```fluxer
    const MENSAGEM = "Olá, Fluxer!
    Este texto está em uma nova linha.
    Aqui temos uma tabulação: 	 e aqui uma citação: \"Obrigado!\"
    Caminho de arquivo: C:\\arquivos\\novo.txt"
    ```

### 2.4. Operadores e Símbolos

| Categoria      | Símbolos                                       |
| :------------- | :--------------------------------------------- |
| **Aritméticos** | `+`, `-`, `*`, `/`, `%` (módulo), `^` (potência) |
| **Relacionais** | `==`, `!=`, `<`, `>`, `<=`, `>=`               |
| **Lógicos** | `e` (AND), `ou` (OR), `nao` (NOT)              |
| **Atribuição** | `=`, `+=`, `-=`, `*=`, `/=`                      |
| **Pipeline** | `->` (conecta etapas do fluxo de dados)        |
| **Delimitadores**| `( )`, `{ }`, `[ ]`                            |
| **Pontuação** | `,`, `:`                                       |

* **Exemplo de Uso:**
    ```fluxer
    const IMPOSTO = 0.07
    filtro (produto) se (produto.preco * (1 + IMPOSTO)) <= 50.0 e produto.em_estoque == verdadeiro ->
    transforma (p) { nome: p.nome }
    ```

### 2.5. Comentários

Comentários são trechos do código ignorados pelo analisador, usados para documentação.

* **Comentário de Linha:** Começa com hífens duplos (`--`) e se estende até o final da linha.
* **Comentário de Bloco:** Começa com `(*` e termina com `*)`. Pode se estender por múltiplas linhas, mas **não** suporta aninhamento.

* **Exemplo de Uso:**
    ```fluxer
    -- Esta constante define o número máximo de itens
    const LIMITE = 100

    (*
      O bloco de código a seguir processa os dados de entrada.
      Qualquer texto aqui dentro, em múltiplas linhas,
      será completamente ignorado pelo analisador.
      Um (* novo bloco *) aqui dentro não funcionaria.
    *)
    fonte "dados.csv" -> saida "copia.csv"
    ```

### 2.6. Espaços em Branco

Caracteres de espaço, tabulação (`\t`), e quebras de linha (`\n`, `\r`) são considerados espaços em branco. Eles são usados para separar tokens e melhorar a legibilidade do código, mas, fora das strings, são ignorados pelo analisador. Múltiplos espaços são tratados como um único separador.
