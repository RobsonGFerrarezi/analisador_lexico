/*
 * -----------------------------------------------------------------------------
 * Seção 1: Código do Usuário e Declarações de Pacote
 * -----------------------------------------------------------------------------
 * O código nesta seção é copiado diretamente para o topo do arquivo .java gerado.
 */

// Define o pacote para a classe 'Lexer' gerada.
// É ESSENCIAL que seja o mesmo pacote das classes TokenLexico e TipoToken para que elas
// possam interagir sem a necessidade de 'import'.
package jflex_ex;


// A linha dupla de porcentagem (%%) separa as seções do arquivo .flex.
%%

/*
 * -----------------------------------------------------------------------------
 * Seção 2: Opções, Configurações e Macros
 * -----------------------------------------------------------------------------
 * Esta seção configura o comportamento do JFlex e permite definir "macros",
 * que são apelidos para expressões regulares complexas, tornando as regras mais limpas.
 */

// %class: Define o nome da classe Java que será gerada pelo JFlex.
%class Lexer

// %type: Especifica o tipo de objeto que será retornado pelas ações das regras.
// Aqui, estamos dizendo que nosso analisador retornará objetos da nossa classe 'TokenLexico'.
%type TokenLexico

// %line: Ativa a contagem de linhas. Uma variável 'yyline' estará disponível nas ações.
%line

// %column: Ativa a contagem de colunas. Uma variável 'yycolumn' estará disponível.
%column

/* Definição de Macros (apelidos para Expressões Regulares) */

// DIGITO: Define um apelido para qualquer caractere de 0 a 9.
DIGITO = [0-9]

// LETRA: Define um apelido para qualquer letra minúscula (a-z) ou maiúscula (A-Z).
LETRA = [a-zA-Z]

// ESPACO: Define um apelido para um ou mais (+) caracteres de espaço em branco,
// que incluem espaço, tabulação (\t), retorno de carro (\r) e nova linha (\n).
ESPACO = [ \t\r\n]+

// IDENTIFICADOR: Define a regra para um identificador.
// Deve começar com uma {LETRA}, seguida por zero ou mais (*) {LETRA}s ou {DIGITO}s.
IDENTIFICADOR = {LETRA}({LETRA}|{DIGITO})*

// NUMERO: Define a regra para um número inteiro.
// É uma sequência de um ou mais (+) {DIGITO}s.
NUMERO = {DIGITO}+

// A linha dupla de porcentagem (%%) separa as seções.
%%

/*
 * -----------------------------------------------------------------------------
 * Seção 3: Regras Léxicas
 * -----------------------------------------------------------------------------
 * Esta é a seção principal, onde associamos padrões (expressões regulares)
 * com ações (código Java). O JFlex testa as regras nesta ordem.
 */

// <YYINITIAL> é o estado padrão em que o analisador começa.
<YYINITIAL> {

    /* --- REGRAS PARA PALAVRAS-CHAVE --- */
    // A ordem é importante! As regras mais específicas (palavras-chave) devem
    // vir antes das regras mais genéricas (identificadores).

    // Se encontrar o texto literal "int"...
    "int"           { /* Ação Java: */ return new TokenLexico(TipoToken.PALAVRA_CHAVE, yytext()); }

    // Se encontrar o texto literal "while"...
    "while"         { /* Ação Java: */ return new TokenLexico(TipoToken.PALAVRA_CHAVE, yytext()); }


    /* --- REGRAS PARA TOKENS GENÉRICOS --- */

    // Se encontrar um padrão que corresponde à macro {IDENTIFICADOR}...
    // yytext() é uma função do JFlex que retorna o texto exato que casou com o padrão.
    {IDENTIFICADOR} { return new TokenLexico(TipoToken.IDENTIFICADOR, yytext()); }

    // Se encontrar um padrão que corresponde à macro {NUMERO}...
    {NUMERO}        { return new TokenLexico(TipoToken.NUMERO, yytext()); }


    /* --- REGRAS PARA OPERADORES --- */

    // Se encontrar o caractere literal "+"...
    "+"             { return new TokenLexico(TipoToken.OPERADOR, yytext()); }
    "-"             { return new TokenLexico(TipoToken.OPERADOR, yytext()); }
    "*"             { return new TokenLexico(TipoToken.OPERADOR, yytext()); }
    "/"             { return new TokenLexico(TipoToken.OPERADOR, yytext()); }


    /* --- REGRAS PARA IGNORAR CARACTERES --- */

    // Se encontrar um padrão que corresponde à macro {ESPACO}...
    {ESPACO}        { /* Ação vazia. O texto é reconhecido, mas nada é feito. Ele é simplesmente ignorado. */ }


    /* --- REGRA PARA TRATAMENTO DE ERROS (Panic Mode) --- */

    // O ponto (.) é uma expressão regular que casa com QUALQUER caractere, exceto nova linha.
    // Como esta é a última regra, ela só será ativada se nenhum dos padrões acima casar.
    // Isso a torna uma regra "pega-tudo" para caracteres inesperados/inválidos.
    .               {
                      // Imprime uma mensagem de erro detalhada no console de erro.
                      // Usamos (yyline + 1) e (yycolumn + 1) porque são baseadas em zero.
                      System.err.println("Erro Léxico: Caractere inesperado '" + yytext() + "' na linha " + (yyline + 1) + ", coluna " + (yycolumn + 1));
                      // Retorna um token especial de ERRO para que o resto do sistema (ex: um parser) saiba que algo deu errado.
                      return new TokenLexico(TipoToken.ERRO, yytext());
                    }
}