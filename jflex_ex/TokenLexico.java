// Define o pacote ao qual este arquivo pertence.
package jflex_ex;

/**
 * A classe Token é uma estrutura de dados para armazenar as informações de um
 * token individual reconhecido pelo analisador léxico.
 * Funciona como um "contêiner" que guarda o tipo do token e o texto original.
 */
public class TokenLexico {
    // Variável para armazenar o TIPO do token.
    // O tipo é um dos valores definidos no enum TipoToken (ex: IDENTIFICADOR,
    // NUMERO).
    public TipoToken type;

    // Variável para armazenar o texto exato (o lexema) que foi encontrado no
    // código-fonte.
    // Por exemplo, se o texto for "123", o 'type' será NUMERO e o 'lexeme' será
    // "123".
    public String lexeme;

    /**
     * Construtor da classe Token.
     * É usado para criar uma nova instância de um token.
     * 
     * @param type   O tipo do token (um valor do enum TokenType).
     * @param lexeme O texto original (string) do token.
     */
    public TokenLexico(TipoToken type, String lexeme) {
        // 'this.type' se refere à variável da classe, enquanto 'type' se refere ao
        // parâmetro do método.
        this.type = type;
        this.lexeme = lexeme;
    }

    /**
     * Sobrescreve o método padrão toString().
     * Este método é chamado automaticamente quando tentamos imprimir um objeto
     * Token
     * (ex: System.out.println(meuToken)).
     * Ele formata a saída para ser clara e legível, o que é ótimo para depuração.
     * 
     * @return Uma representação em String do objeto Token.
     */
    @Override
    public String toString() {
        return "Token [Tipo=" + type + ", Lexema='" + lexeme + "']";
    }
}