%{
/* Start code injection */

#include <stdio.h>

unsigned long long current_line = 1;
unsigned long long current_column = 0;
#define YY_USER_ACTION current_column += yyleng;

/* End code injection */
%}

%option noyywrap


/* Start Definitions */

/* Integer */
DIGIT [0-9]
NAT {DIGIT}+
SIGNED_NAT [+-]?{NAT}

/* FLOAT */
DECIMAL_NUM {SIGNED_NAT}\.{NAT}
SCI_NUM {DECIMAL_NUM}[eE]{SIGNED_NAT}
FLOAT {DECIMAL_NUM}|{SCI_NUM}

/* ID */
ID_CHARS [a-zA-Z]
ID {ID_CHARS}({ID_CHARS}|{DIGIT})*
BAD_ID {DIGIT} ({ID_CHARS}|{DIGIT})*

/* Comment */
COMMENT #[^\n]*

/* End Definitions */

%%
"loop"          printf("%s\n", yytext);
"in"            printf("%s\n", yytext);
"if"            printf("%s\n", yytext);
"end"           printf("%s\n", yytext);
"elif"          printf("%s\n", yytext);
"else"          printf("%s\n", yytext);
"return"        printf("%s\n", yytext);

"+="            printf("%s\n", yytext);
"-="            printf("%s\n", yytext);
"*="            printf("%s\n", yytext);
"/="            printf("%s\n", yytext);
"%%="           printf("%s\n", yytext);

"+"             printf("%s\n", yytext);
"-"             printf("%s\n", yytext);
"*"             printf("%s\n", yytext);
"/"             printf("%s\n", yytext);
"%%"            printf("%s\n", yytext);

"=="            printf("%s\n", yytext);
"="             printf("%s\n", yytext);
":"             printf("%s\n", yytext);
","             printf("%s\n", yytext);

">="            printf("%s\n", yytext);
"<="            printf("%s\n", yytext);
">"             printf("%s\n", yytext);
"<"             printf("%s\n", yytext);
"!="            printf("%s\n", yytext);
"!"             printf("%s\n", yytext);

";"             printf("%s\n", yytext);
"{"             printf("%s\n", yytext);
"}"             printf("%s\n", yytext);
"("             printf("%s\n", yytext);
")"             printf("%s\n", yytext);
"["             printf("%s\n", yytext);
"]"             printf("%s\n", yytext);

"false"         printf("%s\n", yytext);
"true"          printf("%s\n", yytext);

{SIGNED_NAT}    printf("INT %s\n", yytext);
{FLOAT}         printf("FLOAT %s\n", yytext);

{ID}            printf("ID %s\n", yytext);


{COMMENT}       /* NOP */

\n              { current_line++; current_column = 0; }
[\t\r]          /* NOP */

. { fprintf(stderr, "Error at line %llu, column %llu: unrecognized symbol \"%s\"\n", current_line, current_column, yytext); yyterminate(); }
%%

int main(int argc, char **argv) {
    if(argc == 2 && !(yyin = fopen(argv[1], "r"))) {
        fprintf(stderr, " cound not open input FILE \n");
        return -1;
    }

    yylex();

    return 0;
}