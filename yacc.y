%{
    #include <stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #include<ctype.h>
    #include "yacc.tab.h"
    int varnum = 0;
    int label = 0;

    int fornextlbl;
    int forcondlbl;
    int forstmtlbl;
    int foritrtlbl;
    
    int whileitrtlbl;
    int whilenxtlbl;
    
    int elslbl;
    int ifnxt;
    

    void yyerror (const char  *s);
    
%}


%start Program

%union {char str [100]; }

%token <str> ID NUM

%token <str> INT CHAR DOUBLE LONG FLOAT

%token IF ELSE  WHILE FOR SEMICOLON

%token <str> LT GT AS EQ NE GTE LTE ADDOP MINUSOP DEVIDEOP CROSSOP

%token  OPNP CLSP OPNB CLSB



%type <str> expr
%type <str> rel
%type <str> add
%type <str> term
%type <str> factor
%type <str> relop
%type <str> addop
%type <str> termop
%type <str> decltype



%%

Program  : block
         ;

block : OPNB  stmts CLSB
      ;

stmts : stmts stmt {;}
      | {;}
      ;
stmt : expr SEMICOLON

     |{elslbl = label++; ifnxt = label++;} IF OPNP expr {printf("if (%s == 0) go to label%d:\n",$4,elslbl); } CLSP stmt {printf("\ngo to lable%d\n label%d:\n",ifnxt,elslbl);}ELSE  stmt  {printf("label%d:\n",ifnxt);}

     | {whileitrtlbl = label++; whilenxtlbl = label++;   printf("label%d : \n",whileitrtlbl);}  WHILE OPNP expr {printf("if (%s ==0) go to label%d \n",$4,whilenxtlbl);} CLSP stmt   {printf("go to label%d \n label%d: \n",whileitrtlbl,whilenxtlbl);}


| {forcondlbl = label++; foritrtlbl = label++; forstmtlbl = label++ ; fornextlbl = label++; } FOR OPNP expr SEMICOLON { printf("label%d : \n",forcondlbl);} expr { printf("if (%s == 0) go to label%d \nif (%s !=0) go to  label%d \nlabel%d : \n",$7,fornextlbl,$7,forstmtlbl,foritrtlbl);} SEMICOLON expr {printf("go to label%d : \n",forcondlbl);} CLSP {printf("label%d:\n",forstmtlbl);}stmt {printf("go to label%d : \nlabel%d : ",foritrtlbl,fornextlbl);}


     | block
     |decls SEMICOLON
     ;

decls : decltype ID  {printf("%s %s ;\n",$1,$2);}
      ;

decltype: INT {strcpy($$,$1);}
        |CHAR   {strcpy($$,$1);}
        |DOUBLE  {strcpy($$,$1);}
        |LONG   {strcpy($$,$1);}
        |FLOAT  {strcpy($$,$1);}


expr : rel AS expr        {strcpy($$,$1); printf("%s = %s\n",$1,$3);}
     | rel                 {strcpy($$,$1);}
     ;

rel : rel relop add        {sprintf($$, "t%d", varnum++);printf("%s = %s %s %s\n",$$,$1,$2,$3);}
    | add                  {strcpy($$,$1);}
     ;

relop : LT    {strcpy($$,$1);}
      | GT    {strcpy($$,$1);}
      | EQ    {strcpy($$,$1);}
      | NE    {strcpy($$,$1);}
      | GTE   {strcpy($$,$1);}
      | LTE   {strcpy($$,$1);}
      ;
add : add addop term       {sprintf($$, "t%d", varnum++);printf("%s = %s %s %s\n",$$,$1,$2,$3);}
    | term                {strcpy($$,$1);}
     ;
addop : ADDOP   {strcpy($$,$1);}
      | MINUSOP {strcpy($$,$1);}
      ;
term : term termop factor {sprintf($$, "t%d", varnum++);printf("%s = %s %s %s\n",$$,$1,$2,$3);}
     |factor              {strcpy($$,$1);}
     ;
termop :  DEVIDEOP {strcpy($$,$1);}
       |CROSSOP     {strcpy($$,$1);}
       ;

factor : '(' expr ')'  {strcpy($$,$2);}
       | NUM  {strcpy($$,$1);}
       | ID     {strcpy($$,$1);}
       ;

%%





int main()
{ yyparse();return 0;
}

void yyerror(const char *s)
{ fprintf(stderr, "Error: %s\n", s); }


int yywrap(){
    return 1;
}
