(lang dune 3.6)

(using menhir 2.1)

(name compiler)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Marc Hermes" "Deivid Vale")

(maintainers "Marc Hermes" "Deivid Vale")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name compiler)
 (synopsis "Compiler from SPL to SMM")
 (description "A Compiler written in Ocaml; Compiling code from the
  Simple Programming Language (SPL) to instructions of the Simple
  Stack Machine (SSM).")
 (depends
  (ocaml  (>= 4.14.0))
  (dune   (>= 3.6.1))
  (menhir (>= 20220210)))
 (tags
  (topics "Compiler" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
