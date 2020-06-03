;实现求平均数
DATA SEGMENT
    sum DW 1,2,3,4,5,6,7,8,9
DATA ENDS

STACK SEGMENT

STACK ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA,SS:STACK
START:
    MOV BX, DATA
    MOV DS, BX

    MOV CX, 9 ; loop使用CX作为判断条件 即设置循环次数
    XOR AX, AX ;清零
    XOR BX, BX
    MOV SI, OFFSET sum
again:
    ;MOV DX, BX
    ;MUL DX, 4 ;计算直接指向的值
    ADD AX, [SI]
    ADD SI, 2 ; 索引 
    LOOP again ; 循环结构
    
    ;CDQ 
    MOV CL, 9
    DIV CL ; 商在AX， 余数在DX
    
    MOV DL, AL
    ADD DL, 30H
    MOV AH, 02H ;2号系统调用，从DL取出值输出
    INT 21H

    MOV AH, 4CH ;控制权返回给终端,不写的话显示完就卡那了
    INT 21H

CODE ENDS
END START
