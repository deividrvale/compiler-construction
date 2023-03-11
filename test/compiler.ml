open Poly_parser
let test_string =
"
if n < m then [] else m :: (range (m+1) n)
"

let parsed_string = ((parse_from_string debug_parser) lex) test_string

let () =
  parsed_string |> Syntax.Expr.string_of_expr |> print_endline
