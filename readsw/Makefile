LDFLAGS=-lpthread -lrt -lpigpio
.phony: all

all: readsw

readsw: readsw.cob fn_getch.o
	cobc -x readsw.cob fn_getch.o $(LDFLAGS)

fn_getch.o: fn_getch.c
	gcc -c fn_getch.c

.phony: clean
clean:
	rm -f readsw
