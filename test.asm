DATAS SEGMENT
    ;此处输入数据段代码
    BUFF DW 5,25,55,115,138,159,196,163,20,255
    DAT  DW 0
    SHOW DB 4 DUP(0),'</p>'
DATAS ENDS
STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    MOV DX,0
    MOV AX,0
    MOV CX,10   ;循环次数设置
    MOV SI,OFFSET BUFF
    lop1:    ;求和
     ADD AX,[SI]
     ADD SI,2  ;由于数据是DW的，所以地址每次加2
    LOOP lop1
    
    MOV CL,10
    DIV CL    ;求平均，AL存储了平均值，AH存储了余数
    ;MOV CL,1000
    MOV AH,0   ;分解for显示,求余得到从个位到千位
    DIV CL
    MOV SHOW+3,AH;
    ADD SHOW+3,48
    ;MOV CL,100
    MOV AH,0
    DIV CL
    MOV SHOW+2,AH;
    ADD SHOW+2,48
    ;MOV CL,10
    MOV AH,0
    DIV CL
    MOV SHOW+1,AH;
    ADD SHOW+1,48
    MOV SHOW+0,AL;
    ADD SHOW+0,48
MOV AH,09H   ;显示输出
    MOV DX,offset SHOW;
    INT 21H
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
