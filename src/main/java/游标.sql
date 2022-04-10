--游标的自定义属性
--%NOTFOUND
--%FOUND
--%ISOPEN
--%ROWCOUNT 游标的结果集有多少行
--显式游标
--游标
--游标专业术语：是映射在结果集中一行数据上的位置实体
--游标 游动的光标   通俗的话其实就是一个结果集
DECLARE
V_EMP EMP%ROWTYPE;      --声明一个行类型变量
CURSOR C_EMP IS SELECT * FROM EMP;
--定义一个名词是c_emp内容是sql语句结果集的游标
--第一步 定义一个游标
BEGIN
OPEN C_EMP;    --第二步  打开游标
LOOP   --循环游标的结果集
FETCH C_EMP INTO V_EMP;
        --FETCH 游标 INTO 变量   把当前的光标指定的数据库赋值给定义好的行类型变量
        EXIT WHEN C_EMP%NOTFOUND;  --当游标轮询完最后一条记录是 跳出循环
             DBMS_OUTPUT.put_line('V_EMP.EMPNO IS' ||  V_EMP.EMPNO);
END LOOP;

     IF C_EMP%ISOPEN  --判断游标是否打开
       THEN CLOSE C_EMP ;   --关闭游标
END IF ;
END;

---第二个
DECLARE
V_EMP EMP%ROWTYPE;
     V_DEPTNO NUMBER;
CURSOR C_EMP(CV_DEPTNO NUMBER) IS
SELECT * FROM EMP WHERE DEPTNO = CV_DEPTNO;
BEGIN
     V_DEPTNO := '&请输入部门编码';
OPEN C_EMP(V_DEPTNO);
LOOP
FETCH C_EMP INTO V_EMP;
        EXIT WHEN C_EMP%NOTFOUND;
             DBMS_OUTPUT.put_line( V_EMP.DEPTNO || '
              ---V_EMP.EMPNO IS' || V_EMP.EMPNO);
END LOOP;

     IF C_EMP%ISOPEN  --判断游标是否打开
       THEN CLOSE C_EMP ;   --关闭游标
END IF ;
END ;
SELECT * FROM EMP
--隐式游标  delete update insert
--结果集的时候用显式游标   单个数据库操作的时候用隐式游标
DECLARE
BEGIN
UPDATE EMP SET SAL =1 WHERE EMPNO ='7369';
IF SQL%NOTFOUND THEN --sql 是所有隐式游标统一的名字
    DBMS_OUTPUT.put_line('没有找到对应的数据');
  ELSIF SQL%FOUND THEN
     DBMS_OUTPUT.put_line('成功找到并更新');
END IF;
END;

--显式游标，隐式游标都属于静态游标
--动态游标 就是指游标的动态赋值  动态游标无论是定义还是用法都跟静态游标不太一样
--有些特殊情况必须要用动态游标 比如说 当表名，或者列名不固定的时候
--使用Oracle动态游标可以使程序更加简洁
DECLARE
TYPE REF_CUR IS REF CURSOR;   --定义一个动态游标的游标类型
    C_EMP REF_CUR;     --定义一个游标类型为ref_cur的游标
    V_EMP EMP%ROWTYPE;
    V_DEPTNO NUMBER :='&请输入部门编号';
    V_EMPNO NUMBER :='&请输入员工编号';
BEGIN
    --打开游标
OPEN C_EMP FOR 'SELECT * FROM EMP WHERE DEPTNO = :V_DEPTNO AND EMPNO =:V_EMPNO '
    USING V_DEPTNO,V_EMPNO;
LOOP
FETCH C_EMP INTO V_EMP;
      EXIT WHEN C_EMP%NOTFOUND ;
       DBMS_OUTPUT.put_line('V_EMP.EMPNO IS ' || V_EMP.EMPNO);
END LOOP;

     IF C_EMP%ISOPEN  --判断游标是否打开
       THEN CLOSE C_EMP ;   --关闭游标
END IF ;
END;

SELECT * FROM EMP












