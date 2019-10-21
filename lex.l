%{
#define INT    1
#define NOME   2
#define PESQ   3
#define PDIR   4
#define CESQ   5 
#define CDIR   9
#define PV     6
#define RETURN 7
#define NUM    8
#define FLOAT  10
#define MULT   11
%}

%%
"(" { return (PESQ); }
")" { return (PDIR); }
"{" { return (CESQ); }
"BEGIN" { return (CESQ); }
"}" { return (CDIR); }
"END" { return (CDIR); }
";" { return (PV);   }
"*" { return (MULT);   }
"int" { return (INT); }
"float" { return (FLOAT); }
"return" { return (RETURN); }
"retorna" { return (RETURN); }
[a-zA-Z_][a-zA-Z0-9_\-]* { return (NOME); }
[0-9]+ { return (NUM); }
\n { ECHO; }
[ \t] 
. { printf("Erro! Detetado %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

int main() {
    int s;
    while(s = yylex()) {
        printf("%d ", s);
    }
    return 0;
}
