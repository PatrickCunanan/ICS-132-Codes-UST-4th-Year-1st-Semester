.MODEL SMALL
.STACK 100H
.DATA
        STR1    DB      100   DUP(' '),'$'
        STR2    DB      100   DUP(' '),'$'
        NL      DB      0DH,0AH,'$'
.CODE
MAIN    PROC
        MOV AX,@DATA
        MOV DS,AX

        LEA SI,STR1
        LEA DI,STR2

        MOV AH,01H
AGAIN:
        INT 21H
        CMP AL,0DH
        JE  BAK

        MOV [SI],AL
        INC SI
        JMP AGAIN
BAK:
        MOV AL,'$'
        MOV [SI],AL

        MOV AH,09H
        LEA DX,NL
        INT 21H

        MOV CX,LENGTH STR1
        ADD CX,1
DOTHIS:
        DEC SI
        MOV AL,[SI]

        MOV [DI],AL
        INC DI
        LOOP DOTHIS

        MOV AL,'$'
        MOV [DI],AL

        MOV AH,09H

        LEA DX,NL
        INT 21H
        LEA DX,STR2
        INT 21H

        MOV AH,4CH
        INT 21H

MAIN    ENDP
END   MAIN