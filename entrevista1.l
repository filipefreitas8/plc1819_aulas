%{

char nomeEntrevistador[512];
char nomeEntrevistado[512];

%}

%x EU ELE

%%
^(?i:eu)\ *=[ \t\n]* { BEGIN EU; }
^(?i:ele)\ *=[ \t\n]* { BEGIN ELE; }

<EU>[^.]* { strcpy(nomeEntrevistador, yytext); }
<ELE>[^.]* { strcpy(nomeEntrevistado, yytext); }

<EU,ELE>\. { BEGIN INITIAL; }

^(?i:eu)\ *: { printf("%s: ", nomeEntrevistador); }
^(?i:ele)\ *: { printf("%s: ", nomeEntrevistado); }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}