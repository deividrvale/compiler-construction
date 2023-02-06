open Type

type varDecl  =
  | Var   of id * exp
  | TyVar of types  * exp

and funDecl =
  { id      : id
  ; fargs   : fArgs
  ; funtype : funType
  ; vardecl : varDecl list
  ; stmt    : stmt
  }

and fArgs = id list

and stmt =
  | If      of exp * (stmt list) * (stmt option)
  | While   of exp * (stmt list)
  | Field   of id  * field       * exp
  | Funcall of funCall
  | Return  of exp option

and exp =
  | Field   of id * field
  (* Op2 *)
  | Plus    of exp * exp
  | Minus   of exp * exp
  | Mult    of exp * exp
  | Div     of exp * exp
  | Mod     of exp * exp
  | Eq      of exp * exp
  | Lt      of exp * exp
  | Gt      of exp * exp
  | Leq     of exp * exp
  | Geq     of exp * exp
  | Neq     of exp * exp
  | And     of exp * exp
  | Or      of exp * exp
  (* Op1 *)
  | Neg     of exp
  (*  The unary operator `-x` is rendered as `0 - x` in the syntax tree. *)
  | Int     of int
  | Char    of char
  | False | True
  | Funcall of funCall
  | Nil
  | Tuple   of exp * exp


and field = (field_options list) option
and field_options =
  | Hd | Tl | Fst | Snd

and funCall = id * (actArgs option)

and actArgs = exp * exp list

and id = string


