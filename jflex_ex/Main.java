package jflex_ex;

import java.io.FileReader;
import java.io.IOException;

///usar o comando
/// java -jar jflex-full-1.9.1.jar jflex_ex/AnalisadorLexico.flex
/// para gerar o Lexer.java
// Depois compilar com 
// javac jflex_ex/*.java -> cria .class dos arquivos .java
//e rodar com java jflex_ex.Main

public class Main {
    public static void main(String[] args) {
        try {
            Lexer lexer = new Lexer(new FileReader("teste.txt"));
            
            // A variável para armazenar o token agora deve ser do tipo 'TokenLexico'.
            TokenLexico token; // <-- MUDANÇA AQUI

            // A lógica do loop permanece a mesma.
            while ((token = lexer.yylex()) != null) {
                System.out.println(token);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}