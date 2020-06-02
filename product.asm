ASSUME CS:CODE,DS:DATA,SS:STACK

STACK SEGMENT
    db 20 dup(0)
STACK ENDS

DATA SEGMENT
    db 20 dup(0)
    str db "hello world!$"
DATA ENDS

CODE SEGMENT
START:

    MOV AX, DATA
    MOV DS, AX
    MOV AX, STACK
    MOV SS, AX

    ;开始业务逻辑部分
    MOV AX, 3h ;传递参数 立即数不能直接传递
    PUSH AX
    MOV AX, 4H
    PUSH AX
    CALL sum

    MOV DL, AX

    MOV AH, 02h; 从DX取值并输出
    INT 21H

    MOV AH, 4CH ; 将控制权转移给终端   
    INT 21H ; 产生系统中断
sum:    
    PUSH bp
    MOV BP, SP ; 初始化函数堆栈
    SUB SP, 20 ; 20字节留作局部变量
    ; 保护寄存器
    PUSH BX
    PUSH CX
    PUSH DX

    ; 定义两个局部变量
    MOV word ptr SS:[BP - 2], 1h
    MOV word ptr SS:[BP - 4], 2h

    ; 修改寄存器
    MOV BX, 2h
    MOV CX, 3h
    MOV DX, 4h

    ; 计算部分 两个参数加上常数1+2
    MOV AX,SS:[BP + 6]; param1
    ADD AX,SS:[BP + 4]; param2
    ADD AX,SS:[BP - 2]; 1
    ADD AX,SS:[BP - 4]; 2
    ADD AX, 30H; 输出为ascll码,加上48
    //|--------|
    //|param2 3|
    //|param1 4|
    //|ret_addr|
    //|ebp     |
    //|ebp-2 1h|
    //|ebp-4 2h|
    //|--------|
    ; 恢复寄存器
    POP DX
    POP CX
    POP BX

    MOV SP,BP
    POP BP

    RET  
    
CODE ENDS
END START
