%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
ExpB    : Exp
        | Exp OPREL Exp
        ;

Exp     : Termo
        | Exp OPAD Termo
        ;

Termo   : Fator
        | Termo OPMUL Fator
        ;

Fator   : num
        | '(' ExpB ')'
        | id
        | InvocF
        ;

InvocF  : id '(' Params ')'
        ;

Params  : Param
        | Params ',' Param
        ;

Param   : ExpB
        ;
%%

#include "expbool.tab.c"

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    yyparse();
    return 0;
}
