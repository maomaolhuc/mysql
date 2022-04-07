--PLSQl 编程
--是oracle在标准的sql语言上的扩展
--特点：可以在数据库定义变量，常量，还可以使用条件，判断，循环语句以及异常等等

--PLSQL 程序组成部分
--声明部分， 执行部分 异常处理部分
DECLARE   --声明部分
--在此声明plsql用到的常量，变量，类型
BEGIN   --执行
      --过程及sql语句
EXCEPTION
       --执行异常：错误处理
END;

--1.简单的plsql块
DECLARE   --声明并赋值    变量名  类型   := 值     := 赋值     = 条件判断
V_NUM  NUMBER := 10;    -- 注意点：plsql在声明变量的时候前面加V_代表变量  var
BEGIN    --执行
      V_NUM := V_NUM+1;
      DBMS_OUTPUT.PUT_LINE('NUM：  ' || V_NUM);  -- || 拼接符
END;

--2.声明变量，赋值为员工表中的smith的员工编号
--SELECT ...INTO ...
DECLARE
V_NUM NUMBER;
BEGIN
SELECT EMPNO INTO V_NUM FROM EMP WHERE ENAME ='SMITH';
DBMS_OUTPUT.PUT_LINE('NUM：  ' || V_NUM);
END;

--3 声明变量，变量的类型是scott用户下emp表empno 字段的字段类型   %type
DECLARE
V_NUM SCOTT.EMP.EMPNO%TYPE;
BEGIN
SELECT EMPNO INTO V_NUM FROM EMP WHERE ENAME ='SMITH';
DBMS_OUTPUT.PUT_LINE('NUM：  ' || V_NUM);
END;

--4 取一行数据  %rowtype
DECLARE
V_EMPROW SCOTT.EMP%ROWTYPE;
BEGIN
SELECT * INTO V_EMPROW FROM EMP WHERE ENAME ='SMITH';
DBMS_OUTPUT.PUT_LINE(V_EMPROW.ENAME || V_EMPROW.EMPNO);
END;

--常量
DECLARE
C_PI CONSTANT NUMBER := 3.14159;   --CONSTANT 常量，一旦设定不能更改  命名规范：C_
       V_R NUMBER := 20;
       V_AREA NUMBER;
BEGIN
       V_AREA := C_PI*V_R*V_R;
       DBMS_OUTPUT.PUT_LINE('V_AREA：  ' || V_AREA);
END;


--判断
/*
语法
IF < 条件> then
  语句
[elsif <条件 > then
 语句]
[else
 语句]
end if
*/
--1
DECLARE
V_SCORE NUMBER;
BEGIN
    V_SCORE := '&请输入学生的成绩';
    IF V_SCORE > 90 THEN
        DBMS_OUTPUT.PUT_LINE('奖励个手机');
ELSE
        DBMS_OUTPUT.PUT_LINE('打一顿');
END IF;
END;
--2
DECLARE
V_SCORE_C NUMBER;
     V_SCORE_JAVA NUMBER;
BEGIN
    V_SCORE_C := '&请输入学生C的成绩';
    V_SCORE_JAVA := '&请输入学生JAVA的成绩';

    IF V_SCORE_C >= 90 AND V_SCORE_JAVA >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('奖励个手机');
    ELSIF  V_SCORE_C >= 80 OR V_SCORE_JAVA >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('跪键盘');
ELSE
        DBMS_OUTPUT.PUT_LINE('打一顿');
END IF;
END;

--3 根据月份的值判断该月份所属季节
/*
    冬季：12，1，2
    春季：3，4，5
    夏季：6，7，8
    秋季：9，10，11
*/
DECLARE
V_MONTH NUMBER;
    V_SEASON VARCHAR2(30);
BEGIN
    V_MONTH := '&请输入月份';
    IF V_MONTH =12 OR V_MONTH =1 OR V_MONTH =2 THEN
      V_SEASON := '冬季';
    ELSIF V_MONTH IN (3,4,5) THEN
      V_SEASON := '春季';
    ELSIF V_MONTH BETWEEN 6 AND 8 THEN
      V_SEASON := '夏季';
    ELSIF  V_MONTH IN (9,10,11) THEN
       V_SEASON := '秋季';
ELSE
        V_SEASON := '月份错误';
END IF ;
    DBMS_OUTPUT.PUT_LINE(V_MONTH || '月份是'  ||V_SEASON );
END;

--
DECLARE
V_SCORE NUMBER;
BEGIN
    V_SCORE := '&请输入成绩';
CASE
      WHEN V_SCORE >= 90 THEN  DBMS_OUTPUT.PUT_LINE('奖励个手机');
WHEN V_SCORE >= 80 THEN  DBMS_OUTPUT.PUT_LINE('烤乌龟');
WHEN V_SCORE >= 70 THEN  DBMS_OUTPUT.PUT_LINE('跪键盘');
ELSE   DBMS_OUTPUT.PUT_LINE('打一顿');
END CASE;
END ;












