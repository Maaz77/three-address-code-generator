
all: flex bison yacc.tab.h
	@gcc yacc.tab.c lex.yy.c -w

flex: lexer.l
	@flex -i lexer.l

bison: yacc.y
	@bison -v -d yacc.y

run: all
	@./a.out < conf.in

clean:
	@rm *.c *.h *.output *.out





 