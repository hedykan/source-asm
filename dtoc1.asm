assume cs:code,ds:data

data segment

   db 10 dup(0)

data ends

code segment

start:

   mov ax,12666

   mov bx,data

   mov ds,bx

   mov si,0

   call dtoc

   mov dh,8

   mov dl,3

   mov cl,2

   call show_str

   mov ax,4c00h

   int 21h

;******************************************************

;将word型的数据转变为十进制数字符串的子程序

;****************************************************

dtoc:

   push ax

   push si

   push dx

   push cx

   push bx

   mov bx,0

   

s0:

   mov cx,10d

   mov dx,0

   div cx

   mov cx,ax                            ;将商放到cx中判断商是否为零

   jcxz s1

   add dx,30h

   push dx

   inc bx 

   jmp s0

s1:

  add dx,30h

  push dx 

  inc bx

  mov cx,bx

  mov si,0

s2:

  pop ax

  mov ds:[si],al

  inc si

  loop s2

  pop bx

  pop cx

  pop dx

  pop si

  pop ax

  ret

;***********************************************************

;显示字符串子程序

;***********************************************************

show_str:

     push bx

     push cx

     push si

     mov al,0a0h

     dec dh

     mul dh

     mov bx,ax

     mov al,2

     mul dl

     sub ax,2

     add bx,ax                   ;得到偏移地址=(dh-1)*160+（dl-2)*2

     mov ax,0B800H

     mov es,ax

     mov di,0

     mov ch,0

     mov al,cl

    s: 

     mov cl,ds:[si]

     jcxz next                ;进行判断最后一个字符是否是零,如果是零则结束

     mov es:[bx+di],cl        ;将字符串放到偶地址中

     mov es:[bx+di+1],al      ;颜色属性放到奇地址中

     add di,2 

     inc si 

     jmp  short s

next:

   pop si

   pop cx

   pop bx

   ret

code ends

  end start
