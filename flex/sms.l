%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
int soma = 0;
%}

%%
    // [2][0-9]{8} {printf("%s\n", yytext);}
    // [9][1236][0-9]{7} {printf("%s\n", yytext);}
    // [0-9]+ {soma += atoi(yytext);}
[0-9]+[ ]*\*[ ]*[0-9]+ {
    int x1, x2;
    sscanf(yytext, "%d * %d", &x1, &x2);
    printf("Detetada multiplicação de %d e %d = %d\n", x1, x2, x1*x2);
}
.|\n
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    printf("Soma: %d\n", soma);
    return 0;
}