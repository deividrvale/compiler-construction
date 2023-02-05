{
    open Lexing
    open Par

    exception SyntaxError of string
}

(* Definitions for textual structure *)
let espace      = [' ' '\t']+
let identifier  = ['a'-'z' 'A'-'Z'] ['a'-'z' '_' 'A'-'Z' '0'-'9']*
let digit       = ['0'-'9']
let int         = ['-'] digit+
let newLine     = '\r' | '\n' | "\r\n"

(*  *)
rule lexer = parse
  | newLine         { new_line lexbuf; lexer lexbuf }
  | espace          { lexer lexbuf }
  | "var"           { VAR }
  | "Void"          { VOID }
  | "tl"            { TAIL }
  | "hd"            { HEAD }
  | "fst"           { FST }
  | "snd"           { SND }
  | "if"            { IF }
  | "else"          { ELSE }
  | "while"         { WHILE }
  | "return"        { RETURN }
  | "Int"           { INT }
  | "Bool"          { BOOL }
  | "Char"          { CHAR }
  | "True"          { TRUE }
  | "False"         { FALSE }
  | "->"            { ARROW }
  | "(*"            { comment lexer lexbuf }
  | "("             { LPAR }
  | ")"             { RPAR }
  | "[]"            { NIL }
  | "["             { LBRACKET }
  | "]"             { RBRACKET }
  | "{"             { LBRACE }
  | "}"             { RBRACE }
  | "::"            { COLCOL }
  | ":"             { CONS }
  | ";"             { SEMICOL }
  | "."             { DOT }
  | ","             { COMMA }
  | "+"             { PLUS }
  | "-"             { MINUS }
  | "*"             { MULT }
  | "/"             { DIVIDE }
  | "%"             { MOD }
  | "=="            { EQEQ }
  | "!="            { NEQ }
  | "="             { EQ }
  | "!"             { NEG }
  | "<="            { LEQ }
  | ">="            { GEQ }
  | "<"             { LT }
  | ">"             { GT }
  | "&&"            { AND }
  | "||"            { OR }
  | identifier            { ID (Lexing.lexeme lexbuf) }
  | int          { INTEGER (int_of_string( Lexing.lexeme lexbuf )) }
  | _               { raise (SyntaxError ("Unexpected character: " ^ Lexing.lexeme lexbuf))}
  | eof             { EOF }

and comment continuation = parse
  | "*)" { continuation lexbuf }
  | "(*" { comment (comment continuation) lexbuf }
  | _    { comment continuation lexbuf }
