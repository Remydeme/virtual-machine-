%{

#include <iostream>
#include <sstream>
#include <fstream>
#include <cstdlib>
#include <string>
#include "parse.hh"

#define YY_DECL \
   yy::parser::symbol_type yylex()

using token = yy::parser::token;

#define TOKEN(type) \
   yy::parser::make_ ## type()

   // #define YY_USER_ACTION

#define yyterminate() return TOKEN(END_OF_FILE) 
int comment = 0;
extern FILE *yyin;
%}

%option noyywrap 
%option nounput

%x COMMENT

%x STRING



EOL [\n]
INTEGER [0-9]+
ID ([a-zA-Z][a-zA-Z0-9_]*)|"_main"
SPACE [ \t]

%%




/* comment state*/


<COMMENT>
{

"\n" BEGIN(INITIAL);
 
<<EOF>> { 
	   std::cout<< " Bad Input" << std::endl;
	   BEGIN(INITIAL);
	}
}


/* string state */

<STRING>
{

    "\\a" {}
    "\\b" {}
    "\\f"  {}
    "\\v" {}
    "\\t" {}
    "\\n" {}
    "\\r" {}
    "\\\\" {}
    "\\" {std::cerr<<"Unexpected token \\ "; exit(2);}
    "\x"[0-9A-F][0-9A-F]
    "\"" {BEGIN(INITIAL); return TOKEN(STRING);}
}



"\"" {BEGIN(STRING);}
"#" {comment++;  BEGIN (COMMENT);}
"," { TOKEN(COMA); }
"



{SPACE} {}
{EOL} {}
{INTEGER} {return TOKEN(INTEGER);}
{ID} {return TOKEN(ID);}
. {std::cout<<"scan error unexpected"<<yytext<<".\n";
   std::cerr<< yytext << std::endl; exit(3);}




%%
