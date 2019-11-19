%{
#include <stdio.h>
#include <stdlib.h>
%}

%union { char *texto; float vnum; }

%token <texto>id
%token <vnum>num

%type <vnum>ExpB
%type <vnum>Exp
%type <vnum>Termo
%type <vnum>Fator

%%
ExpFinal: { printf("Expr? "); } ExpB { printf("%f\n", $2); }
        ;

ExpB    : Exp { $$ = $1; }
        | Exp '=' '=' Exp { $$ = $1 == $4; }
        | Exp '!' '=' Exp { $$ = $1 != $4; }
        ;

Exp     : Termo { $$ = $1; }
        | Exp '+' Termo { $$ = $1 + $3;  }
        | Exp '-' Termo { $$ = $1 - $3;  }
        | Exp '|' Termo { $$ = $1 || $3; }
        ;

Termo   : Fator { $$ = $1; }
        | Termo '*' Fator { $$ = $1 * $3;  }
        | Termo '/' Fator { $$ = $1 / $3;  }
        | Termo '&' Fator { $$ = $1 && $3; }
        ;

Fator   : num { $$ = $1; }
        | '(' ExpB ')' { $$ = $2; }
        ;
%%

#include "expbool.yy.c"

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
    return 0;
}
