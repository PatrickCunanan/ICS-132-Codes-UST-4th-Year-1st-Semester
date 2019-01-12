;check if character is a letter, number or special character
;logic: sa ascii table, <special chars><0-9><special chars><A-Z><special chars><a-z><special chars>

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
.STACk 100H
.DATA
inputMsg DB 10,13,"Input a character: $"
charLet DB 10,13,"Your input is a letter.$"
charNum DB 10,13,"Your input is a number.$"
charSpc DB 10,13,"Your input is a special character.$"
retryMsg DB 10,13,"Repeat again? (Y/N): $"
.CODE
start: INITIALIZE
i:    PRINTSTRING inputMsg
    MOV AH, 1
    INT 21H
    CMP AL,'0'
    JL is_spc ; char below 0 are special chars
    CMP AL,'z'
    JG is_spc; char above z are special chars
    CMP AL,'0'
    JGE check1
    CMP AL,'9'
    JG check2
    CMP AL,'A'
    JGE check3
    CMP AL,'Z'
    JG check4
    CMP AL,'a'
    JGE check5
    
check1: CMP AL,'9'
        JLE is_num  

check2: CMP AL,'A'
        JL is_spc   

check3: CMP AL,'Z'
        JLE is_let
        
check4: CMP AL,'a'
        JL is_spc
        
check5: CMP AL,'z'
        JLE is_let
        
is_let:    PRINTSTRING charLet
           JMP retry

is_num:    PRINTSTRING charNum
           JMP retry

is_spc:    PRINTSTRING charSpc
           JMP retry
    
retry:  PRINTSTRING retryMsg
        MOV AH,1
        INT 21H
        MOV BL,AL
        CMP BL,'Y'
        JE i
        CMP BL,'N'
        JE exitlbl
        CMP BL,'Y'
        JNE retry
        CMP BL,'N'
        JNE retry
    
exitlbl:    EXIT
end start