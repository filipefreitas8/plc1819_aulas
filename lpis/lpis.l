%{
#include "lpis.tab.h"
%}

%%
[:=;.()+\-*/|&] { return *yytext; }

"Inteiro" { return INTEIRO;  }
"ler"     { return LER;      }
"escrever" { return ESCREVER; }

[a-zA-Z][a-zA-Z0-9\-\_]* { yytext[0] = toupper(yytext[0]); yylval.texto = strdup(yytext); return id; }
[0-9]+ { yylval.numero = atoi(yytext); return num; }

[\ \n\t] { ; }

. { return ERRO; }
%%

int yywrap() {
    return 1;
}
