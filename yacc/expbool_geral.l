%{
#include <stdio.h>
#include <stdlib.h>

#include <expbool.tab.h>
%}

%%
[a-zA-Z][a-zA-Z0-9|-|_]* { yylval.texto = strdup(yytext); return id; }
[0-9]+ { yylval.num = atoi(yytext); return num; }
"=="|">"|"<" { return OPREL; }
"+" { return OPAD; }
"*" { return OPMUL; }
%%

int yywrap() {
    return 1;
}

/*
%union { char *texto; int num; }

%token <texto>id
%token <num>num
%token OPREL
%token OPAD
%token OPMUL


