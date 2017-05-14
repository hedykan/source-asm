assume cs:code
stack segment 
	dw 16 dup(0) 
stack ends 

data segment 
	dw 999 dup(0) 
data ends 

code segment;逻辑错误：jcxz的零不知何时跳
	start:
	mov ax,data 
	mov ds,ax 
	mov ax,stack 
	mov ss,ax 
	mov sp,16 
	mov bx,0 
	mov cx,899  
	mov ax,100 
	
	mull:
	push cx 
	push ax 
	mov dx,0 
	s0:
	call divdw 
	push cx 
	mov cx,ax 
	jcxz s0 
	mov ax,0 
	s1:
	pop cx 
	mov al,cl 
	mul cl 
	mul cl 
	add dx,ax 
	mov cx,ss 
	sub cx,0eh
	jcxz s1 
	pop ax
	sub dx,ax 
	mov cx,dx 
	jcxz ending 
	mov [bx],ax 
	ending: 
	inc ax 
	add bx,2 
	pop cx 
	loop mull 

	

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
	shows0:
	mov cl,[si] 
	jcxz shows1 
	mov al,cl 
	mov es:[bx],ax 
	inc si 
	add bx,2 
	loop shows0 
	shows1:
	ret 
	
	
	
	divdw:
	push cx 
	push ax 
	mov cx,0ah 
	mov ax,dx 
	mov dx,0 
	div cx 
	mov bx,ax 
	pop ax 
	div cx 
	mov cx,dx 
	mov dx,bx 
	pop cx 
	ret 
	
code ends 
end start 