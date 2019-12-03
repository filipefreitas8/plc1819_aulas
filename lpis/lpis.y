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

int symbolTable[26];

int proxAddress = 0;
%}

%union { int numero; char *texto; }

%token <texto>id
%token <numero>num

%token INTEIRO ERRO LER ESCREVER

%type <texto>Programa <texto>DCLVariaveis <texto>DCLVariavel
%type <texto>Instrucoes <texto>Instrucao <texto>ValorInicial
%type <texto>Input <texto>Output
%type <numero>Tipo

%%
Programa        : DCLVariaveis ';' Instrucoes '.' { printf("%s%s%s%s", $1, "START\n", $3, "STOP\n"); }
                ;

DCLVariaveis    : DCLVariaveis DCLVariavel { asprintf(&$$, "%s%s", $1, $2); }
                | DCLVariavel { $$ = $1; }
                ;

DCLVariavel     : id ValorInicial ':' Tipo {
    if(symbolTable[$1[0] - 'A'] != -1) {
        fprintf(stderr, "A variável %s já foi declarada!\n", $1);
        exit(-1);
    } else {
        symbolTable[$1[0] - 'A'] = proxAddress++;
        asprintf(&$$, "%s", $2);
    }
}
                ;

ValorInicial    : '=' num { asprintf(&$$, "PUSHI %d\n", $2); }
                | { asprintf(&$$, "PUSHI 0\n"); }
                ;

Tipo            : INTEIRO { $$ = TIPO_INTEIRO; }
                ;

Instrucoes      : Instrucoes Instrucao { asprintf(&$$, "%s%s", $1, $2); }
                | Instrucao { $$ = $1; }
                ;

Instrucao       : Input { $$ = $1; }
                | Output { $$ = $1; }
                ; 

Input           : LER '(' id ')' {
    if(symbolTable[$3[0] - 'A'] == -1) {
        fprintf(stderr, "A variável %s não foi declarada!\n", $3);
        exit(-1);
    } else {
        asprintf(&$$, "READ\nATOI\nSTOREG %d\n", symbolTable[$3[0] - 'A']);
    }
}

Output          : ESCREVER '(' id ')' {
    if(symbolTable[$3[0] - 'A'] == -1) {
        fprintf(stderr, "A variável %s não foi declarada!\n", $3);
        exit(-1);
    } else {
        asprintf(&$$, "PUSHG %d\nWRITEI\n", symbolTable[$3[0] - 'A']);
    }
}
                ; 
%%

int main() {
    for(int i = 0; i < 26; i++)
        symbolTable[i] = -1;

    yyparse();
    return 0;
}

void yyerror(char *erro) {
    fprintf(stderr, "%s, %s, %d\n", erro, yytext, yylineno);
}