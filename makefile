all:
	flex scanner.l
	gcc -lfl lex.yy.c -o a.out

clean:
	rm -f lex.yy.c a.out
