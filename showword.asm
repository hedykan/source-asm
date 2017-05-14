assume cs:code 
data segment
	dw 12333,123,13,1341,5,'A' 
data ends 

stack segment 
	dw 16 dup (0) 
stack ends 

code segment 
		start:
	mov ax,data 
	mov ds,ax 
	mov ax,stack 
	mov ss,ax 
	mov sp,16 
	mov bx,0 
	mov dl,1 
	mov dh,1 
	call show_math 
	mov ax,4c00h 
	int 21h
	
		show_math:
	mov ax,[bx]
	call divdw 
	add cl,30h 
	mov ss:[0],cl 
	mov cl,7
	call show_str 
	add bx,2 
	mov cx,[bx] ;与show_str中的bx冲突
	sub cx,'A'
	jcxz show_math 
	ret 
	
	
	
		divdw:
	push ax 
	mov cx,10
	mov ax,dx 
	mov dx,0 
	div cx 
	mov bx,ax 
	pop ax 
	div cx 
	mov cx,dx 
	mov dx,bx 
	ret 
	
		show_str:
	sub dh,1
	sub dl,1
	mov ax,0 
	mov al,0a0h
	mul dh 
	mov bp,ax 
	mov al,2 
	mul dl 
	add bp,ax 
	mov ax,0b800h
	mov es,ax 
	mov ah,cl 
	mov cx,0 
	s0:
	mov si,0
	mov cl,ss:[si]
	jcxz s1 
	mov al,cl 
	mov es:[bp],ax 
	inc si 
	add bp,2 
	loop s0 
	s1:
	ret 
	
code ends 
end start 
