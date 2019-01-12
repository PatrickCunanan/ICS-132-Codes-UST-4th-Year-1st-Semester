;CUNANAN,PATRICK BRYAN F. 4CSB LAB8
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
 
PRINTVAR MACRO PARAM2
   MOV AH,2
   MOV DL,PARAM2
   INT 21H
ENDM

    .MODEL SMALL
    .STACK
    .DATA
s1  DB 13,10,"Input 1st Number: $"
s2  DB 13,10,"Operand: $"
s3  DB 13,10,"Input 2nd Number: $"
s4  DB 13,10,"The result is: $"
s5  DB 13,10,"Repeat again? (Y/N): $"
x   DB ?
y   DB ?
o   DB ?
    .CODE
start:  INITIALIZE
    
input1:  PRINTSTRING s1
         MOV AH,1
         INT 21H
         MOV BL,AL
         CMP BL,'0'
         JL input1
         CMP BL,'9'
         JG input1
        
operator: PRINTSTRING s2
          MOV AH,1
          INT 21H
          MOV CL,AL
          CMP CL,'+'
          JE input2
          CMP CL,"-"
          JE input2
          
          JMP operator
          
input2:  PRINTSTRING s3
         MOV AH,1
         INT 21H
         CMP AL,'0'
         JL input2
         CMP AL,'9'
         JG input2
         CMP CL,'+'
         JE addition
         CMP CL,"-"
         JE subtract
         
subtract:CMP BL,AL
         JL input2
         CMP BL,AL
         JGE subtraction
         
addition:  ADD BL,AL
           SUB BL,30H
           CMP BL,'9'
           JG input1
           PRINTSTRING s4
           PRINTVAR BL
           JMP lbl_rpt

subtraction:  SUB BL,AL
              ADD BL,30H
              CMP BL,'0'
              JL input1
              PRINTSTRING s4
              PRINTVAR BL
              JMP lbl_rpt
              
lbl_input: JMP input1
              
lbl_rpt: MOV DX,OFFSET s5
        MOV AH,9
        INT 21H
        MOV AH,1
        INT 21H
        CMP AL,'Y'
        JE lbl_rpt2
        CMP AL,'N'
        JE lbl_rpt2
        CMP AL,'Y'
        JNE lbl_rpt
        CMP AL,'N'
        JNE lbl_rpt

lbl_rpt2: CMP AL,"Y"
          JE lbl_input
          CMP AL,"N"
          JE lbl_exit
         
lbl_exit: EXIT
         
end start