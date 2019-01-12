.MODEL SMALL
.STACK
.DATA
label  DB 13,10,"Full Name: Mark Angelo M. Antonio"
       DB 13,10,"Student Number: 2014-072542"
       DB 13,10,"Course: Computer Science$"
.CODE
start:
        MOV AX,@DATA
        MOV DS,AX
        
        MOV AX,3
        MOV DX,OFFSET label
        MOV AH,9
        INT 21H
        
        MOV AH, 4CH
        INT 21H
end start