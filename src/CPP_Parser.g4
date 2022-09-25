grammar CPP_Parser;

equation:
    exp {System.out.println("success.");};
    exp: (header | variable | variable_initialization1) functions* |functions| SemiColon;

    header: header header|include_macro|define_macro|pragma_macro;

    include_macro: Hash Include (IncludeMethon1 | IncludeMethon2);
    define_macro: Hash Define (Identifier param | Identifier);
    pragma_macro: Hash Pragma (StartUp|Exit) Identifier;

    functions: (function_definition | function_declaration);
    function_declaration:function_type_declaration (Identifier | (Pointer Identifier)) (LPAREN params_declaration | LPAREN) RPAREN SemiColon;
    function_call:function_type_declaration (Identifier | (Pointer Identifier)) (LPAREN params | LPAREN) RPAREN SemiColon;
    function_definition:function_type_declaration (Identifier | (Pointer Identifier)) (LPAREN params_declaration | LPAREN) RPAREN LBrace (code RBrace|RBrace);

    code: function_call | variable|variable_initialization1|(equ SemiColon) | variable_initialization2 | SemiColon|for | code (code|Return equ  SemiColon);

    params_declaration:params_declaration Comma params_declaration|param_declaration;
    param_declaration: data_type_declaration Identifier;

    params:params Comma params|param;
    param: (Identifier | IntValue | FloatValue | CharValue);

    variable: data_type_declaration (Identifier (Comma Identifier)*) SemiColon;
    variable_initialization1: data_type_definition Identifier Equals equ SemiColon;
    variable_initialization2: Identifier assignment equ SemiColon;

    equ:  equ (Plus) term| term | equ (Minus) term ;
    term : term (Mult) factor| factor |term (Div) factor;
    factor: LPAREN equ RPAREN | (IntValue | FloatValue | CharValue| Identifier);

    for:(for1|for2|for3) (SemiColon|(LBrace (code RBrace|RBrace)));
    for1:For LPAREN ((variable_initialization1|variable_initialization2)|SemiColon) ((conditional SemiColon)|SemiColon) (Identifier assignment equ|SemiColon) RPAREN;
    for2: For LPAREN data_type_definition Identifier Colon Identifier RPAREN;
    for3: For LPAREN data_type_definition Reference Identifier Colon Identifier RPAREN;

    conditional:(Identifier|IntValue|FloatValue) (LessThan|LessThanEqualTo|EqualTo|NotEqual|GreaterThan|GreaterThanEqualTo) (Identifier|IntValue|FloatValue);
    assignment:Equals|PlusEquals|MinusEquals|MultiEquals|DivEqulas|ModEquals|BAndEquals|BOrEquals|BXorEquals|BLeftShiftEquals|BRightShiftEquals;

data_type_declaration:
    data_type_declaration_decl {System.out.println("datatype.");};
    data_type_declaration_decl: (data_type_declaration_prefixes data_type_declaration_dtype|data_type_declaration_dtype);
    data_type_declaration_dtype: Auto | Char | Double | Float | Int | Short | Void | Long;
    data_type_declaration_prefixes: data_type_declaration_prefixes data_type_declaration_prefix |data_type_declaration_prefix;
    data_type_declaration_prefix: Const| Extern | Long | Static | Signed | Unsigned | Volatile;

data_type_definition:
    data_type_definition_decl {System.out.println("datatype.");};
    data_type_definition_decl: (data_type_definition_prefixes data_type_definition_dtype|data_type_definition_dtype);
    data_type_definition_dtype: Auto | Char | Double | Float | Int | Short | Void | Long;
    data_type_definition_prefixes: data_type_definition_prefixes data_type_definition_prefix |data_type_definition_prefix;
    data_type_definition_prefix: Const| Long | Static | Signed | Unsigned | Volatile;

function_type_declaration:
    fun_type_decl {System.out.println("datatype.");};
    fun_type_decl: (fun_type_decl_prefixes fun_type_decl_dtype|fun_type_decl_dtype);
    fun_type_decl_dtype: Auto | Char | Double | Float | Int | Short | Void | Long;
    fun_type_decl_prefixes: fun_type_decl_prefixes fun_type_decl_prefix |fun_type_decl_prefix;
    fun_type_decl_prefix: Const| Extern | Inline | Long | Static | Signed | Unsigned | Volatile;

Hash: '#';
Colon: ':';
Include: 'include';
IncludeMethon1: '"'[a-zA-Z][a-z.A-Z0-9]*'"';
IncludeMethon2: '<'[a-zA-Z][a-z.A-Z0-9]*'>';
Auto: 'auto';
Bool: 'bool';
Char: 'char';
Const: 'const';
Double: 'double';
Extern: 'extern';
Float:'float';
For:'for';
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
Pragma: 'pragma';
StartUp: 'startup';
Exit: 'exit';
Identifier: [a-zA-Z][a-zA-Z0-9]* {System.out.println("Identifier");};

EqualTo: '==';
NotEqual: '!=';
GreaterThan: '>';
LessThan: '<';
GreaterThanEqualTo: '>=';
LessThanEqualTo: '<=';

PlusEquals: '+=';
MinusEquals: '-=';
MultiEquals: '*=';
DivEqulas: '/=';
ModEquals: '%=';
BAndEquals: '&=';
BOrEquals: '|=';
BXorEquals: '^=';
BLeftShiftEquals: '<<=';
BRightShiftEquals: '>>=';
Equals: '=';

Reference: '&';

LPAREN: '(' {System.out.println("LParen");};
RPAREN: ')' {System.out.println("RParen");};
LBrace: '{' {System.out.println("LCurly");};
RBrace: '}' {System.out.println("RCurly");};

Plus: '+';
Minus: '-';
Mult: '*';
Div: '/';
Mod: '%';
Inc: '++';
Dec: '--';

IntValue: ([0-9]+|'-'[0-9]+) {System.out.println("Number");};
CharValue: [a-zA-Z] {System.out.println("Char");};
FloatValue: ([0-9]+'.'[0-9]+|'-'[0-9]+'.'[0-9]+) {System.out.println("Float value");};

WS: [ \r\n\t] + -> skip;