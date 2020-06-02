DATA SEGMENT
str db 'Hello World$'    ;要输出的字符串必须要以$结尾
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA    ;将CS和CODE，DS和DATA段建立联系
START: 
       MOV BX,DATA 
       MOV DS,BX
       LEA DX,str 
       MOV AH,9
       INT 21H

       MOV AH,4CH        ;将控制权返回给终端。
       INT 21H
CODE ENDS
END START

