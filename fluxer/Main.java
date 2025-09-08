package fluxer;

import java.io.FileReader;
import java.io.IOException;

///usar o comando
/// java -jar jflex-full-1.9.1.jar fluxer/AnalisadorLexico.jflex
/// para gerar o Lexer.java
// Depois compilar com 
// javac fluxer/*.java -> cria .class dos arquivos .java
//e rodar com java fluxer.Main

public class Main {
    public static void main(String[] args) {
        // --- INÍCIO DAS MUDANÇAS ---

        // 1. Verifica se o usuário forneceu pelo menos um argumento.
        // O array 'args' tem um tamanho (length) de 0 se nada for passado.
        if (args.length == 0) {
            // Se nenhum arquivo foi passado, imprime uma mensagem de ajuda e encerra.
            // System.err é usado para mensagens de erro.
            System.err.println("Erro: Nenhum arquivo de entrada foi especificado.");
            System.err.println("Uso: java fluxer.Main <caminho_para_o_arquivo>");
            return; // Encerra o método main.
        }

        // 2. Pega o primeiro argumento (o nome do arquivo) do array.
        String nomeDoArquivo = args[0];

        // --- FIM DAS MUDANÇAS ---

        try {
            // 3. Usa a variável 'nomeDoArquivo' para abrir o arquivo,
            // em vez do valor fixo "teste.txt".
            FileReader reader = new FileReader(nomeDoArquivo);
            FluxerLexer lexer = new FluxerLexer(reader);

            System.out.println("Analisando o arquivo: " + nomeDoArquivo);
            System.out.println("----------------------------------------------");

            TokenLexico token;
            while ((token = lexer.yylex()) != null) {
                System.out.println(token);
            }
            System.out.println("----------------------------------------------");
            System.out.println("Análise concluída.");

        } catch (IOException e) {
            System.err.println("Erro ao ler o arquivo '" + nomeDoArquivo + "': " + e.getMessage());
        }
    }
}