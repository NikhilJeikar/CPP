grammar CPP_Parser;

equation:
    exp {System.out.println("success.");};
    exp: (header | variable | variable_initialization|SemiColon)* functions* |functions| SemiColon;

    header: header header|include_macro|define_macro|pragma_macro;

    include_macro: Hash Include (IncludeMethon1 | IncludeMethon2);
    define_macro: Hash Define (Identifier param | Identifier);
    pragma_macro: Hash Pragma (StartUp|Exit) Identifier;

    functions: (function_definition | function_declaration);
    function_declaration:function_type_declaration (Identifier | (Mult Identifier)) (LPAREN params_declaration | LPAREN) RPAREN SemiColon;
    function_call:Identifier (LPAREN params | LPAREN) RPAREN SemiColon;
    function_definition:function_type_declaration (Identifier | (Mult Identifier)) (LPAREN params_declaration | LPAREN) RPAREN LBrace (code RBrace|RBrace);

    code: function_call |variable_initialization|for |if|(expression SemiColon) | SemiColon|Comment|MultilineComment|Return expression  SemiColon| code code;

    params_declaration:params_declaration Comma params_declaration|param_declaration;
    param_declaration: data_type_declaration Identifier;

    params:params Comma params|param;
    param: (Identifier | IntValue | FloatValue | CharValue|StringValue|expression);

    variable_initialization: variable|variable_initialization1|variable_initialization2;
    variable: data_type_declaration (Identifier (Comma Identifier)*) SemiColon;
    variable_initialization1: data_type_definition  (Identifier|Identifier Equals expression) (Comma (Identifier|Identifier Equals expression))* SemiColon;
    variable_initialization2: Identifier assignment expression SemiColon;

    for:(for1|for2|for3)(SemiColon|(LBrace (code RBrace|RBrace)));
    for1:For LPAREN ((variable_initialization1|variable_initialization2)|SemiColon) ((conditional_expression SemiColon)|SemiColon) (((Identifier assignment expression)|(Inc|Dec)Identifier|Identifier(Inc|Dec))|SemiColon) RPAREN;
    for2: For LPAREN data_type_definition Identifier Colon Identifier RPAREN;
    for3: For LPAREN data_type_definition BitwiseAnd Identifier Colon Identifier RPAREN;

    if: IF LPAREN if_conditional RPAREN (LBrace code |LBrace) (RBrace| RBrace else);
    if_conditional: LPAREN if_conditional RPAREN|conditional|True|False| (Inc|Dec)Identifier|Identifier(Inc|Dec);
    else: Else LBrace (code RBrace|RBrace);

    conditional:((conditional_expression) (LessThan|LessThanEqualTo|EqualTo|NotEqual|GreaterThan|GreaterThanEqualTo) (conditional_expression))|True|False;
    assignment:Equals|PlusEquals|MinusEquals|MultiEquals|DivEqulas|ModEquals|BAndEquals|BOrEquals|BXorEquals|BLeftShiftEquals|BRightShiftEquals;

expression:
    mathematical_expression ;
    mathematical_expression: mathematical_expression (Inc|Dec) multiplicative_exp|multiplicative_exp;
    multiplicative_exp: multiplicative_exp (Mult|Div) additive_exp|additive_exp;
    additive_exp: additive_exp(Plus|Minus) shift_exp|shift_exp;
    shift_exp:shift_exp (LShit|RShift) relational_exp|relational_exp;
    relational_exp: relational_exp (LessThanEqualTo|LessThan|GreaterThanEqualTo|GreaterThan) equality_exp|equality_exp;
    equality_exp: equality_exp (EqualTo|NotEqual) b_and_exp|b_and_exp;
    b_and_exp: b_and_exp BitwiseAnd b_xor_exp|b_xor_exp;
    b_xor_exp: b_xor_exp BitwiseXor b_or_exp|b_or_exp;
    b_or_exp: b_or_exp BitwiseOr logical_and_exp|logical_and_exp;
    logical_and_exp: logical_and_exp LogicalAnd logical_or_exp|logical_or_exp;
    logical_or_exp: logical_or_exp LogicalOr conditional_exp|conditional_exp;
    conditional_exp:conditional_exp Conditional assignment_exp|assignment_exp;
    assignment_exp:assignment_exp assignment end|end;
    end: LPAREN mathematical_expression RPAREN | (IntValue | FloatValue | CharValue| Identifier|StringValue);

conditional_expression:
    mathematical_expression ;
    conditional_mathematical_expression: conditional_mathematical_expression (Inc|Dec) conditional_multiplicative_exp|conditional_multiplicative_exp;
    conditional_multiplicative_exp: conditional_multiplicative_exp (Mult|Div) conditional_additive_exp|conditional_additive_exp;
    conditional_additive_exp: conditional_additive_exp(Plus|Minus) conditional_shift_exp|conditional_shift_exp;
    conditional_shift_exp:conditional_shift_exp (LShit|RShift) conditional_b_and_exp|conditional_b_and_exp;
    conditional_b_and_exp: conditional_b_and_exp BitwiseAnd conditional_b_xor_exp|conditional_b_xor_exp;
    conditional_b_xor_exp: conditional_b_xor_exp BitwiseXor conditional_b_or_exp|conditional_b_or_exp;
    conditional_b_or_exp: conditional_b_or_exp BitwiseOr conditional_logical_and_exp|conditional_logical_and_exp;
    conditional_logical_and_exp: conditional_logical_and_exp LogicalAnd conditional_logical_or_exp|conditional_logical_or_exp;
    conditional_logical_or_exp: conditional_logical_or_exp LogicalOr conditional_conditional_exp|conditional_conditional_exp;
    conditional_conditional_exp:conditional_conditional_exp Conditional conditional_assignment_exp|conditional_assignment_exp;
    conditional_assignment_exp:conditional_assignment_exp assignment conditional_end|conditional_end;
    conditional_end: LPAREN conditional_mathematical_expression RPAREN | (IntValue | FloatValue | CharValue| Identifier|StringValue);

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
Else: 'else';
Float:'float';
For:'for';
IF: 'if';
Int: 'int';
Inline: 'inline';
Long: 'long';
Short: 'short';
Signed: 'signed';
Static: 'static';
Unsigned: 'unsigned';
Void: 'void';
Volatile: 'volatie';
SemiColon: ';';
Comma: ',';
Return: 'return';
Define: 'define';
Pragma: 'pragma';
StartUp: 'startup';
Exit: 'exit';
True: 'true';
False: 'false';
Identifier: [a-zA-Z][a-zA-Z0-9]* {System.out.println("Identifier");};

LShit: '<<';
RShift: '>>';
Inc: '++';
Dec: '--';
EqualTo: '==';
NotEqual: '!=';
LogicalAnd: '&&';
LogicalOr: '||';
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

GreaterThan: '>';
LessThan: '<';
Equals: '=';
Plus: '+';
Minus: '-';
Mult: '*';
Div: '/';
Mod: '%';
BitwiseAnd: '&';
BitwiseXor: '^';
BitwiseOr: '|';
Conditional: '?';

LPAREN: '(' {System.out.println("LParen");};
RPAREN: ')' {System.out.println("RParen");};
LBrace: '{' {System.out.println("LCurly");};
RBrace: '}' {System.out.println("RCurly");};

IntValue: ([0-9]+|'-'[0-9]+) {System.out.println("Number");};
CharValue: '\''[a-zA-Z]'\'' {System.out.println("Char");};
FloatValue: ([0-9]+'.'[0-9]+|'-'[0-9]+'.'[0-9]+) {System.out.println("Float value");};
StringValue:'"'[a-z A-Z0-9\n\t\r]*'"';
Comment: '//'[a-z A-Z0-9]*;
MultilineComment:'/*'[a-z A-Z0-9\n\t\r]*'*/';
WS: [ \r\n\t] + -> skip;