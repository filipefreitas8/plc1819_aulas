%{
#include <stdio.h>
#include <string.h>

int memb = 0;
char *nomeFamilia = "";
int p = 0;
int conta;
float soma = 0.0;
%}

%union { char *texto; int num; }

%token <texto>str
%token <texto>id
%token <num>inteiro 
%token <texto>data 
%token FAMILIA

%type  <texto>IdMembro

%%
DescFam		: Cabec Membros
		    ;
Cabec   	: // { nomeFamilia = ""; }
	    	| FAMILIA NomeF data ':'
	    	;
NomeF   	: str { nomeFamilia = strdup($1); }
		    ;
Membros 	: Membro { memb = 1; }
	    	| Membros Membro { memb++; }
	    	;
Membro  	: Nome IdMembro '('Pontuacoes')' {
    printf("O membro <%s> obteve %f pontos.\n", $2, soma/conta);
    soma = 0.0;
}
 		    ;
Nome    	: str
		    ;  
IdMembro	: id { $$ = strdup($1); }
		    ;
Pontuacoes	: Ponto { conta = 1; }
		    | Pontuacoes ',' Ponto { conta += 1; }
		    ;
Ponto 		: inteiro { soma += $1; }
		    ;

%%

#include "lex.yy.c"

void yyerror(char *s) {
	printf("%s\n", s);
}

int main () {	
	printf("Inicio da compilação\n");

	yyparse();
    printf("Os membros da família <%s> são %d\n", nomeFamilia, memb);
	
    printf("Fim da compilação\n");
	
	return 0;
}

