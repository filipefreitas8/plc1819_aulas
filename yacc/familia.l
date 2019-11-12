%{
#include "y.tab.h"
%}

%%
(?i:FAM)(?i:ILIA)? { return FAMILIA; }
":" { return ':'; }
[,\(\)] { return yytext[0]; }
\'[^']*\' { return str; }
[a-zA-Z][a-zA-Z0-9|-|_]* { return id; }
[0-9]{4}[./-][0-9]{2}[./-][0-9]{2} { return data; }
[0-9]+ { return inteiro; }
.|\n {;}
%%

int yywrap() {
	return 1;
}

