/*
 ** BISON DIRECTIVES
 */
%require "3.0.2"     // The version of bison should be superior or egal to 3.0.2
%skeleton "lalr1.cc" // The grammar is lalr1
%expect 0            // No shift/reduce
%error-verbose       // Put a specific message in case of parse error*/
%defines             // Generate header files which can be used by the scanner

// Add a prefix "TOK_" to the token names to avoid colisions.
%define api.token.prefix {TOK_}
// Request that symbols be handled as a whole in the scanner.
%define api.token.constructor
// The type for semantic values set to variant
%define api.value.type variant

/*
 ** CODE FOR FLEX/BISON SYNCHORNIZATION
 */
%code {

#include <iostream>
#include <string>
#include <cstdio>
#include <cstdlib>

extern FILE* yyin;
    yy::parser::symbol_type  yylex();
}

/*
 ** TOKENS, TYPES AND PRIORITIES
 */



// Tokens



%token END_OF_FILE 0 "<EOF>" // Token EOF, automaticaly managed by the parser

%token  INTEGER "integer"
%token ID  "id" 
%token STRING 

%token COMMA ","


%%
// Parse error function, automaticaly call by the parser in case of parse error
    void
yy::parser::error(const std::string& msg)
  {
    std::cerr <<msg << std::endl;
    std::exit(3);
  }

// Main function
    int
main(int argc, char *argv[])
{
     if (argc >= 2)
       yyin = std::fopen(argv[1], "r");
     else
        yyin = stdin;
      yy::parser parser;
      parser.parse();
      fclose(yyin);

}
