DATA SEGMENT

    result db "         " ; 9位
    
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
START:

    MOV AX, DATA
    MOV DS, AX
    MOV SI, 0   ; 目前到第几个随机数
    doRand:         ; 这里设置一个label方便其他程序调用
        
        CreateRandNumdo1:   ; 每执行一次可以确定一个随机数
            CALL getRand    ; 这个随机数在AL中
            
            XOR DI, DI
            XOR CX, CX

            LEA DI, result  ; di中存着result的起始地址
            ; 这里在前几次会有很多无意义的执行,但是因为初始值为0,所以正确性是可以保证的
            MOV CX, 8       ; CX为loop默认使用的寄存器,SI为现在已有的随机字符数,也就是循环这么多次
            CreateRandNumdo2:
                MOV BH, [DI]; 每次通过[DI]取一个值
                CMP BH, AL  ; 比较此次得到的随机数和已有的随机数
                JZ CreateRandNumdo1 ; 出现重复的时候再次生成随机数
                INC DI
                LOOP CreateRandNumdo2
        ; CreateRandNumdo1结束以后,AL中存放着此次要插入的值,插入到result[SI]中
        
        ;ADD AL, 30H ; 输出为ASCLL,所以加上30H
        MOV result[SI], AL
        INC SI      ; 现在对第几个随机数赋值
        CMP SI, 8   ; 已经生成了完成了我们需要的随机字符串
        JB doRand; 开始生成下一个随机字符 JB 无符号大于则跳转
        
        MOV CX, 8
        MOV SI, 0
        ToASCLL: ; 目前全部的值都是数字,需要转换成ASCLL码
            ADD result[SI], 30H
            INC SI
            LOOP ToASCLL

        MOV result[SI], 24H ; $的ASCLL码为36, 给字符串末尾加上$
        LEA DX, result
        MOV AH, 9   ; 从DX中读取字符串并输出
        INT 21H 
        
    ;注释掉的部分为测试getRand
    ;--------------------------------------
    ;call getRand

    ;MOV DL, AL
    ;ADD DL, 30H ; 显示ascll码,加30H
    
    ;MOV AH, 02H ; 从DL取出数字显示
    ;INT 21H
    ;--------------------------------------

    MOV AH, 4CH ; 控制权交给终端
    INT 21H 

    
    getRand: ;获取一个随机数,放到AL中
        XOR AL, AL
        MOV AX, 0H
        ; 汇编中使用in/out来访问系统的io空间
        OUT 43H, AL ;将0送到43h端口
        IN AL, 40H  ;将40h端口的数据送到AL寄存器 

        MOV BL, 8   ;除以8,得到范围0-7的余数
        DIV BL      ;商在AL,  余数在AH

        MOV AL, AH  ;
        MOV AH, 0
        INC AL      ; 加1,得到范围1-8

        RET
CODE ENDS
END START
