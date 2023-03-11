(** Abstract syntax *)

(** The type of variable names. *)
type name = string

(** Types in Poly. *)
type ty =
  | TInt                     (** integers [int] *)
  | TBool                    (** booleans [bool] *)
  | TVar of int              (** type variables *)
  | TTimes of ty * ty  (** Product [s * t] *)
  | TArrow of ty * ty  (** Function type [s -> t] *)
  | TList of ty           (** Lists *)

(** Poly expressions. *)
type expr =
  | Var of name          (* variable *)
  | Int of int           (* integer constant *)
  | Bool of bool         (* boolean value *)
  | Times of expr * expr (* product [e1 * e2] *)
  | Divide of expr * expr(* quotient [e1 / e2] *)
  | Mod of expr * expr   (* remainder [e1 % e2] *)
  | Plus of expr * expr  (* sum [e1 + e2] *)
  | Minus of expr * expr (* difference [e1 - e2] *)
  | Equal of expr * expr (* integer equality [e1 = e2] *)
  | Less of expr * expr  (* integer comparison [e1 < e2] *)
  | If of expr * expr * expr (* conditional [if e1 then e2 else e3] *)
  | Fun of name * expr   (* function [fun x -> e] *)
  | Apply of expr * expr (* application [e1 e2] *)
  | Pair of expr * expr  (* ordered pair [(e1, e2)] *)
  | Fst of expr          (* first projection [fst e] *)
  | Snd of expr          (* second projection [snd e] *)
  | Rec of name * expr   (* recursion [rec x is e] *)
  | Nil                  (* empty list *)
  | Cons of expr * expr  (* cons list *)
  | Match of expr * expr * name * name * expr
      (* list decomposition [match e with [] -> e1 | x::y -> e2] *)


(** [string_of_expr e] converts expression [e] to string. *)
let string_of_expr e =
  let rec to_str n e =
    let (m, str) =
      match e with
	  Int n ->          (10, string_of_int n)
	| Bool b ->         (10, string_of_bool b)
	| Var x ->          (10, x ^ "*")
	| Pair (e1, e2) ->  (10, "(" ^ (to_str 0 e1) ^ ", " ^ (to_str 0 e2) ^ ")")
	| Nil ->            (10, "[]")
	| Fst e ->           (9, "fst " ^ (to_str 9 e))
	| Snd e ->           (9, "snd " ^ (to_str 9 e))
	| Apply (e1, e2) ->
      (* (10, "<app>") *)
	    (9, (to_str 8 e1) ^ " " ^ (to_str 9 e2))
	| Times (e1, e2) ->  (8, (to_str 7 e1) ^ " * " ^ (to_str 8 e2))
	| Divide (e1, e2) -> (8, (to_str 7 e1) ^ " / " ^ (to_str 8 e2))
	| Mod (e1, e2) ->    (8, (to_str 7 e1) ^ " % " ^ (to_str 8 e2))
	| Plus (e1, e2) ->   (7, (to_str 6 e1) ^ " + " ^ (to_str 7 e2))
	| Minus (e1, e2) ->  (7, (to_str 6 e1) ^ " - " ^ (to_str 7 e2))
	| Cons (e1, e2) ->   (6, (to_str 6 e1) ^ " :: " ^ (to_str 5 e2))
	| Equal (e1, e2) ->  (5, (to_str 5 e1) ^ " = " ^ (to_str 5 e2))
	| Less (e1, e2) ->   (5, (to_str 5 e1) ^ " < " ^ (to_str 5 e2))
	| If (e1, e2, e3) -> (4, "if " ^ (to_str 4 e1) ^ " then " ^
				(to_str 4 e2) ^ " else " ^ (to_str 4 e3))
	| Match (e1, e2, x, y, e3) ->
	    (3, "match " ^ (to_str 3 e1) ^ " with " ^
	       "[] -> " ^ (to_str 3 e2) ^ " | " ^
	       x ^ "::" ^ y ^ " -> " ^ (to_str 3 e3))
	| Fun (x, e) ->
      (* (10, "<fun>") *)
	    (2, "fun " ^ x ^  " -> " ^ (to_str 0 e))
	| Rec (x, e) ->
      (* (10, "<rec>") *)
	    (1, "rec " ^ x ^ " is " ^ (to_str 0 e))
    in
      if m > n then str else "(" ^ str ^ ")"
  in
    to_str (-1) e
