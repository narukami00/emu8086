include 'emu8086.inc'  


.stack 100h
.model small

.data
    input db 100 dup('$')
    freq dw 26 dup(0)
    len dw 0

.code 

    main proc
        mov ax, @data
        mov ds, ax
        
        print 'Enter string : '
        call take_input
        call newline
        
        mov ax, offset input
        push ax
        call count_freq
        
        call print_freq
        
        mov ah, 4ch
        int 21h
        
    main endp
    
    
    take_input proc near
        pushf
        mov si, 0
        
        read:
            mov ah, 01h
            int 21h
            cmp al, 0dh
            je end_input
            
            cmp al, 'a'
            jb read
            
            cmp al, 'z'
            ja read
            
            mov input[si],al
            inc si
            jmp read
            
            end_input:
                mov input[si], '$'
                mov len, si
                popf
                ret
     take_input endp
    
    
    count_freq proc near
        push bp
        mov bp, sp
        push si
        push ax
        push bx
        push di
          
        mov ax, ds
        mov es, ax  
        mov cx, 26
        xor ax, ax
        mov di, offset freq
        rep stosw
        
        mov si, [bp+4]
        
        cnt_loop:
            mov al, [si]
            cmp al, '$'
            je cf_done
            
            sub al, 'a' 
            xor ah, ah
            mov bx, ax 
            shl bx, 1
            inc freq[bx]
            inc si
        jmp cnt_loop
        
        cf_done: 
            pop di
            pop bx
            pop ax
            pop si
            pop bp
            ret
     count_freq endp
    
    
    print_freq proc near
        push bp
        mov bp, sp
        push ax
        push bx
        push dx
        xor bx, bx
        
        print_loop: 
            cmp bx, 26
            jge pf_done
            
            shl bx, 1
            mov ax, freq[bx] 
            shr bx, 1
            
            cmp ax, 0
            je skip_print
            
            mov dl, 'a'
            add dl, bl
            mov ah, 02h
            int 21h
            
            shl bx, 1
            mov ax, freq[bx] 
            shr bx, 1
            
            call print_num
            
            skip_print:
                inc bx
                jmp print_loop
            
            pf_done:    
                pop dx
                pop bx
                pop ax
                pop bp
                ret    
    print_freq endp
    
    
    newline proc near
        push ax
        push dx
        
        mov dl, 13
        mov ah, 02h
        int 21h
        
        mov dl, 10
        mov ah, 02h
        int 21h
        
        pop dx
        pop ax
        ret
    newline endp

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS 
    
end main    
            


