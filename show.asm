assume cs:code,ss:stack 
data segment
	db 'Welcome to masm!',0
data ends

code segment
	start:
	mov dh,8
	mov dl,3
	mov cl,2 
	mov ax,data
	mov ds,ax 
	mov si,0
	call show_str
	
	mov ax,4c00h 
	int 21h
	
	show_str:
	sub dh,1
	sub dl,1
	mov ax,0 
	mov al,0a0h
	mul dh 
	mov bx,ax 
	mov al,2 
	mul dl 
	add bx,ax 
	mov ax,0b800h
	mov es,ax 
	mov ah,cl 
	mov cx,0 
	s0:
	mov cl,[si] 
	jcxz s1 
	mov al,cl 
	mov es:[bx],ax 
	inc si 
	add bx,2 
	jmp s0 
	s1:
	ret 
	
code ends 
end start 