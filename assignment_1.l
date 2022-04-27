%{
#include <stdio.h>
#define NUMBER 256
#define ADD 1
#define SUB 2
#define OP 3
#define ERROR -1

int yylval;
int lcount = 0;
char operator;
int isOp = 0;
int isNum = 0;
%}
/* regexp definitions */
delim [ \t]
ws {delim}+
num [0-9]+
%%
{ws} {/* no return */}
{num} { return NUMBER; }
"+" { yylval = ADD; return OP; }
"-" { yylval = SUB; return OP; }
. { return ERROR; } 
%%
int
main () {
  int token;
  while ((token = yylex())) {
     if (lcount > 100) break;
     switch (token) {
        case NUMBER: 
            if (isNum) {
                printf("Error: not infix\n"); 
                return -1;
            }

            isNum = 1;
            if (isOp) {
                printf("%s %c ", yytext, operator); 
                isOp = 0;
                lcount += yyleng + 3;
            } else {
                printf("%s ", yytext);
                lcount += yyleng + 1;
            }
        break;
        case OP: 
            if (isOp || !isNum) {
                printf("Error: not infix\n"); 
                return -1;
            }

            isOp = 1;
            isNum = 0;
            operator = yytext[0];
        break;
        default: printf("Error: %s not recognized\n", yytext); return -1;
     }
  }
}
