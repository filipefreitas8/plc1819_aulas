%{
%}

%%
((([01]?[0-9]?[0-9]{2})|(2[0-5]{2}))\.){3}(([01]?[0-9]?[0-9]{2})|(2[0-5]{2})) { printf("IPv4 válido\n"); }
%%

int yywrap() {
	return 1;
}

int main() {
	yylex();
	return 0;
}
