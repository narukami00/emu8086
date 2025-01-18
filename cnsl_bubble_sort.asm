org 100h  
   
call take_input  
call bubble_sort                                  
call print_to_console

jmp exit
  
  
bubble_sort proc near 
    
    pushf
    push cx
    push dx
    lea si, input
    mov ax, 0001h
    mov bx, si
    
    outer_loop:
        cmp ax,len
        je endl
        mov cx, len
        sub cx, ax
        
        inner_loop:
            mov dh,[si]
            cmp dh,[si+1]
            ja swap
            jmp below
            
            swap:
                mov dl,[si+1]
                mov [si+1],dh
                mov [si],dl
            below:
                inc si
        loop inner_loop    
        
        inc ax
        mov si,bx
    jmp outer_loop

    endl:
        pop dx
        pop cx
        popf        
        ret  
    
bubble_sort endp 
  
  
  
print_to_console proc near 
    lea dx, input
    mov ah,09h
    int 21h
    ret
    
print_to_console endp    
 
 
 

take_input proc near 
    
    pushf
    mov ah, 1h
    mov si, 0
    
    il1:
      int 21h
      cmp al, 0dh
      je iend
      mov input[si], al
      inc si
    jmp il1
      
      
    iend: 
      mov len, si 
      popf
      ret 
      
take_input endp
  
  

exit:  
    mov ah, 4ch
    int 21h
    ret

input db 100 dup('$')
len dw ?          