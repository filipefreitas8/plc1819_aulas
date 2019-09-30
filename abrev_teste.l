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
feliz\/ {printf("ERRO");}
sobria\/ {printf("ERRO");}
.*\/ {yytext[yyleng - 0] = '\0'; printf("%smente", yytext);}
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

