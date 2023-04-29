#!/usr/bin/make
# $Id: makefile,v 1.9 2009/02/10 12:20:09 stoecker Exp $

ifdef windir
CC   = gcc
OPTS = -Wall -W -DWINDOWSVERSION
LIBS = -lwsock32
else
#OPTS = -Wall -W
OPTS = -W
endif

bin = ntripserver

ntripserver: ntripserver.c
	$(CC) $(OPTS) $? -O3 -DNDEBUG -o $@ $(LIBS)

debug: ntripserver.c
	$(CC) $(OPTS) $? -g -o $(bin) $(LIBS)

clean:
	$(RM) -f $(bin)

install:
	sudo cp -f $(bin) /usr/local/bin
