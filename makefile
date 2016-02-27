CC=gcc
DEBUG=-g
CFLAGS=-std=c11 -Wall -Wpedantic -pipe $(DEBUG)
LFLAGS=-Wall $(DEBUG) -lcurl -lopenssl


all:	libstatic libshared

libstatic:	chainbuild.o
	ar rcs lib/libchainbuild.a obj/chainbuild.o

libshared:	CFLAGS += -fPIC
libshared:	chainbuild.o
	$(CC) -shared -Wl,-soname,lib/libchainbuild.so.1 -o lib/libchainbuild.so.1.0.0 obj/chainbuild.o

chainbuild.o:	chainbuild.c chainbuild.h
	echo $(CFLAGS)
	$(CC) $(CFLAGS) -c chainbuild.c -o obj/chainbuild.o
	cp chainbuild.h inc/chainbuild.h

clean:
	rm -f obj/*.o lib/*.a lib/*.so.* inc/*.h
