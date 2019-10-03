%{
%}

%x MAIUSCULA

%%
[.!?]+[ \r\n\t]* { printf("%s", yytext); BEGIN MAIUSCULA; }

<MAIUSCULA>[a-z] { printf("%c", (char) toupper(yytext[0])); BEGIN INITIAL; }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
