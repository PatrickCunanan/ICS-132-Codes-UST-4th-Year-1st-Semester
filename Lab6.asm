;CUNANAN,PATRICK BRYAN F. 4CSB LAB6
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
    
        .MODEL SMALL
        .STACK 100H
        .DATA
s1     DB 13,10,"Input 1st letter: $"
s2     DB 13,10,"Input 2nd letter: $"
s3     DB 13,10,"Isa akong henyo!$"
s4     DB 13,10,"You input 1st: $"
s5     DB 13,10,"You input 2nd: $"
x      DB ?
y      DB ?
        .CODE
start:
        INITIALIZE
        
        PRINTSTRING s1
        GETINPUT x
        PRINTSTRING s2
        GETINPUT y
        PRINTSTRING s4
        PRINTVAR x
        PRINTSTRING s5
        PRINTVAR y
        PRINTSTRING s3
        
        EXIT
end start