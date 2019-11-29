%{
#include <stdlib.h>
#include <stdio.h>
#include <strings.h>
#include <string.h>

extern int yylex();
extern char *yytext;
extern int yylineno;
void yyerror(char*);

#define TIPO_INTEIRO 0

char *codigo;
%}

%union { int numero; char *texto; }

%token <texto>id
%token <numero>num

%token INTEIRO ERRO

%type <texto>Programa <texto>DCLVariaveis <texto>DCLVariavel
%type <texto>Instrucoes <texto>Instrucao <texto>ValorInicial
%type <numero>Tipo

%%
Programa        : DCLVariaveis ';' Instrucoes '.' { printf("%s%s%s%s", $1, "START\n", $3, "STOP\n"); }
                ;

DCLVariaveis    : DCLVariaveis DCLVariavel { asprintf(&$$, "%s%s", $1, $2); }
                | DCLVariavel { $$ = $1; }
                ;

DCLVariavel     : id ValorInicial ':' Tipo { asprintf(&$$, "%s", $2); }
                ;

ValorInicial    : '=' num { asprintf(&$$, "PUSHI %d\n", $2); }
                | { asprintf(&$$, "PUSHI 0\n"); }
                ;

Tipo            : INTEIRO { $$ = TIPO_INTEIRO; }
                ;

Instrucoes      : Instrucoes Instrucao { asprintf(&$$, "%s%s", $1, $2); }
                | Instrucao { $$ = $1; }
                ;

Instrucao       : { $$ = ""; }
                ; 
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *erro) {
    fprintf(stderr, "%s, %s, %d\n", erro, yytext, yylineno);
}