

## Parsing
- The an expression `- e` involving the unary operator `-` is parsed to as `0 - e` in the AST.


## Arithmetic
- Computing the remainder by 0 does not through an error.
  Instead, `x % 0 = x`.
