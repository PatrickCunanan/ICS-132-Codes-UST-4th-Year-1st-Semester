    .model small
    .stack
    .data
   string 1 db "Isa akong henyo!$"
   .code
   
    mov ah,1
    int 21h
    cmp  al,13d
    jne input
   
   end code