; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    num dw 200
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;Sommare tutti gli elementi di un vettore e metterli in una variabile
    mov ax, 10410
    mov cx, 0
    xor bx,bx
    call stampaln
    
           
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends
     
; put in ax the number u wanna print out  
stampaln proc 
startf:
    cmp ax, 0       
    jg continue
    je fine
    
continue:
    mov dx, 0
    inc cx
    mov bx, 10
    div bx
    push dx
    jmp startf
fine:      
    pop dx
    mov dh, 0
    add dl, 48
    mov ah, 02h
    int 21h
    loop fine
    
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    
    ret

stampaln endp     
 
end start ; set entry point and stop the assembler.
