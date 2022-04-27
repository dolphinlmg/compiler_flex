all: assignment_1

assignment_1: assignment_1.l
	lex assignment_1.l
	gcc -o assignment_1 lex.yy.c -ll -g

clean: 
	rm -rf assignment_1
	rm -rf lex.yy.c
