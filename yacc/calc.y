%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern char *yytext;
extern int yylineno;
void yyerror(char*);

int tab[26] = {0};
#define TAB_SIZE 26
%}

%token NUM VAR ERRO FIM SEP MEM

%union {
    int num;
    char var;
}

%type <var> VAR
%type <num> NUM Fator Termo Exp

%%
Calc    : Comandos FIM
        ;

Comandos: Comandos Comando SEP
        |
        ;

Comando : Escrita
        | Leitura
        | Atrib

Escrita : '!' Exp { printf(">> %d\n", $2); }
        | '!' MEM { for(int i = 0; i < TAB_SIZE; i++)
                        printf(">> %c - %d\n", i + 'a', tab[i]);
                  }
        ;

Leitura : '?' VAR { printf("Valor: ");
                   scanf("%d", tab + $2 - 'a');
                   while(getchar() != '\n');
                   printf("-- Guardei o valor %d no registo %c\n", tab[$2 - 'a'], $2); }
        ;

Atrib   : VAR '=' Exp { tab[$1 - 'a'] = $3;
                       printf("-- Guardei o valor %d no registo %c\n", $3, $1); }
        ;

Exp     : Termo { $$ = $1; }
        | Exp '+' Termo { $$ = $1 + $3;  }
        | Exp '-' Termo { $$ = $1 - $3;  }
        ;

Termo   : Fator { $$ = $1; }
        | Termo '*' Fator { $$ = $1 * $3;  }
        | Termo '/' Fator { $$ = $1 / $3;  }
        ;

Fator   : NUM { $$ = $1; }
        | VAR { $$ = tab[$1 - 'a']; }
        | '(' Exp ')' { $$ = $2; }
        ;
%%

int main() {
    yyparse();
    return 0;
}

void yyerror(char *erro) {
    fprintf(stderr, "%s, %s, %d\n", erro, yytext, yylineno);
}