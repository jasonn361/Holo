CC=gcc

lexer: holo.lex
	flex holo.lex
	$(CC) -o holo lex.yy.c 
	rm lex.yy.c

clean: 
	rm holo 