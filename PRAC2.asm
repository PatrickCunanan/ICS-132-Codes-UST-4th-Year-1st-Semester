INITIALIZE MACRO
    MOV AX,@DATA
    MOV DS,AX
    MOV AX,3
ENDM

EXIT MACRO
    MOV AH, 4CH
    INT 21H
ENDM

PRINTSTRING MACRO PARAM1
    MOV DX,OFFSET PARAM1
    MOV AH,9
    INT 21H
ENDM
 
GETINPUT MACRO VAR
    MOV AH,1
    INT 21H
    MOV VAR,AL
ENDM

PRINTVAR MACRO PARAM2
   MOV AH,2
   MOV DL,PARAM2
   INT 21H
ENDM

ADDNUM MACRO VAR1,VAR2,VAR3

ENDM

    .MODEL SMALL
    .STACK 100H
    .DATA
s1      DB 13,10,"Enter first number: $"
s2      DB 13,10,"Enter second number: $"
s3      DB 13,10,"Sum: $"
x       DB ?
y       DB ?
    .CODE
start:
    INITIALIZE
    
    PRINTSTRING s1
    GETINPUT x
    PRINTSTRING s2
    GETINPUT y
    
    ADD AL,x
    MOV AH,0
    AAA
    
    ADD AL,48
    ADD AH,48
    
    MOV BX,AX
    
    PRINTSTRING s3
    MOV AH,2
    MOV DL,BH
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    
    EXIT
end start


;hex ng dash is 2D