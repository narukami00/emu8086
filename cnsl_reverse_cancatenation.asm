org 100h
  
call take_input_s1
call print_new_line
call take_input_s2
call reverse_concat
call print_new_line
call print_output
jmp exit

  
reverse_concat proc near
    xor ax,ax
    mov ax,'$'
    push ax
    
    mov si,0
    loop1:
        xor ax,ax
        mov al,s1[si]
        cmp al,'$'
        je loop1exit
        push ax
        inc si
    jmp loop1
    
    loop1exit:
        mov si,0
    
    loop3:
        xor ax,ax
        pop ax
        cmp al, '$'
        je loop3exit
        mov s[si],al
        inc si
    jmp loop3
    
    loop3exit:
        mov n,si
    
    xor ax,ax
    mov ax,'$'
    push ax
    mov si,0
    
    loop2:
        xor ax,ax
        mov al,s2[si]
        cmp al,'$'
        je loop2exit
        push ax
        inc si
    jmp loop2
    
    loop2exit: 
        mov si,n
    loop4:     
        xor ax,ax
        pop ax
        cmp al, '$'
        je loop4exit
        mov s[si],al
        inc si
    jmp loop4
    
    loop4exit:
    ret
reverse_concat endp 



take_input_s1 proc near
    pushf
    mov ah,1h
    mov si,0
    
    iloop1:
        int 21h
        cmp al,0dh
        je iend1
        mov s1[si],al 
        inc si
   jmp iloop1
   
   iend1: 
        mov len1,si
        popf
        ret
take_input_s1 endp


take_input_s2 proc near
    pushf
    mov ah,1h
    mov si,0
    
    iloop2:
        int 21h
        cmp al,0dh
        je iend2
        mov s2[si],al 
        inc si
   jmp iloop2
   
   iend2:
        mov len2,si
        popf
        ret
take_input_s2 endp



print_output proc near
    lea dx,s
    mov ah,09h
    int 21h
    ret
print_output endp
    

print_new_line proc near
    lea dx, newline
    mov ah,09h
    int 21h  
    ret
print_new_line endp


exit:
    mov ah,4ch
    int 21h
    ret
            
s1 db 100 dup('$')
s2 db 100 dup('$')
len1 dw ?
len2 dw ?

s db 100 dup('$') 
n dw ?

newline db 0ah,'$'        