package fluxer;

public class TokenLexico {
    TipoToken tipo;
    String lexema;
    int linha;
    int coluna;

    public TokenLexico(TipoToken tipo, String lexema, int linha, int coluna) {
        this.tipo = tipo;
        this.lexema = lexema;
        this.linha = linha;
        this.coluna = coluna;
    }

    @Override
    public String toString() {
        return String.format("Token[Tipo=%-15s, Lexema='%s', L:%d, C:%d]",
                             tipo, lexema, linha + 1, coluna + 1);
    }
}