data segment 
    bcd_input db 17h
    bin_value db ?
data ends

stack_seg segment
    stack dw 100 dup(0)
    top_stack label word
stack_seg ends

code segment
    assume cs:code, ds:data, ss:stack_seg
start:
        mov ax, data
        mov ds, ax
        mov ax, stack_seg
        mov ss, ax
        mov sp, offset top_stack
        
        mov al, bcd_input
        call bcd_bin
        mov bin_value, al       
        int 20h
      
        bcd_bin proc near
            pushf
            push bx
            push cx
            
            mov bl, al
            and bl, 0fh
            and al, 0f0h
            mov cl, 04
            ror al, cl
            mov bh, 0ah
            mul bh
            
            add al, bl
            
            pop cx
            pop bx
            popf
     
            ret 
                     
        bcd_bin endp
              
code ends

end start  