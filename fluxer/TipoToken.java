/* -------------------------- SEÇÃO 1: CÓDIGO DE USUÁRIO -------------------------- */
package fluxer;

// Enumeração para os tipos de token.
enum TipoToken {
    // Palavras Reservadas
    FONTE, FILTRO, TRANSFORMA, AGREGA, SAIDA, CONST, SE, SENAO, PARA, EM,
    VERDADEIRO, FALSO, NULO,

    // Identificadores e Literais
    IDENTIFICADOR, NUMERO_INT, NUMERO_FLOAT, STRING,

    // Operadores
    OP_ARITMETICO, OP_RELACIONAL, OP_LOGICO, OP_ATRIBUICAO, OP_PIPELINE,

    // Símbolos e Delimitadores
    PARENTESES_ESQ, PARENTESES_DIR, CHAVES_ESQ, CHAVES_DIR,
    COLCHETES_ESQ, COLCHETES_DIR, VIRGULA, DOIS_PONTOS,

    // Fim de Arquivo e Erro
    EOF, ERRO
}