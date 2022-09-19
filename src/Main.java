import org.antlr.v4.runtime.*;

public class Main {
    public static void main(String[] args) {
        try {
            CharStream input = new ANTLRFileStream("E:\\College\\Sem 7\\Compiler Design\\Project\\src\\Input");

             CPP_ParserLexer lexer = new CPP_ParserLexer(input);
             CommonTokenStream Tokens = new CommonTokenStream(lexer);
             CPP_ParserParser Parser = new CPP_ParserParser(Tokens);
            System.out.println(Parser.equation());
            System.out.println(Parser.getNumberOfSyntaxErrors());
        }
        catch(Exception e){
            System.out.println(e);
        }
    }
}
