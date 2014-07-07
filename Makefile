rfc3797: nomcom.c md5.c
	cc -o rfc3797 nomcom.c md5.c -lm

check:	rfc3797
	./testcase-2012.sh
	./testcase-2013.sh
