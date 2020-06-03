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

    again:
        MOV DX, msg
        MOV AH, 9       ; 9号系统调用,从DX取数据并输出
        INT 21H

        MOV AH, 01H     ; 1号系统调用,将字符输入到AL中
        INT 21H
        CMP AL, 1
        JB  again
        CMP AL, 7
        JA  again       ; 不在范围内重新输入
        
        DEC AL
        MOV AX, AL
        MUL AX, 4       ; 相当于乘4, 左移也可
        ;JMP near ptr [table[AX] ; 跳转到相应的的label
        ;MUL AL, 4
        ;MOV AX, dword ptr [table[AL]]
        jmp dword ptr table[AX]

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

CODE ENDS
END START
