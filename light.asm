assume cs:code,ds:data

data segment
	db 41h,0cah,42h,0cah,43h,0cah,44h,0cah,45h,0cah,46h,0cah
data ends

code segment
	start:
	mov ax,0b800h
	mov es,ax
	mov bx,0
	mov ax,data
	mov ds,ax
	mov cx,12
	s:
	mov al,es:[bx]
	mov [bx],al
	inc bx
	loop s 
	
	mov ax,4c00h
	int 21h
code ends

end start
	