// Definjflex_ex qual este arquivo pertence. Isso ajuda a organizar o código
// e permite que outras classes no mesmo pacote o encontrem facilmente.
package jflex_ex;

/**
 * TokenType é uma enumeração que representa todos os tipos possíveis de tokens
 * que nosso analisador léxico pode identificar.
 * Usar um enum em vez de strings ou números torna o código mais seguro contra
 * erros de digitação
 * e mais fácil de ler e manter.
 */
public enum TipoToken{
    // Representa um nome de variável, função, etc. Ex: "minhaVariavel", "soma".
    IDENTIFICADOR,

    // Representa um valor numérico inteiro. Ex: "123", "42".
    NUMERO,

    // Representa uma palavra com significado especial na linguagem. Ex: "int",
    // "while".
    PALAVRA_CHAVE,

    // Representa um operador aritmético. Ex: "+", "*".
    OPERADOR,

    // Representa um caractere ou sequência que não se encaixa em nenhuma outra
    // categoria.
    // É usado para marcar erros léxicos.
    ERRO
}