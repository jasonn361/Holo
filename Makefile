CC=gcc

lexer: rise.lex
	flex rise.lex
	$(CC) -o rise lex.yy.c 
	rm lex.yy.x

clean: 
	rm rise