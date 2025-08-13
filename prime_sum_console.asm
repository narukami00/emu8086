include 'emu8086.inc'    
.stack 100h
.model small


.data
    
    arr dw 100 dup(?)
    len dw 0
    sum dw 0
    num dw 0



.code


    print_num macro
        push ax
        push bx
        push cx
        push dx
        
        mov cx, 0
        mov bx, 10
        
        pn_loop:
            xor dx, dx
            div bx
            push dx
            inc cx
            test ax, ax
            jnz pn_loop
            
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
    endm    

    main proc
        mov ax, @data
        mov ds, ax 
        
        print 'Enter array elements : '   
        call take_input
        call newline                      
        
        
        mov ax, offset arr
        push len
        push ax
        call prime_sum
        
        mov ah, 4ch
        int 21h
        
    main endp 
    
    
    
    
    prime_sum proc near
        push bp
        mov bp, sp
        pushf
        push si
        push di
        push ax
        push bx
        push cx
        push dx
        
        mov si, [bp+4]
        mov cx, [bp+6]
        
        l1:
            mov ax, [si]
            mov num, ax
            call prime
            cmp ax, 1
            jne not_prime
            mov ax, [si]
            add sum, ax
            
            not_prime:
                add si, 2
         loop l1
         
         print 'Sum of primes : '
         mov ax, [sum]
         print_num
         
         mov ax, [sum]
         mov num, ax
         call prime 
         
         cmp ax, 1
         jne not_prime_1
                          
         
         call newline                
         print 'Sum is prime!' 
         
         jmp finished 
         
         not_prime_1:  
            call newline
            print 'Sum is NOT prime :('
            
         finished:
            pop dx
            pop cx
            pop bx
            pop ax
            pop di
            pop si
            popf
            pop bp
            ret 4       
        
    prime_sum endp 
    
    
    
    
    prime proc near  
        
        cmp ax, 2
        je is_prime
        jl isnt_prime
        
        mov bx, 2
        
        chk_loop:
            cmp  bx, ax
            je is_prime
            xor dx, dx
            div bx
            cmp dx, 0
            je isnt_prime
            inc bx
            mov ax, num
            jmp chk_loop
            
            is_prime:
                mov ax, 1
                ret               
            isnt_prime:
                mov ax, 0
                ret
    prime endp    
    
    
    take_input proc near
        pushf
        mov si, 0
        mov bx, 0
        mov di, 0
        
        read:
            mov ah, 1
            int 21h
            cmp al, 0dh
            je end_input
            
            cmp al, ' '
            je store_num
            
            cmp al, '0'
            jb read
            cmp al, '9'
            ja read
            
            sub al, '0'
            mov ah, 0
            mov cx, ax
            
            mov ax, bx
            mov dx, 10
            mul dx
            add ax, cx
            mov bx, ax
            mov di, 1
            jmp read
            
            store_num:
                cmp di, 0
                je read
                mov arr[si], bx
                add si, 2   
                mov bx, 0
                mov di, 0
                jmp read
            
            end_input:
                cmp di, 0
                je skip
                mov arr[si], bx
                add si, 2
            
            skip:
                mov len, si
                shr len, 1
                popf
                ret        
    take_input endp   
    
    
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