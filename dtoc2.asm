assume cs:code,ds:data,ss:stack 
stack segment 
	dw 16 dup(0) 
stack ends

data segment

   dw 16 dup(0)

data ends

code segment

start:

   mov ax,12666

   mov bx,data
   mov ds,bx
   mov bx,stack  
   mov ss,bx 
   mov sp,32 
   mov si,0
   call dtoc
   mov dh,8
   mov dl,3
   mov cl,2
   call show_str

   mov ax,4c00h
   int 21h


dtoc:

   push ax

   push si

   push dx

   push cx

   push bx

	mov bx,0 
	dtoc_s: 
	mov cx,10d 
	mov dx,0 ;这里缺少mov dx,0 造成了除法溢出错误，所以程序无法结束，之前出问题应该也是这里。
	div cx 
	add dx,30h 
	push dx 
	mov cx,ax 
	inc bx 
	jcxz dtoc_end
	jmp dtoc_s 
	dtoc_end: 
	mov cx,bx 
	mov bx,0 
	s1:
	pop ax 
	mov ds:[bx],al
	inc bx	
	loop s1


pop bx
pop cx
pop dx
pop si
pop ax
ret


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
	s3:
	mov cl,[si] 
	jcxz s4 
	mov al,cl 
	mov es:[bx],ax 
	inc si 
	add bx,2 
	jmp s3 
	s4:
	ret 
	
code ends
end start

dtoc:
	push cx 
	push bx 
	push dx 
	mov bx,0 
	dtoc_s: 
	mov cx,10d 
	;这里缺少mov dx,0 造成了除法溢出错误，所以程序无法结束，之前出问题应该也是这里。
	div cx 
	add dx,30h 
	push dx 
	mov cx,ax 
	inc bx 
	mov dx,0 
	jcxz dtoc_end
	jmp dtoc_s 
	dtoc_end: 
	mov cx,bx 
	mov bx,0 
	s1:
	pop ax 
	mov ds:[bx],al
	inc bx	
	loop s1
	pop dx 
	pop bx 
	pop cx 
	ret 

	
	
	
mov bx,0
dtoc_s:
mov cx,10d
mov dx,0
div cx
mov cx,ax                            ;将商放到cx中判断商是否为零
add dx,30h
push dx
inc bx 
jcxz dtoc_end
jmp dtoc_s
dtoc_end:
mov cx,bx
mov bx,0
s2:
pop ax
mov ds:[bx],al
inc bx
loop s2 