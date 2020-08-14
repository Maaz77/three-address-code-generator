%{
    #include  <stdio.h>
    #include  <string.h>
    #include  <stdlib.h>
    #include  <ctype.h>
    #include  "yacc.tab.h"
    


%}
%option yylineno
%option noyywrap


letter 	    [a-zA-Z]
digit 		[0-9]
digits      {digit}+

%%
";"				    {strcpy(yylval.str,yytext);return SEMICOLON;}
"int" 				{strcpy(yylval.str,yytext);return INT;}
"char" 			    {strcpy(yylval.str,yytext);return CHAR;}
"double" 			{strcpy(yylval.str,yytext);return DOUBLE;}
"long" 			    {strcpy(yylval.str,yytext);return LONG;}
"float"             {strcpy(yylval.str,yytext);return FLOAT;}
"if"            	{strcpy(yylval.str,yytext);return IF;}
[ \n\t\r]+		    ;
{digits}('.'{digits})?	 {strcpy(yylval.str,yytext);return NUM;}
"while"         	{strcpy(yylval.str,yytext);return WHILE;}
"for"           	{strcpy(yylval.str,yytext);return FOR;}
"else"          	{strcpy(yylval.str,yytext);return ELSE;}
"<"             	{strcpy(yylval.str,yytext);return LT;}
">"             	{strcpy(yylval.str,yytext);return GT;}
"="             	{strcpy(yylval.str,yytext);return AS;}
"=="                {strcpy(yylval.str,yytext);return EQ;}
"!="            	{strcpy(yylval.str,yytext);return NE;}
"<="            	{strcpy(yylval.str,yytext);return LTE;}
">="            	{strcpy(yylval.str,yytext);return GTE;}
"("				    {return OPNP;}
")"				    {return CLSP;}
"{"                 {return OPNB;}
"}"                 {return CLSB;}
"+"                 {strcpy(yylval.str,yytext);return ADDOP;}
"-"                 {strcpy(yylval.str,yytext);return MINUSOP;}
"/"                 {strcpy(yylval.str,yytext);return DEVIDEOP;}
"*"                 {strcpy(yylval.str,yytext);return CROSSOP;}


{letter}({letter}|{digit})*   {strcpy(yylval.str,yytext);return ID;}

%%
