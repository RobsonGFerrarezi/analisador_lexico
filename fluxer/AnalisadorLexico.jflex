/*
 * ======================================================================================
 * Seção 1: Código de Usuário
 * ======================================================================================
 * Esta é a primeira seção de um arquivo de especificação JFlex.
 * Todo o código Java escrito aqui é copiado literalmente para o início do arquivo .java
 * que será gerado pelo JFlex. É o local ideal para declarações de pacote,
 * importações de bibliotecas e definição de classes auxiliares que o analisador possa precisar.
 *
 * Versão Corrigida: Lógica de String refeita e Comentários de Bloco simplificados.
 */

// Define o pacote (namespace) ao qual a classe do analisador pertencerá.
// Isso é fundamental para a organização do projeto e para permitir que o analisador
// acesse outras classes do mesmo pacote, como 'TokenLexico' e 'TipoToken'.

package fluxer;

// A diretiva '%%' é um separador obrigatório entre as seções do arquivo .jflex.
%%

/*
 * ======================================================================================
 * Seção 2: Opções e Declarações
 * ======================================================================================
 * Nesta seção, configuramos o comportamento do analisador léxico que será gerado
 * e declaramos "macros", que são apelidos para expressões regulares, ajudando a
 * manter a seção de regras mais limpa, legível e fácil de manter.
 */

// --- Diretivas de Configuração do JFlex ---

// %class: Define o nome da classe Java que o JFlex irá gerar.
%class FluxerLexer

// %public: Faz com que a classe gerada seja 'public', permitindo seu uso por
// classes em outros pacotes (como uma classe 'Main' para testes).
%public

// %type: Especifica o tipo de retorno do método principal de análise, o yylex().
// Estamos dizendo que cada chamada a yylex() retornará um objeto do tipo 'TokenLexico'.
%type TokenLexico

// %line: Habilita o rastreamento automático do número da linha. Uma variável inteira
// 'yyline' estará disponível nas ações das regras.
%line

// %column: Habilita o rastreamento automático do número da coluna. Uma variável inteira
// 'yycolumn' estará disponível.
%column

// --- Estados Léxicos ---
// %state: Declara um "estado léxico". Estados são usados para criar diferentes conjuntos de
// regras para contextos específicos, como estar dentro de uma string ou de um comentário,
// onde os caracteres devem ser interpretados de forma diferente.
%state STRING
%state BLOCO_COMENTARIO

// --- Bloco de Código da Classe (Atributos e Métodos) ---
// O código Java dentro de '%{' e '%}' é injetado diretamente no corpo da classe gerada.
// É usado para declarar atributos (variáveis de instância) e métodos auxiliares.
%{
    // Um StringBuilder é usado como um buffer para construir eficientemente o conteúdo
    // de uma string, pedaço por pedaço, conforme ela é lida do arquivo de entrada.
    private StringBuilder stringContent = new StringBuilder();

    // Variáveis para armazenar a linha e a coluna onde uma string começa.
    // Isso é necessário porque o token só é criado no final da string, mas sua
    // posição correta é a do início.
    private int stringStartLine;
    private int stringStartColumn;

    // O contador de aninhamento de comentários que existia antes foi REMOVIDO
    // para simplificar a lógica, conforme solicitado.
%}

/*
 * --- Definição de Macros (Apelidos para Expressões Regulares) ---
 * Macros são usadas para dar nomes a expressões regulares, melhorando a legibilidade.
 */
// Macro para reconhecer diferentes tipos de quebra de linha (Windows, Unix, Mac antigo).
QUEBRA_LINHA = \r|\n|\r\n
// Macro para um único caractere de espaço em branco ou uma quebra de linha.
ESPACO = {QUEBRA_LINHA} | [ \t\f]

// Macro para uma única letra, maiúscula ou minúscula.
LETRA = [a-zA-Z]
// Macro para um único dígito decimal.
DIGITO = [0-9]
// Macro para um IDENTIFICADOR: deve começar com uma letra, seguida por zero ou mais
// letras, dígitos ou o caractere de sublinhado ('_').
IDENTIFICADOR = ({LETRA}|_)({LETRA}|{DIGITO}|_)*

// --- Macros para Literais Numéricos ---
DECIMAL = {DIGITO}+                      // Ex: 123
HEX = 0[xX][0-9a-fA-F]+             // Ex: 0xFF, 0x1a
BINARIO = 0[bB][01]+                   // Ex: 0b1011
OCTAL = 0[0-7]+                        // Ex: 077
// INTEIRO é uma união de todos os formatos de inteiro definidos.
INTEIRO = {DECIMAL} | {HEX} | {BINARIO} | {OCTAL}
// FLOAT define um número de ponto flutuante, cobrindo notação padrão e científica.
FLOAT = {DIGITO}+\.{DIGITO}*([eE][+-]?{DIGITO}+)? | \.{DIGITO}+([eE][+-]?{DIGITO}+)? | {DIGITO}+[eE][+-]?{DIGITO}+

// Separa a seção de declarações da seção de regras.
%%

/*
 * ======================================================================================
 * Seção 3: Regras Léxicas
 * ======================================================================================
 * Esta é a seção principal, onde associamos padrões (expressões regulares) com
 * ações (código Java). O JFlex testa as regras de cima para baixo e aplica a regra
 * que tiver o "casamento mais longo" (longest match).
 */

// As regras abaixo só são válidas quando o analisador está no estado <YYINITIAL> (o padrão).
<YYINITIAL> {
    /* Ignorar Espaços em Branco */
    // Reconhece uma ou mais ocorrências de espaços em branco e não faz nada (ação vazia),
    // efetivamente ignorando-os.
    {ESPACO}+                             { /* Ação vazia, simplesmente ignora */ }

    /* Comentários */
    // Reconhece '--' e todos os caracteres (.*) até o final da linha. Ação vazia para ignorar.
    "--".* { /* Comentário de linha: ignora o resto da linha */ }
    // Ao encontrar o início de um comentário de bloco '(*', muda o estado do analisador.
    "(*"                                  { yybegin(BLOCO_COMENTARIO); } // Inicia comentário de bloco

    /* Palavras Reservadas (devem vir antes da regra de IDENTIFICADOR) */
    // Regras para cada palavra-chave da linguagem. A ação é criar e retornar um
    // novo 'TokenLexico' com o tipo apropriado.
    // yytext() -> retorna o texto casado pela regra.
    // yyline -> retorna a linha atual.
    // yycolumn -> retorna a coluna atual.
    "fonte"                               { return new TokenLexico(TipoToken.FONTE, yytext(), yyline, yycolumn); }
    "filtro"                              { return new TokenLexico(TipoToken.FILTRO, yytext(), yyline, yycolumn); }
    "transforma"                          { return new TokenLexico(TipoToken.TRANSFORMA, yytext(), yyline, yycolumn); }
    "agrega"                              { return new TokenLexico(TipoToken.AGREGA, yytext(), yyline, yycolumn); }
    "saida"                               { return new TokenLexico(TipoToken.SAIDA, yytext(), yyline, yycolumn); }
    "const"                               { return new TokenLexico(TipoToken.CONST, yytext(), yyline, yycolumn); }
    "se"                                  { return new TokenLexico(TipoToken.SE, yytext(), yyline, yycolumn); }
    "senao"                               { return new TokenLexico(TipoToken.SENAO, yytext(), yyline, yycolumn); }
    "para"                                { return new TokenLexico(TipoToken.PARA, yytext(), yyline, yycolumn); }
    "em"                                  { return new TokenLexico(TipoToken.EM, yytext(), yyline, yycolumn); }
    "verdadeiro"                          { return new TokenLexico(TipoToken.VERDADEIRO, yytext(), yyline, yycolumn); }
    "falso"                               { return new TokenLexico(TipoToken.FALSO, yytext(), yyline, yycolumn); }
    "nulo"                                { return new TokenLexico(TipoToken.NULO, yytext(), yyline, yycolumn); }
    "e" | "ou" | "nao"                   { return new TokenLexico(TipoToken.OP_LOGICO, yytext(), yyline, yycolumn); }

    /* Literais */
    {INTEIRO}                             { return new TokenLexico(TipoToken.NUMERO_INT, yytext(), yyline, yycolumn); }
    {FLOAT}                               { return new TokenLexico(TipoToken.NUMERO_FLOAT, yytext(), yyline, yycolumn); }
    
    // CORREÇÃO: Lógica para iniciar a captura de uma string.
    // Ao encontrar aspas duplas de abertura...
    \"                                    {
                                              // 1. Limpa o buffer de qualquer conteúdo de string anterior.
                                              stringContent.setLength(0);
                                              // 2. Salva a linha e coluna atuais como a posição de início da string.
                                              stringStartLine = yyline;
                                              stringStartColumn = yycolumn;
                                              // 3. Muda o estado do analisador para STRING, ativando as regras daquele estado.
                                              yybegin(STRING);
                                          }

    /* Identificador (regra genérica, vem depois das palavras-chave para não haver conflito) */
    {IDENTIFICADOR}                       { return new TokenLexico(TipoToken.IDENTIFICADOR, yytext(), yyline, yycolumn); }

    /* Operadores e Símbolos (do mais longo para o mais curto para garantir o "longest match") */
    "->"                                  { return new TokenLexico(TipoToken.OP_PIPELINE, yytext(), yyline, yycolumn); }
    "==" | "!=" | "<=" | ">="             { return new TokenLexico(TipoToken.OP_RELACIONAL, yytext(), yyline, yycolumn); }
    "<" | ">"                             { return new TokenLexico(TipoToken.OP_RELACIONAL, yytext(), yyline, yycolumn); }
    "+=" | "-=" | "*=" | "/="             { return new TokenLexico(TipoToken.OP_ATRIBUICAO, yytext(), yyline, yycolumn); }
    "="                                   { return new TokenLexico(TipoToken.OP_ATRIBUICAO, yytext(), yyline, yycolumn); }
    "+" | "-" | "*" | "/" | "%" | "^"     { return new TokenLexico(TipoToken.OP_ARITMETICO, yytext(), yyline, yycolumn); }
    "("                                   { return new TokenLexico(TipoToken.PARENTESES_ESQ, yytext(), yyline, yycolumn); }
    ")"                                   { return new TokenLexico(TipoToken.PARENTESES_DIR, yytext(), yyline, yycolumn); }
    "{"                                   { return new TokenLexico(TipoToken.CHAVES_ESQ, yytext(), yyline, yycolumn); }
    "}"                                   { return new TokenLexico(TipoToken.CHAVES_DIR, yytext(), yyline, yycolumn); }
    "["                                   { return new TokenLexico(TipoToken.COLCHETES_ESQ, yytext(), yyline, yycolumn); }
    "]"                                   { return new TokenLexico(TipoToken.COLCHETES_DIR, yytext(), yyline, yycolumn); }
    ","                                   { return new TokenLexico(TipoToken.VIRGULA, yytext(), yyline, yycolumn); }
    ":"                                   { return new TokenLexico(TipoToken.DOIS_PONTOS, yytext(), yyline, yycolumn); }

    /* Tratamento de Erro ("pega-tudo", deve ser a última regra do estado) */
    // O ponto "." casa com qualquer caractere que não foi casado pelas regras anteriores.
    // Isso captura todos os símbolos ou caracteres inesperados.
    .                                     { return new TokenLexico(TipoToken.ERRO, yytext(), yyline, yycolumn); }
}

// --- Regras para o Estado STRING ---
// Estas regras só são ativadas quando o analisador está no estado <STRING>.
<STRING> {
    // Fim da string: encontra aspas duplas de fechamento.
    \" {
        yybegin(YYINITIAL); // Volta para o estado normal de análise.
        // Retorna um token de STRING, usando o CONTEÚDO ACUMULADO no StringBuilder
        // e a POSIÇÃO INICIAL que foi salva quando a string começou.
        return new TokenLexico(TipoToken.STRING, stringContent.toString(), stringStartLine, stringStartColumn);
    }

    // Caracteres de escape: reconhece uma barra seguida de n, t, " ou \.
    \\[nt\"\\] {
        // Usa um switch para "traduzir" a sequência de escape para o caractere real
        // e o adiciona ao buffer da string.
        switch (yytext().charAt(1)) {
            case 'n': stringContent.append('\n'); break;         // \n -> nova linha
            case 't': stringContent.append('\t'); break;         // \t -> tabulação
            case '"': stringContent.append('"'); break;         // \" -> aspas duplas
            case '\\': stringContent.append('\\'); break;        // \\ -> barra invertida
        }
    }

    // Conteúdo normal da string: uma ou mais ocorrências de qualquer caractere que
    // NÃO seja quebra de linha, aspas duplas ou barra invertida.
    [^\n\r\"\\]+ {
        stringContent.append(yytext()); // Adiciona o texto encontrado diretamente ao buffer.
    }

    // Quebra de linha: permite que strings se estendam por múltiplas linhas.
    {QUEBRA_LINHA} {
        stringContent.append(yytext()); // Adiciona a própria quebra de linha ao buffer.
    }

    // Erro: Fim do arquivo (<<EOF>>) encontrado antes de fechar a string.
    <<EOF>> {
        System.err.println("ERRO: String não terminada no final do arquivo.");
        yybegin(YYINITIAL); // Retorna ao estado inicial para evitar problemas.
        // Retorna um token de erro para sinalizar o problema.
        return new TokenLexico(TipoToken.ERRO, "String não terminada", stringStartLine, stringStartColumn);
    }
}

// --- Regras para o Estado BLOCO_COMENTARIO ---
// Lógica SIMPLIFICADA: agora, não suporta mais aninhamento.
<BLOCO_COMENTARIO> {
    // Se encontrar o final do bloco "*)", a única ação é voltar ao estado inicial.
    "*)" {
        yybegin(YYINITIAL);
    }

    // Erro: Fim do arquivo encontrado antes de fechar o comentário.
    <<EOF>> {
        System.err.println("ERRO: Bloco de comentário não terminado no final do arquivo.");
        yybegin(YYINITIAL);
    }

    // Ignora qualquer outro caractere ou quebra de linha dentro do comentário.
    // O ponto "." casa com qualquer caractere, e {QUEBRA_LINHA} com as quebras de linha.
    . | {QUEBRA_LINHA} { /* Ação vazia, apenas consome e ignora o conteúdo do comentário */ }
}