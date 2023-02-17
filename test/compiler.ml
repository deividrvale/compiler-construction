open Spl.Spl_parser
let test_string = "Char"

let parsed_string = ((parse_from_string debug_parser) lex) test_string

(* let () = *)
  (* print_endline parsed_string; *)
