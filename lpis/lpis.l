%{
#include "lpis.tab.h"
%}

%%
[:=;.()+\-*/|&!{}] { return *yytext; }

(?i:inteiro)  { return INTEIRO;  }
(?i:ler)      { return LER;      }
(?i:escrever) { return ESCREVER; }
(?i:se)       { return SE;       }
(?i:entao)    { return ENTAO;    }
(?i:senao)    { return SENAO;    }
(?i:fse)      { return FSE;      }

[a-zA-Z][a-zA-Z0-9\-\_]* { yytext[0] = toupper(yytext[0]); yylval.texto = strdup(yytext); return id; }
[0-9]+ { yylval.numero = atoi(yytext); return num; }

[\ \n\t\r] { ; }

. { return ERRO; }
%%

int yywrap() {
    return 1;
}
