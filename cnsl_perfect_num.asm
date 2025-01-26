org 100h  

call TAKE_INPUT
mov bx,num
call perfect_num 

mov ah,4ch
int 21h



perfect_num proc near
    pushf 
    push bx
    mov cx,1
    mov si, 0 
    
    check_divs:
        cmp cx, bx
        je check_res
        
        mov ax,bx
        xor dx,dx
        div cx
        
        cmp dx,0
        jnz next_div
        add si, cx  
        
    next_div:
        inc cx
        jmp check_divs 
        
    check_res:
        mov ax,si
        cmp ax,bx
        je is_perfect
        jne not_perfect
        
    is_perfect:
        call NEWLINE_F
        call YES_F
        pop bx
        popf
        ret    
        
    not_perfect:
        call NEWLINE_F
        call NO_F 
        pop bx
        popf
        ret  
        
perfect_num endp
  
  
TAKE_INPUT proc near
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
    ret
TAKE_INPUT endp            
          
      
      
NEWLINE_F proc near
    lea dx, newline
    mov ah,09h
    int 21h
    ret
NEWLINE_F endp
      
      
      
YES_F proc near
    lea dx,YES
    mov ah,09h
    int 21h
    ret
YES_F endp
      
      
      
NO_F proc near
    lea dx,NO
    mov ah,09h
    int 21h
    ret
NO_F endp
         

         
sum_div dw 0
ten db 10
digits db ?
num dw ?
str db 'Number : $'         
YES db 'Yes!$'
NO db 'NO!$'
newline db 0ah,'$'