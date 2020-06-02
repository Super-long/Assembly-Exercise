DATA SEGMENT
        
    cr equ 13
    var db 'HELLO world'
    ;str dword 5 dup(1)

DATA ENDS        
ASSUME CS:CODE, DS:DATA
CODE SEGMENT

    START:
    MOV BX, DATA
    MOV DS, BX

    mov al, 0
    mov ax, 190
    mov ax, -1
    ;mov ax, 0ffffffffh ; 32位的寄存器 放不进去 overflow了
    mov ax, offset var
    ;mov ax, sizeof var ;根本没有sizeof这个符号

    mov ax, length var

    mov ax, type var

    mov al, $
    mov ax, cr
    ret

CODE ENDS
END START
