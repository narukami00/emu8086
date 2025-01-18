;Roll : 2207006

data segment
    str db 'Number : $'
    msg1 db 'YES, it is Armstrong.$'
    msg2 db 'NO, it is not Armstrong.$'
    num dw ?
    ten db 10
    q db ?
    rem db ?
    digits db ?
data ends


code segment
    assume cs : code, ds: data, es: data

start:
    mov ax,data
    mov ds,ax
    mov es,ax
    mov ah,09h
    mov dx, offset str
    int 21h
    mov bl,0
    mov dh,0
    mov cl,0
input:
    mov ah,01h
    int 21h
    cmp al,13
    je input_done
sub al,30h
mov dl,al
mov ax,bx
mul ten
add ax,dx
mov bx,ax
inc cl
jmp input 

input_done:
    mov num,bx
    mov ax,num
    mov bx,0
    mov digits,cl

do:
    cmp al,0
    je done
    div ten
    mov rem,ah
    mov ah,0
    mov q,al
    mov al,rem
    mov cl,digits
    dec cl
    multiply:
        mul rem
        loop multiply
    add bx,ax
    mov ax,0
    mov al,q
    jmp do 
done:
    mov ax,num
    cmp ax,bx
    jne not_arm
    lea dx,msg1
    mov ah,09
    int 21h
    jmp last
    not_arm:
        lea dx,msg2
        mov ah,09
        int 21h
    last:
        mov ah,4ch
        int 21h
code ends    

end start