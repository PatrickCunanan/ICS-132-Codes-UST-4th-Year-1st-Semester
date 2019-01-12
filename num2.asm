;PATRICK BRYAN F. CUNANAN 4CSB
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

.MODEL SMALL
.STACK
.DATA
inputMsg DB 10,13,'Enter a character: $'
letMsg DB 10,13,'Your character is a LETTER.$'
numMsg DB 10,13,'Your character is a NUMBER.$'
spcMsg DB 10,13,'Your character is a SPECIAL SYMBOL.$'
retryMsg DB 10,13,"Repeat again? (y/n): $"
.CODE

start: INITIALIZE

input:  PRINTSTRING inputMsg
        MOV AH, 1
        INT 21H
        
        CMP AL,'0'
        JL isspc
        CMP AL,'z'
        JG isspc
        CMP AL,'0'
        JGE check1
        CMP AL,'9'
        JG  check2
        CMP AL,'A'
        JGE check3
        CMP AL,'Z'
        JG check4
        CMP AL,'a'
        JGE check5
        
check1: CMP AL,'9'
        JLE isnum

check2: CMP AL,'A'
        JL isspc

check3: CMP AL,'Z'
        JLE islet

check4: CMP AL,'a'
        JL isspc

check5: CMP AL,'z'
        JLE islet

islet: PRINTSTRING letMsg
       JMP retry

isnum: PRINTSTRING numMsg
       JMP retry

isspc: PRINTSTRING spcMsg
       JMP retry

retry:  PRINTSTRING retryMsg
        MOV AH,1
        INT 21H
        MOV BL,AL
        CMP BL,'y'
        JE input
        CMP BL,'n'
        JE exitlbl
        CMP BL,'y'
        JNE retry
        CMP BL,'n'
        JNE retry

        exitlbl: EXIT

end start