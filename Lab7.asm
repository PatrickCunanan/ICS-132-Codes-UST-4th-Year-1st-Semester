;CUNANAN,PATRICK BRYAN F. 4CSB LAB7
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

ADDITION MACRO M1,M2,M3,M4,VAR
inp1:   MOV DX,OFFSET M1
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        MOV BL,AL
        CMP BL,'0'
        JL inp1
        CMP BL,'9'
        JG inp1
        MOV DX,OFFSET M2
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        CMP AL,'0'
        JL inp1
        CMP AL,'9'
        JG inp1
        ADD AL,BL
        SUB AL,30H
    
        CMP AL,'9'
        JG inp1
    
        MOV DX,OFFSET M3
        MOV AH,9
        INT 21H
        MOV AH,2
        MOV DL,AL
        INT 21H
lbl_rpt:MOV DX,OFFSET M4
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        MOV VAR,AL
        CMP VAR,'Y'
        JE lbl_end
        CMP VAR,'N'
        JE lbl_end
        CMP VAR,'Y'
        JNE lbl_rpt
        CMP VAR,'N'
        JNE lbl_rpt
lbl_end:
ENDM

SUBTRACTION MACRO M1,M2,M3,M4,VAR
inp2:   MOV DX,OFFSET M1
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        MOV BL,AL
        CMP BL,'0'
        JL inp2
        CMP BL,'9'
        JG inp2
lbl_jump: MOV DX,OFFSET M2
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        CMP AL,'0'
        JL inp2
        CMP AL,'9'
        JG inp2
        CMP BL,AL
        JL lbl_jump
        SUB BL,AL
        ADD BL,30H
          
        CMP BL,'0'
        JL inp2
       
        MOV DX,OFFSET M3
        MOV AH,9
        INT 21H
        MOV AH,2
        MOV DL,BL
        INT 21H
lbl_rpt2: MOV DX,OFFSET M4
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        MOV VAR,AL
        CMP VAR,'Y'
        JE lbl_end2
        CMP VAR,'N'
        JE lbl_end2
        CMP VAR,'Y'
        JNE lbl_rpt2
        CMP VAR,'N'
        JNE lbl_rpt2
lbl_end2:
ENDM

    .MODEL SMALL
    .STACK
    .DATA
menu    DB 13,10,"Menu"
        DB 13,10,"1] Add"
        DB 13,10,"2] Sub"
        DB 13,10,"3] Exit"
        DB 13,10,"Choose: $"
s1      DB 13,10,"Input 1st number: $"
s2      DB 13,10,"Input 2nd number: $"
s3      DB 13,10,"The sum is: $"
s4      DB 13,10,"The difference is: $"
s5      DB 13,10,"Repeat again?(Y/N): $"
x       DB ?
y       DB ?
m       DB ?
r       DB ?
    .CODE
start:     INITIALIZE
    
lbl_menu:  PRINTSTRING menu
           GETINPUT m
           CMP m,'1'
           JL lbl_menu
           JE lbl_add
           CMP m,'2'
           JE lbl_sub2
           CMP m,'3'
           JE lbl_exit3
           CMP m,'4'
           JGE lbl_menu
           
lbl_sub2:  JMP lbl_sub

lbl_exit3: JMP lbl_exit2
    
lbl_add:   ADDITION s1,s2,s3,s5,r
           CMP r,"Y"
           JE lbl_menu2
           CMP r,"N"
           JE lbl_exit2
           
lbl_exit2: JMP lbl_exit

lbl_menu2: JMP lbl_menu

lbl_exit4: JMP lbl_exit2
          
lbl_sub:   SUBTRACTION s1,s2,s4,s5,r
           CMP r,"Y"
           JE lbl_menu2
           CMP r,"N"
           JE lbl_exit4
           
lbl_exit:  EXIT

end start