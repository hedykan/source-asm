assume cs:code 
code segment 
	mov bx,076ah
	mov cx,0002h
	mov dx,0803h
	mov sp,000ah
	mov bp,0000h
	mov si,0000h
	mov di,0000h 
	mov ax,076ch 
	mov ds,ax 
	mov ax,0b800h
	mov es,ax 
	mov ax,076ah 
	mov ss,ax 
	
	mov ax,4c00h
	int 21h 
code ends 
end 