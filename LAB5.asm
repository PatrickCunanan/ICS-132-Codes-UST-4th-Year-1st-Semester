        .MODEL SMALL
        .STACK
        .DATA
msg    DB 13,10,"Full Name: Patrick Bryan F. Cunanan"
       DB 13,10,"Student Number: 2014-069410"
       DB 13,10,"Course: Computer Science$"
        .CODE
start:
        MOV AX,@DATA
        MOV DS,AX
        
        MOV AX,3
        MOV DX,OFFSET msg
        MOV AH,9
        INT 21H
        
        MOV AH, 4CH
        INT 21H
end start