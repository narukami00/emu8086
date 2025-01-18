org 100h

.data
arr db 1h,1h,2h,2h,2h,3h,4h,4h,5h,6h,6h
len equ ($-arr)
res db len dup(0)
lenr dw 00h

.code
mov cx,len
mov si, offset arr
mov di, offset res
mov al,[si]
mov [di],al
inc lenr
dec cx
inc si

outer:
    mov al,[si]
    push cx
    lea di,res
    mov cx,lenr
    inner:
        mov ah,[di]
        cmp al,ah
        je goto_Outer
        inc di
    loop inner
    mov [di],al
    inc lenr
    
    goto_Outer:
    inc si
    pop cx
loop outer

ret