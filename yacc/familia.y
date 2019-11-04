%{
#include <stdin.h>
%}

%%
DescFam : Cabec Membros
        ;
Cabec   :
        | Familia NomeF data
        ;

%%

void yyerror(char* s) {
    printf("%s\n", s);
}

int main() {
    yyparse();
    return 0;
}
