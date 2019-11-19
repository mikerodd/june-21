default: jsl

juno2snaps.o: juno2snaps.c 
	gcc -ansi -c jsl.c -o jsl.o



juno2snaps: juno2snaps.o
	gcc jsl.o -o jsl 

clean:
	-rm -f jsl.o
	-rm -f jsl
