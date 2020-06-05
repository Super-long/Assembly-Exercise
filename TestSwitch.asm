DATA SEGMENT

    msg1 db 'Monday$'
    msg2 db 'Tuesday$'
    msg3 db 'Wednesday$'
    msg4 db 'Thyrsday$'
    msg5 db 'Friday$'
    msg6 db 'Saturday$'
    msg7 db 'Sunday$'
    msg  db 'input number(1-7):$'

    table dw disp1,disp2,disp3,disp4
          dw disp5,disp6,disp7

DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:
        MOV BX, DATA
        MOV DS, BX
    again:
        LEA DX, msg
        MOV AH, 9       ; 9号系统调用,从DX取数据并输出
        INT 21H

        XOR AX, AX      ; 清空AX,不然后面乘4低位会出现错误
        MOV AH, 01H     ; 1号系统调用,将字符输入到AL中
        INT 21H
        ;MOVZX AX, AL
        SUB AX, 100H    ; 系统调用会在AX上加100h
        SUB AX, 30H     ; ascll码，减30h变裸数字
        CMP AL, 1
        ;SUB AL, 30H     ; ASCLL码,减去30
        JB  again
        CMP AL, 7
        JA  again       ; 不在范围内重新输入
        
        DEC AL
        MOV AX, AL
        MOV AH, 0
        ;MUL AX, 4       ; 相当于乘4, 左移也可
        SHL AX, 1
        ;SHL AX, 1       ; 这里有一点疑惑，我label定义的是dw，可是乘4就会出现错误
        MOV BX, AX
        ;jmp dword ptr table[AX] ; 16位dos环境中，AX不能用作偏移地址
        JMP WORD PTR TABLE[BX]
    disp1:
        MOV AX, OFFSET msg1
        jmp disp
    disp2:
        MOV AX, OFFSET msg2
        jmp disp
    disp3:
        MOV AX, OFFSET msg3
        jmp disp
    disp4:
        MOV AX, OFFSET msg4
        jmp disp
    disp5:
        MOV AX, OFFSET msg5
        jmp disp
    disp6:
        MOV AX, OFFSET msg6
        jmp disp
    disp7:
        MOV AX, OFFSET msg7
        jmp disp
    disp:
        MOV DX, AX
        MOV AH, 9
        INT 21H
        
        MOV AH, 4CH
        INT 21H         ;控制权返回给终端
CODE ENDS
END START
