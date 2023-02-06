
type retType = Type of types | Void

and funType = Arrow of (ftype option) * retType

and fType   = types list


and types = BasicType of basicTypes
| Prod of types * types
| List of (types list)
| Id of string

and basicTypes = Int | Bool | Char



