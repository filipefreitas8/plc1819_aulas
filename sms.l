%{

%}

%%
[2][0-9]{8} {printf("%s\n", yytext);}
[9][1236][0-9]{7} {printf("%s\n", yytext);}
.|\n
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}