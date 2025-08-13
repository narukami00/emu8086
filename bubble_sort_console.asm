include 'emu8086.inc'
.stack 100h
.model small

.data   

input dw 100 dup(?)
len dw 0


.code


    main proc 
        mov ax, @data
        mov ds, ax 
        
        print 'Enter numbers : '
        call take_input   
        call newline     
        
        mov ax, offset input 
        push len   
        push ax              
        call bubble_sort

        
        print 'Sorted elements: '
        call print_array
        call newline
        
        mov ah, 4Ch    
        int 21h
        
        
    main endp 
    
    
    
    
    ; bubble_sort(len, arr_offset)
    ; arr_offset = offset of array (word elements)
    ; len        = number of elements (word count)

    bubble_sort proc near
        push bp
        mov bp, sp         
        pushf
        push si
        push di
        push ax
        push bx
        push cx
        push dx
    
        mov si, [bp+4]     ; array offset
        mov cx, [bp+6]     ; length
        dec cx             
        mov di, si         
    
    outer_loop:
        mov bx, cx         ; bx = passes left for inner loop
        mov si, di         ; reset SI to start of array
    
    inner_loop:
        mov ax, [si]       ; load current word
        cmp ax, [si+2]     ; compare with next word
        jbe no_swap        ; if ax <= next, no swap
    
        ; swap
        mov dx, [si+2]
        mov [si+2], ax
        mov [si], dx
    
    no_swap:
        add si, 2          ; move to next word
        dec bx
        jnz inner_loop     ; inner loop until bx = 0
    
        dec cx
        jnz outer_loop     ; outer loop until cx = 0
    
        pop dx
        pop cx
        pop bx
        pop ax
        pop di
        pop si
        popf
        pop bp
        ret 4              
    bubble_sort endp

    
    
    take_input proc near
        pushf
        mov si, 0      
        mov bx, 0    
        mov di, 0       ; number input - yes->1 , no->0
    
    read_loop:
        mov ah, 1
        int 21h
        cmp al, 0Dh
        je end_input    ; end if enter
    
        cmp al, ' '
        je space_found  ; store built number on space
           
        ; ignore other characters other than 0-9   
        cmp al, '0'
        jb read_loop    
        cmp al, '9'
        ja read_loop
                    
        ; convert to decimal from ascii            
        sub al, '0'
        mov ah, 0
        mov cx, ax
        
        ; multiply already stored number in bx by 10, add the new character , store it back to bx
        mov ax, bx
        mov dx, 10
        mul dx
        add ax, cx
        mov bx, ax
        mov di, 1
        jmp read_loop
    
    space_found:
        cmp di, 0     ; if no number input yet
        je read_loop
        mov input[si], bx
        add si, 2
        mov bx, 0
        mov di, 0
        jmp read_loop
    
    end_input:
        cmp di, 0
        je skip_last   ; skip last if it wasn't a number
        mov input[si], bx
        add si, 2
    
    skip_last:
        mov len, si 
        shr len, 1     ; divide len by 2 as si is 2xlen
        popf
        ret
    take_input endp   
    
    
    
    print_array proc near
        push ax
        push bx
        push cx
        push dx
        push si
    
        mov cx, len      
        mov si, 0         
    
    next_num:
        mov ax, input[si] 
        call print_num   
        mov dl, ' '       
        mov ah, 02h
        int 21h
    
        add si, 2        
        loop next_num
    
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    print_array endp        
    
    
    
    print_num proc near
        push ax
        push bx
        push cx
        push dx
    
        mov cx, 0         ; digit count
        mov bx, 10        ; divisor
    
    pn_loop:
        xor dx, dx        ; clear DX before div
        div bx            ; AX / 10 ? AX=quotient, DX=remainder
        push dx           ; store remainder (digit)
        inc cx            ; count digits
        test ax, ax
        jnz pn_loop       ; repeat until quotient = 0
    
    pn_print:
        pop dx
        add dl, '0'
        mov ah, 02h
        int 21h
        loop pn_print
    
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    print_num endp


    
    newline proc near
        mov dl, 10
        mov ah, 02h
        int 21h
        
        mov dl, 13
        mov ah, 02h
        int 21h    
        
        ret
    newline endp    
        
    
    
end main    