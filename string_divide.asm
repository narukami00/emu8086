org 100h

.data

str db 'lmao69ballz420'
len equ ($-str)

ref db '1234567890'
lenf equ ($-ref)

num db len dup(0)
char db len dup(0)

.code
mov si, offset num
mov di, offset char

mov cx,len
lea bx,str 

loop1:
mov al,[bx]
push cx
push bx
mov cx,lenf
lea bx,ref

loop2:
    mov ah,[bx]
    cmp al,ah
    je number_found
    inc bx
loop loop2     

mov [di],al
inc di
back:
pop bx
pop cx
inc bx
loop loop1

ret

number_found:
mov [si],al
inc si
jmp back

ret    