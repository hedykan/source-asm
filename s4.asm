assume cs:code,ds:data,ds:stack

code segment
	start:
	mov ax,stack
	mov ss,ax
	mov sp,10h
	
	mov ax,data
	mov ds,ax

	mov ax,4c00h
	int 21h
code ends

data segment
	dw 0123h,0456h
data ends

stack segment
	dw 0,0
stack ends

end start