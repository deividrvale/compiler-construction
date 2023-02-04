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
  | "(*"            { comment lexer lexbuf }
  | "[]"            { NIL }
  | "Int"           { INT }
  | "Bool"          { BOOL }
  | "Char"          { CHAR }
  | "("             { LPAR }
  | ")"             { RPAR }
  | "["             { LBRACE }
  | "]"             { RBRACE }
  | ":"             { CONS  }
  | "."             { DOT }
  | ","             { COMMA }
  | ";"             { SEMICOL }
  | "*"             { MULT }
  | "="             { EQ }
  | "->"            { ARROW }
  | identifier            { ID (Lexing.lexeme lexbuf) }
  | int          { INTEGER (int_of_string( Lexing.lexeme lexbuf )) }
  | _               { raise (SyntaxError ("Unexpected character: " ^ Lexing.lexeme lexbuf))}
  | eof             { EOF }

and comment continuation = parse
  | "*)" { continuation lexbuf }
  | "(*" { comment (comment continuation) lexbuf }
  | _    { comment continuation lexbuf }
