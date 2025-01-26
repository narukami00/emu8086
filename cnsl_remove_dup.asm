org 100h

call take_input
call remove_dups
call print_output
jmp exit

remove_dups proc near
    pushf
    mov cx,len
    lea si,arr
    lea di,res
    mov al,[si]
    mov [di],al
    inc len_res
    dec cx
    inc si
    
    outer:
        mov al,[si]
        push cx
        lea di,res
        mov cx,len_res
        inner:
            mov ah,[di]
            cmp al,ah
            je goto_outer
            inc di
        loop inner
        mov [di],al
        inc len_res
        
        goto_outer:
            inc si
            pop cx
    loop outer
    popf
    ret
remove_dups endp


take_input proc near:
    pushf
    mov ah,1h
    mov si,0
    loop1:
        int 21h
        cmp al,0dh
        je input_end
        cmp al,20h
        je skip
        mov arr[si],al
        inc si
        skip:
    jmp loop1:
    
    input_end:
        mov len,si;
        popf
        ret
take_input endp

print_output proc near:
    lea dx,new_line
    mov ah,09h
    int 21h
    
    mov si,0
    loop2:
        xor dx,dx
        mov dl,res[si]       
        mov ah,02h
        int 21h
        
        lea dx,space
        mov ah,09h
        int 21h
        
        inc si
        cmp si, len_res
        je output_end
    jmp loop2
    
    output_end:   
        ret
print_output endp
    
    

exit:
    mov ah,4ch
    int 21h
    ret
   
arr db 100 dup(0)
len dw ?
res db 100 dup(0)
len_res dw 00h

new_line db 0ah,'$'
space db 20h,'$'
