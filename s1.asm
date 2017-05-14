assume cs:code,ds:data,ds:stack
data segment
	dw 0123h,0456h,0789h,0abch,0defh,0987h,0654h,0321h
data ends

stack segment
	dw 0,0,0,0,0,0,0,0 
stack ends

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

end start