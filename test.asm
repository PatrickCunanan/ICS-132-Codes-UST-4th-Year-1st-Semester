.model small
.stack 100h
.data
msg db 'Jann Allen','$'
curpos dw ?
.code
start:
    mov ax,@data
    mov ds,ax
    ;loop
    again:
        ;clr screen
        mov ah,6
        mov al,0
        mov cl,0
        mov ch,0
        mov dl,4Fh
        mov dh,18h
        mov bh,10
        int 10h
        ;print
        mov ah,09h
        mov dx,offset msg
        int 21h
        ;delay
        mov bp,10
        mov si,10
        delay:
            dec bp
            nop
            jnz delay
           dec si
           cmp si,0
            jnz delay
        ;get pos
        mov ah,3
        mov bh,0
        int 10h
        mov curpos,dx
        ;set pos
        mov ah,2
        mov dx,curpos
        add dh,1
        mov bh,0
        int 10h
    loop again
    ;end
    mov ah,4ch
    int 21h
end start
