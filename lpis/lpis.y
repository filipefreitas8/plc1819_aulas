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

int proxIfName = 0;
%}

%union { int numero; char *texto; }

%token <texto>id
%token <numero>num

%token INTEIRO ERRO LER ESCREVER SE ENTAO SENAO FSE

%type <texto>Programa
%type <texto>DCLVariaveis
%type <texto>DCLVariavel
%type <texto>Instrucoes
%type <texto>Instrucao
%type <texto>ValorInicial
%type <texto>Input
%type <texto>Output
%type <texto>Atribuicao
%type <texto>Se

%type <texto>ExpB
%type <texto>Exp
%type <texto>Termo
%type <texto>Fator
%type <texto>Constante
%type <texto>Variavel

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
                | Atribuicao { $$ = $1; }
                | Se { $$ = $1; }
                ; 

Input           : LER '(' id ')' {
    if(symbolTable[$3[0] - 'A'] == -1) {
        fprintf(stderr, "A variável %s não foi declarada!\n", $3);
        exit(-1);
    } else {
        asprintf(&$$, "READ\nATOI\nSTOREG %d\n", symbolTable[$3[0] - 'A']);
    }
}

Output          : ESCREVER '(' ExpB ')' { asprintf(&$$, "%sWRITEI\n", $3); }
                ;

Atribuicao      : id '=' ExpB {
    if(symbolTable[$1[0] - 'A'] == -1) {
        fprintf(stderr, "[Atribuicao] A variável %s não foi declarada!\n", $1);
        exit(-1);
    } else {
        asprintf(&$$, "%sSTOREG %d\n", $3, symbolTable[$1[0] - 'A']);
    }
}

Se              : SE '(' ExpB ')' ENTAO Instrucoes FSE { asprintf(&$$, "%sJZ FSE%d\n%FSE%d\: NOP\n", $3, proxIfName, $6, proxIfName); proxIfName++; }
                | SE '(' ExpB ')' ENTAO Instrucoes SENAO Instrucoes FSE { asprintf(&$$, "%sJZ SENAO%d\n%sJUMP FSE%d\nSENAO%d\: NOP\n%sFSE%d\: NOP\n", $3, proxIfName, $6, proxIfName, proxIfName, $8, proxIfName); proxIfName++; }
                ;

ExpB            : Exp             { $$ = $1; }
                | Exp '=' '=' Exp { asprintf(&$$, "%s%sEQUAL\n", $1, $4); } // Deixa no topo da pilha o valor 1 sse $1 == $2
                | Exp '!' '=' Exp { asprintf(&$$, "%s%sEQUAL\nNOT\n", $1, $4); } // Deixa no topo da pilha o valor 1 sse $1 != $2
                | Exp '>' Exp     { asprintf(&$$, "%s%sSUP\n", $1, $3); } // $1 > $3
                | Exp '<' Exp     { asprintf(&$$, "%s%sINF\n", $1, $3); } // $1 < $3
                | Exp '>' '=' Exp { asprintf(&$$, "%s%sSUPEQ\n", $1, $4); } // $1 >= $4
                | Exp '<' '=' Exp { asprintf(&$$, "%s%sINFEQ\n", $1, $4); } // $1 <= $4
                ;

Exp             : Termo         { $$ = $1; }
                | Exp '+' Termo { asprintf(&$$, "%s%sADD\n", $1, $3);  }
                | Exp '-' Termo { asprintf(&$$, "%s%sSUB\n", $1, $3);  }
                | Exp '|' Termo { asprintf(&$$, "%s%sADD\n", $1, $3); }
                ;

Termo           : Fator           { $$ = $1; }
                | Termo '*' Fator { asprintf(&$$, "%s%sMUL\n", $1, $3);  }
                | Termo '/' Fator { asprintf(&$$, "%s%sDIV\n", $1, $3);  }
                | Termo '&' Fator { asprintf(&$$, "%s%sMUL\n", $1, $3); }
                ;

Fator           : Constante { $$ = $1; }
                | Variavel { $$ = $1; }
                | '(' ExpB ')' { $$ = $2; }
                ;


Constante       : num { asprintf(&$$, "PUSHI %d\n", $1); }
                ;

Variavel        : id {
    if(symbolTable[$1[0] - 'A'] == -1) {
        fprintf(stderr, "[Variavel] A variável %s não foi declarada!\n", $1);
        exit(-1);
    } else {
        asprintf(&$$, "PUSHG %d\n", symbolTable[$1[0] - 'A']);
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
