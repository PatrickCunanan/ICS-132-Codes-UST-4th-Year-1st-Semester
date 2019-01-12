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
.STACK 100H
.DATA
notpal DB 10,13,"The string is not a palindrome.$"
yespal DB 10,13,"The string is a palindrome.$"
inputs DB 10,13,"Input a string: $"
string DB ?
.code
start:
    INITIALIZE
    PRINTSTRING inputs
    
    lea dx, string
    mov ah, 0ah
int 21h

lea di, string+2
lea si, di
mov cl, string[1]
sub cl, 1
add si, cx
shr cx, 1

checkPal:
mov al, [di]
mov dl, [si]
cmp al, dl
jne printNotPal
inc di
dec si
loop checkPal

printPal:
lea dx, yespal

printNotPal:
lea dx, notpal
    
    EXIT
end start