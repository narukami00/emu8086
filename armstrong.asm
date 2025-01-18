org 100h

  mov num, 153
  mov si, 0
  mov ax, num
  mov bx, 10
  
  l: 
    mov dx, 0
    div bx
    push dx
    inc si 
    cmp ax, 0
    jg l
    
    mov di, si
    mov bx, 0
    
    pl:
    pop dx
    mov ax, 1
    mov cx, si
    
    l2:
      mul dl
      loop l2
    add bx, ax
    dec di
    cmp di, 0
    jg pl  
    
    cmp bx, num
    lea dx, yes
    je lst
      lea dx, no
    lst:

    mov ah, 9h
    int 21h 
      
  
int 20h
ret

yes db 'yes$'
no db 'no$'

num dw ?