grammar CPP_Parser;

equation:
    exp {System.out.println("success.");};
    exp: (header | variable | variable_initialization1) functions* |functions| SemiColon;

    header: header header|include_macro|define_macro;

    include_macro: Hash Include (IncludeMethon1 | IncludeMethon2);
    define_macro: Hash Define (Identifier param | Identifier);

    functions: (function_definition | function_declaration);
    function_declaration:datatype (Identifier | (Pointer Identifier)) (LPAREN params_declaration | LPAREN) RPAREN SemiColon;
    function_call:datatype (Identifier | (Pointer Identifier)) (LPAREN params | LPAREN) RPAREN SemiColon;
    function_definition:datatype (Identifier | (Pointer Identifier)) (LPAREN params_declaration | LPAREN) RPAREN LBrace code RBrace;

    code: function_call | variable|variable_initialization1|(equ SemiColon) | variable_initialization2 | SemiColon |forloop1| code (code|Return equ  SemiColon);

    params_declaration:params_declaration Comma params_declaration|param_declaration;
    param_declaration: datatype Identifier;

    params:params Comma params|param;
    param: (Identifier | IntValue | FloatValue | CharValue);

    variable: datatype (Identifier (Comma Identifier)*) SemiColon;
    variable_initialization1: datatype Identifier Equals equ SemiColon;
    variable_initialization2: Identifier Equals equ SemiColon;

    equ:  equ (PLUS) term| term | equ (MINUS) term ;
    term : term (TIMES) factor| factor;
    factor: LPAREN equ RPAREN | (IntValue | FloatValue | CharValue| Identifier);
    compare: Identifier LT (Identifier | IntValue);
    variterate:Identifier (Increment|Decrement);
    forloop1: For LPAREN (variable|variable_initialization1|variable_initialization2) SemiColon compare SemiColon variterate RPAREN;

datatype:
    datat {System.out.println("datatype.");};
    datat: (prefixes dtype|dtype);
    dtype: Auto | Char | Double | Float | Int | Short | Void | Long;
    prefixes: prefixes prefix |prefix;
    prefix: Extern | Inline | Long | Static | Signed | Unsigned | Volatile;

Hash: '#';
Include: 'include';
IncludeMethon1: '"'[a-zA-Z][a-zA-Z0-9]*'"';
IncludeMethon2: '<'[a-zA-Z][a-zA-Z0-9]*'>';
Auto: 'auto';
Bool: 'bool';
Char: 'char';
Double: 'double';
Extern: 'extern';
Float:'float';
Int: 'int';
Inline: 'inline';
Long: 'long';
Short: 'short';
Signed: 'signed';
Static: 'static';
Unsigned: 'unsigned';
Void: 'void';
Volatile: 'volatie';
Pointer: '*';
SemiColon: ';';
Comma: ',';
Return: 'return';
Define: 'define';
Identifier: [a-zA-Z][a-zA-Z0-9]* {System.out.println("Identifier");};

LPAREN: '(' {System.out.println("LParen");};
RPAREN: ')' {System.out.println("RParen");};
LBrace: '{' {System.out.println("LCurly");};
RBrace: '}' {System.out.println("RCurly");};
PLUS: '+' {System.out.println("Plus");};
MINUS: '-' {System.out.println("Minus");};
TIMES: '*'  {System.out.println("Times");};
DIV: '/' {System.out.println("Div");};
Equals: '=' {System.out.println("Equal");};
LT:'<';
Increment: '++';
Decrement: '--';

IntValue: ([0-9]+|'-'[0-9]+) {System.out.println("Number");};
CharValue: [a-zA-Z] {System.out.println("Char");};
FloatValue: ([0-9]+'.'[0-9]+|'-'[0-9]+'.'[0-9]+) {System.out.println("Float value");};

For: 'for';
Colon:':';

WS: [ \r\n\t] + -> skip;