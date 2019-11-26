# plc1819_aulas
Contém os ficheiros que vão sendo realizados ao longo das aulas de PLC.

## Flex
Para compilar os ficheiros do Flex, existe uma Makefile nesse diretório que permite apenas correr "make <nome_do_programa>".

Ex: make abrev --> Compila o abrev.l, e corre o programa resultante com entrada abrev.txt. Equivalente a executar:

> bash $ flex abrev.l

> bash $ gcc -o abrev abrev.yy.c

> bash $ ./abrev < abrev.txt

Outros exemplos:

> bash $ make sms

> bash $ make maiuscula

> bash $ make lex

Para alterar o ficheiro de entrada, existe a flag in, que pode ser usada do seguinte modo:

> bash $ make abrev in=abrev2.txt

> bash $ make abrev in=abrev3.txt

> bash $ make sms in=sms2.txt

## Gawk
Os ficheiros do Gawk são ficheiros da Bash Shell que podem ser executados diretamente.

Ex: ./inspector.sh < nobel.csv

Isto em alternativa a executar > gawk -f ./inspector.sh < nobel.csv

## Yacc
Tal como no Flex, existe uma Makefile especificamente desenhada para compilar os ficheiros do Yacc.

Ex: bash $ make familia run

Este comando compila o ficheiro familia.l (yacc -d familia.y), compila o ficheiro Flex correspondente (flex familia.l), e finalmente junta ambos com o gcc (gcc familia.tab.c). A opção run é opcional, e faz com que o ficheiro resultante seja automaticamente executado (./horario < horario.txt)

Tal como no Flex, existe a flag in para especificar um ficheiro de entrada, que pode ser utilizada da mesma maneira do que no Flex.

**NOTA IMPORTANTE**: Esta Makefile gera os ficheiros .yy.c e .tab.c/h com o nome específico correspondente ao ficheiro de entrada. Ou seja, no caso do exercício da família, a Makefile vai gerar os ficheiros familia.tab.c, familia.tab.h, e familia.yy.c. Isto tem o objetivo de prevenir conflitos entre os vários exercícios que vão sendo realizados ao longo da aula, devido a estarem todos na mesma pasta.

Isto significa também que, nos ficheiros .y e .l, em vez de fazer #include "lex.yy.c" e #include "y.tab.h", respetivamente, é necessário fazer #include "<nome>.yy.c" e #include "<nome>.tab.h", respetivamente.
  
Por exemplo, no caso da família, é necessário fazer #include "familia.yy.c" e #include "familia.tab.h", respetivamente, nos ficheiros .y e .l.

Outros exemplos:

> bash $ make horario run

Compila e executa o horario.y e horario.l.

> bash $ make calc

Compila, mas não executa, o calc.y e calc.l.

> bash $ make familia run in=familia5.txt

Compila o familia.y e familia.l, e executa o ficheiro resultante com o ficheiro de entrada familia5.txt (./familia < familia5.txt).