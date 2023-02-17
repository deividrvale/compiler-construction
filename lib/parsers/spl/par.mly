%{
  open Syntax.Type
%}

%token <string> ID
%token <int> INTEGER

// Keywords
%token VAR
%token VOID
%token ARROW
%token TAIL
%token HEAD
%token FST
%token SND

%token IF
%token ELSE
%token WHILE
%token RETURN

%token EQ
%token COLCOL
%token SEMICOL

%token COMMA
%token DOT

// Binary Operators
%token PLUS
%token MINUS
%token MULT
%token DIVIDE
%token MOD
%token EQEQ
%token LT
%token GT
%token LEQ
%token GEQ
%token NEQ
%token AND
%token OR
%token CONS

// Unary Operators
%token NEG


// Primite Constructors
%token FALSE
%token TRUE
%token NIL

// Delimiters
%token LPAR
%token RPAR
%token LBRACE
%token RBRACE
%token LBRACKET
%token RBRACKET

// Primitive Types
%token INT
%token BOOL
%token CHAR

%token EOF

%start id debug_parser

%type <string> id
%type < basicTypes > basic_type
%type < 'a > debug_parser

%%

id :
  ID EOF { $1 }

basic_type:
  | INT         { Int }
  | BOOL        { Bool }
  | CHAR        { Char }

// Debug parser
debug_parser :
  basic_type EOF { $1 }
