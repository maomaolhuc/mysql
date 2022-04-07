--循环
/*
  LOOP
    要执行的语句
    IF <条件> THEN
      EXIT;   --条件满足，退出循环
    END IF;
  END LOOP;
*/
--第一种
DECLARE
V_NUM NUMBER := 10;
BEGIN
  LOOP
V_NUM := V_NUM -1;
    DBMS_OUTPUT.PUT_LINE('V_NUM :' || V_NUM);
    IF V_NUM < 2 THEN
      DBMS_OUTPUT.PUT_LINE('退出拉~~');
      EXIT;
END IF;
END LOOP;
END;

--第二种
DECLARE
V_NUM NUMBER := 10;
BEGIN
  LOOP
V_NUM :=V_NUM -1;
    DBMS_OUTPUT.PUT_LINE('V_NUM :' || V_NUM);
    EXIT WHEN V_NUM < 2;
    --使用exit when（后面使用的boolean表达式，如果该表达式返回true则退出循环）语句退出loop循环
END LOOP;
END;


--第二种
/*
WHILE <布尔表达式> LOOP
  要执行语句
END LOOP ;
*/
DECLARE
V_NUM NUMBER := 0;
BEGIN
  WHILE V_NUM <20 LOOP
     DBMS_OUTPUT.PUT_LINE('V_NUM :' || V_NUM);
     V_NUM := V_NUM +1;
END LOOP;
END;

/*
FOR 循环计算器  IN 上限..下限 LOOP
  要执行的语句
END LOOP
*/
DECLARE
V_NUM NUMBER :=0;
BEGIN
FOR I IN 2..5 LOOP
    V_NUM := V_NUM +1;
    DBMS_OUTPUT.PUT_LINE('V_NUM :' || V_NUM);
END LOOP;
END;


--使用循环打印一下图形
/*
*
**
***
****
*****
*/
DECLARE
BEGIN
FOR I IN 1..5 LOOP
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT('*');   --不换行输出
END LOOP;
    DBMS_OUTPUT.PUT_LINE('');   --打印完一行之后换行
END LOOP;
END;

--使用for循环打印九九乘法表
DECLARE
BEGIN
FOR I IN 1..9 LOOP
      FOR J IN 1..I LOOP
          DBMS_OUTPUT.PUT(J || '*' || I || '=' || (I*J) || '  ');
END LOOP;
      DBMS_OUTPUT.PUT_LINE('');
END LOOP;
END;


