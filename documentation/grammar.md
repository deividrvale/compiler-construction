VarDecl ::= ( `var` | Type) id  `=` Exp `;`

FunDecl ::= id `(` [ FArgs ] `)` [ `::` FunType ] `{` VarDecl* Stmt+ `}`

RetType ::= Type | `Void`

FunType ::= [ FTypes ] `->` RetType

FTypes  ::= Type [ FTypes ]

Type  ::= BasicType
        | `(` Type `,` Type `)`
        | `[` Type `]`
        | id

BasicType ::= `Int`
            | `Bool`
            | `Char`

FArgs ::= [ FArgs `,`] id

Stmt  ::= `if` `(` Exp `)` `{` Stmt* `}` [ `else` `{` Stmt* `}` ]
        | `while` `(` Exp `)` `{` Stmt* `}`
        | id Field `=` Exp `;`
        | FunCall `;`
        | `return` [ Exp ] `;`

Exp ::= id Field
      | Exp Op2 Exp
      | Op1 Exp
      | int
      | char
      | `False` | `True`
      | `(` Exp `)`
      | FunCall
      | `[]`
      | `(` Exp `,` Exp `)`

Field   ::= [ Field (`.` `hd` | `.` `tl` | `.` `fst` | `.` `snd`)]

FunCall ::= id `(`[ ActArgs ] `)`

ActArgs ::= Exp [ `,` ActArgs ]

Op2 ::= `+` |`-`|`*`|`/` |`%`
      | `==` | `<` | `>` | `<=` | `>=` | `!=`
      | `&&` | `||`
      | `:`

Op1 ::= `!` | `-`
int ::= [`-`] digit+
id ::= alpha ( `_` | alphaNum)*
