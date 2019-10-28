%{
%}

%%
^[_.][0-9]+[a-zA-Z]{3,}(_|.)?$ { printf("Válido\n"); }
^.+$ { printf("Inválido\n"); }
\n ;
%%

int yywrap() {
	return 1;
}

int main() {
	yylex();
	return 0;
}

