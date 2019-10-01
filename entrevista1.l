%{

char nomeEntrevistador[512];
char nomeEntrevistado[512];
%}

%%
^(?i:eu)=.+\. {
    yytext[yyleng - 1] = '\0';
    strcpy(nomeEntrevistador, yytext + 3);
}
^(?i:eu)\ *: { printf(" %s: ", nomeEntrevistador); }
^(?i:ele)\ *: { printf(" - "); }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}