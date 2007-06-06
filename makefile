#!/bin/make

NtripServerLinux: NtripLinuxServer.c
	$(CC) -Wall -W -O3 $? -o $@

clean:
	$(RM) -f NtripServerLinux core

archive:
	zip NtripServerLinux.zip -9 makefile NtripLinuxServer.c NtripProvider.doc ReadmeServerLinux.txt SiteLogExample.txt SiteLogInstr.txt StartNtripServerLinux