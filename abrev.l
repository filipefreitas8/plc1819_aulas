%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
\\mm {printf("mesmo");}
\\mt {printf("muito");}
\\b {printf("bom");}
\\prox {printf("próximo");}
\\bbb {printf("bonito, barato e bom");}
\\cqd {printf("como queriamos demonstrar");}
\\pq {printf("porque");}
\\exs {printf("exemplos");}
\\sp {printf("sempre");}
[a-zA-Z]+\/ {yytext[yyleng - 1] = '\0'; printf("%smente", yytext);}
~/[a-zA-Z]+ {printf("in");}
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Início da Filtragem\n");
    yylex();
    printf("Fim da filtragem\n");
    return 0;
}

