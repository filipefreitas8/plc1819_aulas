%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int x1, x2;
%}

%x NUM MULT ADD

%%
	// <NUM>. { BEGIN INITIAL; }
	// <MULT>. { BEGIN INITIAL; }
[0-9]+[ ]* { x1 = atoi(yytext); BEGIN NUM; }
<NUM>\*[ ]* { BEGIN MULT; }
<NUM>\+[ ]* { BEGIN ADD; }
<MULT>[0-9]+ { x2 = atoi(yytext); printf("m= %d\n", x1 * x2); BEGIN INITIAL; }
<ADD>[0-9]+ { x2 = atoi(yytext); printf("a= %d\n", x1 + x2); BEGIN INITIAL; }
<NUM,MULT,ADD>. { BEGIN INITIAL; }
.|\n
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}