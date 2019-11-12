%{
#include <stdio.h>
#include <string.h>

int memb = 0;
%}

%token str id inteiro data 
%token FAMILIA

%%
DescFam		: Cabec Membros
		    ;
Cabec   	:	 
	    	| FAMILIA NomeF data ':'
	    	;
NomeF   	: str
		    ;
Membros 	: Membro 
	    	| Membro Membros
	    	;
Membro  	: Nome IdMembro '('Pontuacoes')' { memb++; }
 		    ;
Nome    	: str
		    ;  
IdMembro	: id
		    ;
Pontuacoes	: Ponto 
		    | Ponto ',' Pontuacoes
		    ;
Ponto 		: inteiro
		    ;

%%

#include "lex.yy.c"

void yyerror(char *s) {
	printf("%s\n", s);
}

int main () {	
	printf("Inicio da compilação\n");

	yyparse();
    printf("Membros da familia %d\n", memb);
	
    printf("Fim da compilação\n");
	
	return 0;
}

