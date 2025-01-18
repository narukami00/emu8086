org 100h

.data
arr db 10h,22h,54h,89h,69h
len equ ($-arr)
max db ?
min db ?

.code
mov cx,len
lea si,arr
mov al,[si]
mov max,al
mov min,al
dec cx
inc si

loop1:
    mov al,[si]
    cmp al,max
    ja max_found
    x:
    cmp al,min
    jb min_found
    y:
    inc si
loop loop1

ret

max_found:
mov max,al
jmp x

min_found:
mov min,al
jmp y
