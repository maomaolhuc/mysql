--ORACLE常用命令不需要分号,sql语句需要分号结尾
 --[1]不使用密码登录oracle
 CONN/AS SYSDBA
 
 --[2]给用户设置密码
 ALTER USER SYS IDENTIFIED BY ADMIN;  --将sys的密码设置成admin
 
 --[3]登录后,需要更换登录的用户
 CONN SYS/ADMIN AS SYSDBA
 CONN SCOTT/tiger
 
 --[4]显示当前登录用户
 SHOW USER
 
 --[5]账户锁定和解锁;
 ALTER USER SCOTT ACCOUNT LOCK;   --锁定
 ALTER USER SCOTT ACCOUNT UNLOCk;   --解锁
 
 --学习用到的表,(emp-员工表 ,DEPT-部门表,SALGRADE-工资等级表,BONUS-津贴(未选定行))
 --[1]当前用户下的所有表名称
 SELECT TABLE_NAME FROM USER_TABLES;
 
 --[2]显示表结构
 DESC EMP;
 
 --[3]查看表中信息
 SELECT * FROM 表名;
 


--基本查询部分  
--[1] 查询员工表中的行和列
--查询员工表中的数据     SELECT * FROM 表名;
SELECT * FROM EMP;   

--[2]查询部分列    SELECT 列名1,列名2....from 表名    查询出的结果称之为结果集
--查询员工表中员工的编号和姓名  
SELECT EMPNO,ENAME FROM EMP;       

--[3]查询部分行和列    WHERE 
--查询部门编号为20的员工的编号和姓名   
SELECT EMPNO ,ENAME ,DEPTNO FROM EMP 
WHERE  DEPTNO = 20;

--查询部门编号为20的员工的编号和姓名并且这个人的工资大于1500   and or not
SELECT EMPNO ,ENAME ,DEPTNO,SAL FROM EMP 
WHERE  DEPTNO = 20
AND SAL>1500;

--[4]可以在查询的结果中使用别名(中文)   两种方式
AS:
SELECT * FROM EMP;
SELECT EMPNO AS 员工编号,ENAME AS 姓名,DEPTNO AS 部门编号,SAL AS 工资 FROM EMP
WHERE DEPTNO=20
AND SAL>1500;

--空格
SELECT EMPNO 员工编号,ENAME 姓名,DEPTNO 部门编号,SAL 工资 
FROM EMP
WHERE DEPTNO=20
AND SAL>1500;

--[5]查询津贴不为空 is null
--查询津贴为null的员工的工号,姓名,工资,津贴
SELECT EMPNO,ENAME,SAL,COMM
FROM EMP
WHERE COMM IS NOT NULL;

--[6]在查询结果(结果集)中使用常量
SELECT ENAME,SAL,'潭州' 工作单位 
FROM EMP;

--[7]查询限制行数 rownum叫做伪列
--查询员工表前五条数据
SELECT * FROM EMP
WHERE ROWNUM <=5;

--[8]给表命名 使用空格
SELECT ROWNUM,E.EMPNO
FROM EMP E
WHERE ROWNUM <=5;

--sql不分大小写
--查询名为smith的员工信息
SELECT *FROM EMP WHERE ENAME='SMITH';--SMITH要大写

--查询(二)
--对查询结果进行排序ORDER BY(ASC 升序，DESC降序)
--查询员工的工号,姓名,工资并按照工资升序排序
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL ASC;

SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL DESC;
 
 SELECT EMPNO,ENAME,SAL
 FROM EMP
 ORDER BY SAL;
 
 --[按照入职时间来升序]
 SELECT * FROM EMP;
 
 SELECT ENAME,HIREDATE
 FROM EMP
 ORDER BY HIREDATE;
 
 --按照部门编号
 --[]查询员工的姓名,部门编号,按照部门编号升序,如果编号一致按照入职时间降序
 SELECT ENAME,DEPTNO,HIREDATE
 FROM EMP
 ORDER BY DEPTNO ASC,HIREDATE DESC;
 
 --查询工资大于1500的员工的信息 对部门编号降序排序
 SELECT ENAME,EMPNO,DEPTNO,HIREDATE,SAL
 FROM EMP
 WHERE SAL>1500
 ORDER BY DEPTNO ASC;
 
 
 --使用列的别名进行排序
 --按员工的年薪排序
 SELECT EMPNO,ENAME,SAL*12 年薪
 FROM EMP
 ORDER BY 年薪;
 
 --模糊查询 like  between in(查询结果不确定)  
 --[1]like通常是和字符型一起使用 通配图:%,_
 --查询以s开头的员工信息
 SELECT *
 FROM EMP
 WHERE ENAME 
 LIKE 'S%'--代表任意多个字符,可以是0也可以是多个
 
 --查询第二字是A的员工信息
 SELECT *
 FROM EMP
 WHERE ENAME
 LIKE'_A%'
 
 SELECT *
 FROM EMP
 WHERE ENAME
 LIKE'%A%'
 
 --between ...and...>=and<=代表着一个范围 和数值型一起使用
 SELECT *
 FROM EMP
 WHERE SAL>=1500
 AND SAL<=3000;
 
 SELECT *
 FROM EMP
 WHERE SAL BETWEEN 1500 AND 3000;
 
 SELECT *
 FROM EMP
 WHERE HIREDATE BETWEEN '01-1月-81'AND '31-1月-87';
 
 --in在指定的值中进行匹配 相当于或者
 --查询经理的编号7902,7698,7788,7782
 SELECT *
 FROM EMP
 WHERE MGR=7902
OR MGR=7698
OR MGR=7788;
 
 SELECT *
 FROM EMP
 WHERE MGR  
 IN(7902,7698,7788,7782);
 
 
 --连接运算符||相当于java中的+号
 SELECT EMPNO ||'的员工的姓名是'||ENAME
 AS 员工
 FROM EMP;
 
Distinct --去重

SELECT DISTINCT DEPTNO
FROM EMP;

--函数相当于java中的方法
--[1]首字母大些 INITCAP()
--对表中名字的首字母大写
SELECT * FROM EMP;
SELECT INITCAP(ENAME) FROM EMP;

--[2]转大小写LOWER(),UPPER();
SELECT LOWER(JOB) FROM EMP;--转小写
SELECT UPPER(' he llo ') FROM DUAL;--伪列

--[3]去掉左右空格TRIM()
SELECT TRIM(' he llo ')FROM DUAL;

--[4]字符串的长度LENGTH()
SELECT LENGTH(ENAME) FROM EMP;

--题：先去掉左右空格,然后再求字符串的长度
SELECT LENGTH(TRIM(' he llo ')) FROM DUAL;

--[5]左剪裁LTRIM
SELECT LTRIM('HELLO','HEL')FROM DUAL;--第二值是放剪掉的内容,若内容不正确不剪裁

--[6]右剪裁RTRIM()
SELECT RTRIM('HELLO','LLO')FROM DUAL;

--[7]替换REPLACE();
SELECT REPLACE('HELLOWORLD','O','你好')FROM DUAL;

--[8]查找字符位置 INSTR()
SELECT INSTR('HELLOWORLD','O') FROM DUAL;--查找的是目标值第一次出现的位置

--[9]字符串截取 SUBSTR();
SELECT SUBSTR('HELLOWORLD',2)FROM DUAL;--从2开始一直到结尾(截取的值包含开头不包含结尾)
SELECT SUBSTR('HELLOWORLD',2,4)FROM DUAL;--2:开始截取,4:是截取的长度

--[10]字符串连接CONCAT();
SELECT CONCAT('HELLO','WWWWW')FROM DUAL;

SELECT'HELLO'||'WWWWW' FROM DUAL;
SELECT 'HELLO'+'WWWW' FROM DUAL;--无效
SELECT 10+20 FROM DUAL;



--数值形函数
--[1]绝对值 ABS();
SELECT ABS(-15) FROM DUAL;

--[2]向上取整CEIL();
SELECT CEIL(10.0001)FROM DUAL;
--[3]向下取整 FLOOR();
SELECT FLOOR(10.99999)FROM DUAL;
--[4]次方次幂POWER()
SELECT POWER(2,3) FROM DUAL;--(第一个数的第二数的次幂)

--[5]四舍五入ROUND()
SELECT ROUND(34.7837948502,2) FROM DUAL;--第二个值控制小数点的位数

--[6]开平方SQRT
SELECT SQRT(9) FROM DUAL;

--日期型函数
--[1]系统当前时间
SELECT SYSDATE FROM DUAL;

--[2]两个日期之间的月份差MONTHS_BETWEEN(当前系统时间,'指定的日期')
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE,'01-1月-18'))FROM DUAL;

--[3]返回指定月数后的日期ADD_MONTFS(当前日期,指定的月份)
SELECT ADD_MONTHS(SYSDATE,2)FROM DUAL;

--题:求SMITH入职多少年?
SELECT (SYSDATE-HIREDATE)/365 FROM EMP WHERE ENAME='SMITH';

--[4]返回当前日期的下周某一天的日期 NEXT_DAY(当前日期,'下个星期的星期数')
SELECT NEXT_DAY(SYSDATE,'星期一')FROM DUAL;
--[5]返回指定月份的最后一天 LAST_DAY(SYSDATE);
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--题:求倒数第二天入职员工信息
SELECT LAST_DAY(HIREDATE)-1 FROM EMP;


--转换函数
--将日期或数据转换为char数据类型
--[1]to_char(date,format);--将日期转为字符串
SELECT TO_CHAR(SYSDATE,'yyyy-MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'yyyy-MM-DD HH24:MI:SS')FROM DUAL;

--题:查询员工表中员工的入职年份
SELECT TO_CHAR(HIREDATE,'yyyy') FROM EMP;

--[2]to_char(num,format)
SELECT TO_CHAR(100.10,'9999.9999')FROM DUAL;--9:代表一位数字,如果该位没有数字不显示,但小数点后面的仍会强制显示
SELECT TO_CHAR(100.10,'0000.0000')FROM DUAL;--代表一位数字，该位没有数字则强制显示

--$符
SELECT TO_CHAR(100.0,'$9999.999')FROM DUAL;

--[3]to_date--字符串转换为日期型
SELECT TO_DATE('2018-01-01','yyyy-MM-DD')FROM DUAL;

--[4]to-number--字符串转为数值型
SELECT TO_NUMBER('12344.99','99999.9999')FROM DUAL;

--其他函数 相当于if..else
--[1]NVL(EXP1,EXP2) 如果exp1的值为null,则返回exp2的值,否则返回exp1的值

--计算员工工资
SELECT EMPNO,ENAME,SAL+COMM FROM EMP;

SELECT EMPNO,ENAME,SAL+NVL(COMM,0)FROM EMP;




--DML(数据库操作语言)inert(插入) update(修改)delete(删除)
--insert:往表中插入数据,
          --两种方式:
                 --一种是记录值的插入
                 --一种是查询结果的插入
                 
--记录值的插入
--INSERT INTO 表明(列名1,列名2……)
--[1]一次插入一行(条)数据
    INSERT INTO DEPT(DEPTNO,DNAME,LOC)
    VALUES(50,'教育部','北京');
    
    --注意事项
            --要求数值类型完全一致,结果为受影响的行数
            --在oracle中对表中数据进行操作后需要回滚(rollback)或者提交(commit)
    SELECT * FROM DEPT;
    
    ROLLBACK;
    COMMIT;
    
--[2]向表中全部列插入数据,注意:列名可省略,但要求值的顺序必须和表中列的顺序完全一致
      INSERT INTO DEPT VALUES(60,'城管','长沙');
      
--[3]向表中部分列插入数据,要求非空列必须插入值 注意:部分列的时候,列名必须写 
     INSERT INTO DEPT(DEPTNO,DNAME) VALUES(80,'AAA');     
    

--查询结果的插入
--一次插入多行数据(将查询的结果插入到表中) --备份
--[1]新表不存在 -->创建一个表
     CREATE TABLE EMP1
     AS
     SELECT * FROM EMP;--只能执行一次
     
     SELECT * FROM EMP1;
    
--只要表结构,不要数据
CREATE TABLE EMP2
AS
  SELECT * FROM EMP
  WHERE 1>2; --当条件不成立的时候只复制表结构  只能执行一次
  
  SELECT * FROM EMP2;
  
  --创建表emp3,有两个列,数据从emp表中来
  CREATE TABLE EMP3(编号,姓名)
  AS
  SELECT EMPNO,ENAME FROM EMP;
  
  SELECT * FROM EMP3;
  
  --[2]新表存在
    INSERT INTO EMP2 SELECT * FROM EMP
        --可以执行多次,数据叠加
    SELECT * FROM EMP2;
    
    
    --update (更改) update表名set列名1=值1,列名2=值2……[where]
             --[1]将表中的全部数据进行更改
             UPDATE DEPT SET LOC='北京'; --无条件修改表中数据
             SELECT * FROM DEPT;
             
             --[2]带条件修改
             UPDATE DEPT SET DNAME='XUEXI部',LOC='上海'
             WHERE DEPTNO=50;
             
--delete(删除)delete[from]表名…[where]
--delete 删除,删除表中的数据,可带条件(where)
      --[1]无条件删除
        DELETE EMP2; 
        SELECT * FROM EMP2;
      --[2]带条件删除
         DELETE DEPT
         WHERE DEPTNO=50;                  
         SELECT * FROM DEPT;
              --注意事项:delete后只跟表名,不允许跟列名,一次删除一整行数据,不允许删除列
        
      TRUNCATE TABLE EMP1;--不能回滚
      
  -- 删除表
  DROP TABLE EMP1;
  DROP TABLE EMP2;
  DROP TABLE EMP3;
  
  --小结:
      --[1]select…from… [where]…[group by]…[having]…[order by]…
      --[2]insert into表明(列名1,列名2)values (值1,值2…)
      --[3]create table新表名as select列名1,……from表名->只能执行一次,要求新表不能存在
           --insert into新表名select列名…from 表名-->可执行多次,要求新表必须存在
      --[4]update 表名 set 列名1=值1,列名2=值2[where]…
      --[5]delete 表名[where]… --删除数据
             --TRUNCATE TABLE 表名;--删除数据,不能回滚
             --drop table表名    --删除表
             
             
             
             
  --多表连接查询92
  
  --[1]笛卡尔积现象
  SELECT * FROM EMP;
  SELECT * FROM DEPT;
  SELECT * FROM EMP,DEPT;
  --等值查询
  --查询名称为SMITH的员工编号,姓名,部门名称,
  SELECT EMPNO,ENAME,DNAME
  FROM EMP,DEPT
  WHERE ENAME='SMITH'
  AND EMP.DEPTNO=DEPT.DEPTNO;
  
    
  --查询所有的员工编号,姓名,部门名称
  SELECT EMPNO,ENAME,DNAME
  FROM EMP,DEPT
  WHERE EMP.DEPTNO=DEPT.DEPTNO;
    
  
  
  --select表名1.列名1,表名2.列名1,表名2.列名2…from表名1,表名2
  --where表名1.列名=表名2.列名;
    -- 在多表连接查询时,建议大家给表起名
    --查询部门编号为10的员工姓名,员工的工资，部门所在地,并按照工资降序排序
  SELECT E.ENAME,E.SAL,D.LOC
  FROM EMP E,DEPT D
  WHERE E.DEPTNO=10
  AND E.DEPTNO=D.DEPTNO
  ORDER BY E.SAL DESC;
  
  
  
  --非等值查询(两个表之间没有直接关系)
  --查询SMITH的工资等级 
  SELECT E.EMPNO,E.ENAME,E.SAL,S.LOSAL,S.HISAL,S.GRADE
  FROM EMP E,SALGRADE S
  WHERE E.ENAME='SMITH'
  AND E.SAL>=S.LOSAL
  AND E.SAL<=S.HISAL;  
  
  --查询员工的工资等级
  SELECT E.EMPNO,E.ENAME,E.SAL,S.LOSAL,S.HISAL,S.GRADE
  FROM EMP E,SALGRADE S
  WHERE  E.SAL>=S.LOSAL
  AND E.SAL<=S.HISAL;  --区间
  
  --查询所有"MANAGER"的工资等级,并按工资进行升序排序  
  SELECT E.EMPNO,E.ENAME,E.SAL,S.LOSAL,S.HISAL,S.GRADE,E.JOB
  FROM EMP E,SALGRADE S
  WHERE  E.SAL>=S.LOSAL
  AND E.SAL<=S.HISAL
  AND E.JOB='MANAGER'
  ORDER BY E.SAL;
  
       --等值查询与非等值查询的两张表,是平级关系
       
--外连接查询(主次关系)
--查询员工的编号,姓名,部门名称,部门编号
     SElECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
     FROM EMP E,DEPT D
     WHERE  E.DEPTNO=D.DEPTNO;     
 --左外连接,以"="左边的表为主表,--将显示左边表的全部信息(包括等值,不相等的)
     SELECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
     FROM EMP E,DEPT D
     WHERE E.DEPTNO=D.DEPTNO(+); 
 
 --右外连接
 --右外连接,以"="右边的表为主表,--将显示右边的全部信息(包括等值,不相等的)
     SELECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
     FROM EMP E,DEPT D
     WHERE E.DEPTNO(+)=D.DEPTNO;
 
 
 --自连接(自己连接自己) 一个表当两个表使用
 --查询员工的编号,员工的姓名,员工的经理的姓名(没有经理的员工)
    SELECT E.EMPNO,E.ENAME,M.ENAME
    FROM EMP E,EMP M
    WHERE E.MGR=M.EMPNO;


--92语法规则缺点:
   --语句的过滤条件和连接条件都放到了where语句中
   --当条件过多时，连接条件多，过滤条件多，就容易造成混淆
   

--sql99标准
   --修正了整个缺点,连接条件和过滤条件分开，连接使用on过滤条件使用where
   
   --交叉连接(cross join)
   SELECT * FROM EMP,DEPT;--92标准
   SELECT * FROM EMP CROSS JOIN DEPT;--99标准
   
   
   --自然连接 (natural join)(类似于等值连接)
   --查询员工的编号,姓名,部门名称
   SELECT E.EMPNO,E.ENAME,D.DNAME
   FROM EMP E,DEPT D
   WHERE E.DEPTNO=D.DEPTNO;
   
   
   SELECT E.EMPNO,E.ENAME,D.DNAME
   FROM EMP E NATURAL JOIN DEPT D
   WHERE DEPTNO=DEPTNO;--条件不能使用限定词
   
   SELECT E.EMPNO,E.ENAME,D.DNAME,DEPTNO
   FROM EMP E NATURAL JOIN DEPT D
   WHERE DEPTNO=10;--99
  
     --using子句:当相连的表中出现很多同名列,自然连接将无法满足要求,可以在连接时使用using子句来设置用于等值连接列名
   SELECT E.EMPNO,E.ENAME,D.DNAME,DEPTNO
   FROM EMP E NATURAL JOIN DEPT D
   USING(DEPTNO)--USING来指定要使用哪一个同名列进行连接
   WHERE DEPTNO=10;
   
   --on子句  进行多连接(inner join 内连接,inner可以省略)
   --查询部门编号为10的员工编号,姓名,部门名称
   SELECT E.EMPNO,E.ENAME,D.DNAME
   FROM EMP E  JOIN DEPT D
   ON E.DEPTNO=D.DEPTNO--连接条件
   WHERE D.DEPTNO=10;
   
   
   --三个表连接:
   SELECT E.姓名,D.名称,C.城市
   FROM 员工表 E
   INNER JOIN 部门表 D
   ON E.部门编号=D.部门编号
   INNER JOIN 城市表 C
   ON D.城市编号=C.城市编号
   WHERE E.姓名='张三';
   --外连接
   --[1]左外连接
   --查询员工的编号,姓名,部门名称,部门号
   SELECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
   FROM EMP E LEFT JOIN DEPT D
   ON E.DEPTNO=D.DEPTNO;
   --[2]右外连接
   SELECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
   FROM EMP E RIGHT JOIN DEPT D
   ON E.DEPTNO=D.DEPTNO;
   
   --[3]全外连接
   SELECT E.EMPNO,E.ENAME,D.DNAME,D.DEPTNO
   FROM EMP E FULL JOIN DEPT D
   ON E.DEPTNO=D.DEPTNO;
   
   
   
--子查询 (单行子查询,多行子查询)
--查询比"CLARK" 工资高的员工的信息
  --[1]'CLARK'的工资是多少
  SELECT SAL FROM EMP WHERE ENAME='CLARK';--2450
  
  --[2]比2450高的员工信息
  SELECT * FROM EMP WHERE SAL>2450;
   

--子查询:
     --将一个查询的结果作为另一个查询的条件来使用
     SELECT * FROM EMP WHERE SAL>( SELECT SAL FROM EMP WHERE ENAME='CLARK');
     
  
         语法:
             SELECT 字段列名 FROM 表名
             WHERE 条件 比较符(SELECT * FROM 表名);
             
          --特点:
              --子查询在主查询前执行
              --主查询使用子查询的结果
             
   --[1]子查询可以作为另外的一个查询的条件来使用
         --查询工资高于平均工资的雇员的名字和工资
            --[1]平均工资 
            SELECT AVG(SAL) FROM EMP;
            
            SELECT ENAME,SAL
            FROM EMP
            WHERE SAL>(SELECT AVG(SAL) FROM EMP)
            ORDER BY SAL;
         --查询和SCOTT同一部门且比他工资低的雇员的名字和工资
             --'SCOTT'在哪个部门?
             SELECT DEPTNO FROM EMP WHERE ENAME='SCOTT';
             --'SCOTT' 的工资
             SELECT SAL FROM EMP WHERE ENAME='SCOTT';
             
             SELECT ENAME,SAL
             FROM EMP
             WHERE DEPTNO=(SELECT DEPTNO FROM EMP WHERE ENAME='SCOTT')
             AND  SAL<(SELECT SAL FROM EMP WHERE ENAME='SCOTT');
          --注意：子查询的字段不能多于一个,只能有一个
   --[2]子查询可以作为insert语句的值来使用
         --今天新入职一个员工,与'SCOTT'同一部门
         INSERT INTO EMP(EMPNO,ENAME,DEPTNO,HIREDATE)
         VALUES(1001,'马上成功',(SELECT DEPTNO FROM EMP WHERE ENAME='SCOTT'),SYSDATE);
         
         SELECT * FROM EMP;
         
         
  --[3]子查询可以作为update的条件或修改的值来使用
      --将'新员工'的工作改为与'SMITH'的工作相同
      --[1]smith的工作
      SELECT JOB FROM EMP WHERE ENAME='SMITH';
      
      UPDATE EMP SET JOB=(SELECT JOB FROM EMP WHERE ENAME='SMITH') WHERE ENAME='马上成功';
      --将比FORD工资低的员工加1000块       
      --[1]'FORD' 的工资是
      SELECT SAL FROM EMP WHERE ENAME='FORD';
      
      UPDATE EMP SET SAL=SAL+1000
      WHERE  SAL<( SELECT SAL FROM EMP WHERE ENAME='FORD');
      SELECT * FROM EMP;
  --[4]子查询可以作为delete的条件使用 
       --比FORD工资高的都删除
       DELETE EMP
       WHERE SAL>( SELECT SAL FROM EMP WHERE ENAME='FORD'); 
        
   --[5]子查询的结果可以作为一个表来使用
        SELECT EMPNO AS 经理编号,ENAME 经理姓名 FROM EMP;
       --查询员工的编号,姓名,经理姓名 
         
       SELECT E.EMPNO 员工编号,E.ENAME 员工姓名,M.经理姓名
       FROM EMP E,( SELECT EMPNO AS 经理编号,ENAME 经理姓名 FROM EMP) M
       WHERE E.MGR=M.经理编号(+);--92标准
         
       SELECT E.EMPNO 员工编号,E.ENAME 员工姓名,M.经理姓名
       FROM EMP E LEFT JOIN( SELECT EMPNO AS 经理编号,ENAME 经理姓名 FROM EMP) M
       ON E.MGR=M.经理编号;--99标准   
  
 
--多行子查询
--子查询的结果返回是多行数据
      --all: 和子查询返回的所有值比较
      --any:和子查询返回的任意一个值比较
      --in:等于列表中的任何一个
      
 --查询工资低于任何一个"CLERK"岗位的工资的雇员信息。
    --查询 CLERK这个职位的工资是多少?
    SELECT SAL FROM EMP WHERE JOB='CLERK';  
    
    SELECT MAX(SAL) FROM EMP WHERE JOB='CLERK';
    
    SELECT * FROM EMP WHERE SAL<( SELECT MAX(SAL) FROM EMP WHERE JOB='CLERK');
         
    SELECT * FROM EMP;
    
    SELECT * FROM EMP WHERE SAL<ANY (SELECT SAL FROM EMP WHERE JOB='CLERK'); 
    
    --查询工资比所有的'SALESMAN'职位都高的雇员的编号,名字和工资
    --[1]'SALESMAN'工资都是多少?
    SELECT SAL FROM EMP WHERE JOB='SALESMAN';
    
    SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>ALL(  SELECT SAL FROM EMP WHERE JOB='SALESMAN');
    
    --查询部门20中的职务与部门10的雇员一样的雇员信息
    --[1]部门10是什么职务
    SELECT JOB FROM EMP WHERE DEPTNO=10;
    
    SELECT * FROM EMP WHERE JOB IN(SELECT JOB FROM EMP WHERE DEPTNO=10)
    AND DEPTNO=20;
    
    
    --查询在雇员中哪些人是经理人
    --查询经理人的编号
    
    --查询每个部门平均薪水的等级
    
    SELECT * FROM EMP;
    SELECT * FROM DEPT;
    
  --小结:
      [1]多表连接查询--92标准
      --等值连接查询 -->两个表之间,存在主外键关系
      --非等值连接   -->两个表之间没有之间关系 >=,<=……
      --以上两种查询,参与查询的表是平级关系
      
      
      -- 左外连接,右外连接 --参与查询的两个表之间有主次之分
      
      
      --[2]多表连接查询--99标准
      --交叉连接 croos join -->笛卡尔积
      --自然连接 natural join-->相当于等值连接(前提是两个参与表中有同名列,类型完全一致)
      --using连接  -->参与查询的两个表中有多个同名列,使用using制定使用特定的列进行连接
      --inner join…on…where…  -->等值连接
      --左外连接 left join
      --右外连接 right join
      --全连接  full join
      
      
      --[3]单行子查询
      --子查询的结果是单行单列
      --使用>=,<=,=,<,>,<>进行where后的条件判断
      
      
      --[4]多行子查询
      --子查询的结果是多行单列
      --使用any:任意一个,all(全部的),in(等值)
      
      
      
      

DQL:数据库查询语言:SELECT
DML:数据库操作语言:INSERT UPDATE DELETE
DDL:数据库定义语言:CREATE DROP

--创建一个用户  --scott:Oracle给我们用来学习的用户,sys:超级管理员,system:管理员用户
CREATE USER DEF IDENTIFIED BY ABC; --使用scott登录时,创建不了其他用户 原因:权限不足

--给用户赋予一些权限 --权限是指执行特定类型的sql命令或访问其他对象的权利
GRANT CONNECT TO ABC;--CONNECT:临时用户

--给scott赋予DBA的角色  --角色是具有名称的一组权限的组合
GRANT DBA TO SCOTT;

--撤销权限
REVOKE CONNECT FROM ABC;

--删除一个用户
 DROP USER DEF;
 
 --常用的系统预定义角色
 connect:临时用户
 RESOURCE:更改为可靠和正式的用户
 DBA:数据库管理员角色, 拥有管理数据的最高权限
 
 
 
 
 /*
 
 
 标准的建表语法
   CREATE TABLE 表名
   (列名 数据类型[默认表达式]……
   );
   
   说明:
    1.在创建新表时,指定的表明必须不存在,否则会出错
    2.使用值:当插入行时如果不给出值,dbms将自动采用默认值  dbms数据库管理系统
    3.在使用create语句创建基本表示时,最初只是一个空的框架,用户可以使用insert命令把数据插入表中
    
  数据库表字段的数据类型
      字符数据类型
      
          CHAR:存储固定长度的字符
          VARCHAR2:存储可变长度的字符串
          
      数值数据类型
         NUMBER:存储整形数和浮点数,格式为NUMBER(p,s)
             列名 NUMBER
             列名 NUMBER(p)     {整数}    number(10) zhengshu
             列名 NUMBER(p,s)    {浮点数}  number(5,3) 11.111
         
       日期时间数据类型
           DATE:存储日期和时间数据
           TIMESTAMP:比DATE 更精确
           
       LOB数据类型
           BLOB:存储二进制对象,如图像、音频和视频文件
           CLOB:存储字符格式的大型对象     
           
           
           */
           
      --创建表
     CREATE TABLE STUDENT(
          SNO NUMBER(6),
          SNAME VARCHAR2(20),
          SEX VARCHAR2(2),
          AGE NUMBER(3),
          ENTERDATE DATE,
          CLAZZ VARCHAR2(10)
         
      );   
      
  -- EMAIL VARCHAR2(20)    
      SELECT * FROM STUDENT;

      
--插入数据 
   INSERT INTO STUDENT VALUES(1001,'羽毛','男',10,sysdate,'01级02班');
   INSERT INTO STUDENT (SNO,SEX,AGE)VALUES(1001,'男',-100);
--向已有表中添加一个列()
ALTER  TABLE STUDENT ADD ADDRESS VARCHAR2(20);

--以下代码要求表中没有数据,因为如果表中存在数据,那么已存在的数据列email将使用null填充
ALTER TABLE STUDENT ADD EMAIL VARCHAR(20) NOT NULL;

--插入数据sno,sname,email
INSERT INTO StUDENT(SNO,SNAME)VALUES(110,'缺一个');

--将已有表中列删除 column--列 table-表
ALTER TABLE STUDENT
DROP COLUMN EMAIL;

--将以有表中的列进行修改,默认只对新添加的数据起作用 modify
ALTER TABLE STUDENT
MODIFY (SEX VARCHAR2(4) DEFAULT'男');

--对已有表中的列名重命名
ALTER TABLE STUDENT
RENAME COLUMN SNAME TO STU_NAME;

--给表重命名
RENAME STUDENT TO STU;

SELECT * FROM STU;

DROP TABLE STUDENT;
DROP TABLE STU;

--小结

    --insert-->向已有表中插入数据 -->操作数据
    --add -->向表中添加列-->操作的表结构
    
    --update-->对已有表中的数据进行修改
    --modify-->修改表中的列
    
    --delete-->删除表中的数据
    -->drop-->删除表

   


/*
数据完整性约束
    1.表的数据有一定的取值范围和联系,多表之间的数据有时也有一定的参照关系。
    2.在创建表和修改表时,可通过定义约束条件来保证数据的完整性和一致性。
    3.约束条件是一些规则,在对数据进行插入、删除和修改时要对这些规则进行验证,从而起到约束作用。

完整性约束分类
     域完整性约束(非空not null,检查check)字段约束
     实体完整性约束(唯一unique,主键primary key)行和行之间的约束
     参照(引用)完整性约束(外键foreign key)表和表之间的约束
     
     
     
     主键约束(primary key)   PK_表名_字段名
             要求主键类数据唯一,并且不允许为空,主键可以包含表的一列或多列，多列组成的主键称之为-复合键
     唯一约束(unique)        UK_表名_字段名
             要求该列值唯一,允许为空,而且null可以是多个
             
     检查约束(check)         CK_表名_字段名
             某列取值范围显示,格式限制等,如年龄约束,邮件限制email'%@%' ..length(pwd)=6
     非空约束(not null)      NN_表名_字段名
             某列内容(值)不为空
     外键约束(foreign key)   FK_表名_字段名
             用于两个表之间建立关系,需要指定引用主表的那列,外键通常是用来约束两个表之间的数据关系
             定义外键的那张表称之为子表,另一张表称之为主表,在表的创建过程中,应该先创建主表,后创建子表  
        
     
     */  
     
--创建表时创建约束
     CREATE TABLE STU(
     STUNO NUMBER(3) CONSTRAINT PK_STU_ID PRIMARY KEY,--学号 长度为3 为主键约束,约束名是PK_STU_ID
     STUNAME VARCHAR2(20) NOT NULL --名字不为空
     
     );
SELECT * FROM STU;

--向表中添加数据
INSERT INTO STU
VALUES(101,'GUFAN');

--查看用户下表
SELECT TABLE_NAME FROM USER_TABLES;

--查看表中的约束
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME='STU';
 
DROP TABLE STU; 

--先创建表,然后再修改表,添加约束
CREATE TABLE STU(
    STUNO NUMBER(3),
    STUNAME VARCHAR2(20)
);

--添加约束
ALTER TABLE STU ADD CONSTRAINT PK_STU_STUNO PRIMARY KEY(STUNO);


ALTER TABLE STU ADD CONSTRAINT PK_STU_STUNO PRIMARY KEY(STUNO,STUNAME);


--复合主键添加数据
INSERT INTO STU VALUES(101,'功守道');
INSERT INTO STU VALUES(101,'孤帆');
INSERT INTO STU VALUES(102,'功守道');

DROP TABLE STU;
  
SELECT * FROM EMP;
SELECT * FROM DEPT;



--主键,唯一,非空,检查 

CREATE TABLE STUDENT(
    STUNO NUMBER(4) CONSTRAINT PK_STU_STUNO PRIMARY KEY,
    SNAME VARCHAR2(10) CONSTRAINT NN_STU_STUNAME NOT NULL,
    SEX VARCHAR2(3) DEFAULT '男',
    AGE NUMBER(3) CONSTRAINT CK_STU_AGE CHECK (AGE BETWEEN 18 AND 30),
    EMAIL VARCHAR(20) CONSTRAINT CK_STU_EMAIL CHECK(EMAIL LIKE '%@%'),
    PSWD VARCHAR(10) CONSTRAINT CK_STU_PSWD CHECK(LENGTH(PSWD)>=6),
    CLAZZ NUMBER(2)
);

SELECT * FROM STUDENT;
    
--查看约束
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE  TABLE_NAME='STUDENT';


--性别没有限定值
ALTER TABLE STUDENT
ADD CONSTRAINT CK_STU_SEX CHECK(SEX='男'OR SEX='女');


--邮箱没有唯一约束
ALTER TABLE STUDENT
ADD CONSTRAINT UN_STU_EMAIL UNIQUE(EMAIL);


--测试数据
INSERT INTO STUDENT
VALUES(1002,'马上成功',DEFAULT,30,'abcd@','1111111',1);

--写约束的时候,写上约束名,一旦执行插入数据时,能很快的定位

--添加班级的外键
ALTER TABLE STUDENT
ADD CONSTRAINT FK_STUDENT_CLASSID
FOREIGN KEY (CLAZZ) REFERENCES GRADE(GREADEID);

--外键约束:
    --表与表之间的约束,两个表之间的关系
   
DROP TABLE STUDENT;


 CREATE TABLE GRADE(
      GREADEID NUMBER(2) CONSTRAINT PK_GRADEID PRIMARY KEY,
      GREADENAME VARCHAR2(20) NOT NULL
);

DROP TABLE GRADE;

INSERT INTO GRADE VALUES(1,'101');

SELECT * FROM STUDENT;
SELECT * FROM GRADE;

INSERT INTO STUDENT
VALUES(1004,'马上成功',DEFAULT,19,'abdS@','1111111',1);

INSERT INTO STUDENT
VALUES(1005,'马上成功',DEFAULT,19,'abdD@','1111111',1);

INSERT INTO STUDENT
VALUES(1006,'马上成功',DEFAULT,19,'abdF@','1111111',1);





--索引
--类似于字典和课本目录,是为了加快对数据的搜索速度而设立的,有自己专门的存储空间,和表是独立存放的.
--采用B树结构 平衡树,数据全部集中在子节点

--索引就是可以建立类似目录的数据对象,实现数据库的快速查询

--索引
     --[1]自动创建  -->主键和唯一键
     --[2]手动创建  
     
    
     索引的缺点:索引是需要单独存放的,占用空间
         -->增,删,改 效率低 update
         
         -->经常查询的列创建索引
     
--查看表名
    SELECT TABLE_NAME FROM USER_TABLES;
    SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE…;
    SELECT INDEX_NAME FROM USER_INDEXES;
    SELECT VIEW_NAME FROM USER_VIEWS;
    
--为薪资列添加索引
CREATE INDEX INDEX_SAL ON EMP(SAL DESC);--在用户撤销他之前不会用到该索引的名字,但是索引在用户查询是会自动起作用
SELECT * FROM EMP WHERE SAL>1500 ORDER BY SAL DESC;

--删除索引
DROP INDEX INDEX_SAL;


--视图:为不同的人呈现不同的数据

--创建视图
CREATE VIEW VI_EMP
AS
SELECT EMPNO,ENAME,JOB,MGR FROM EMP;--只是存放了视图的定义,也就是他放的查询语句,
                                    --在这条sql运行的时候动态去检索数据的查询语句,并不是存放视图的数据

--只读
CREATE OR REPLACE VIEW VI_DEPT
AS 
SELECT * FROM DEPT
WITH READ ONLY;



--查看视图
SELECT * FROM VI_EMP;


--创建dept视图 
CREATE VIEW VI_DEPT
AS
SELECT * FROM DEPT;


--向视图中插入一条数据
INSERT INTO VI_DEPT
VALUES (50,'IT','SHANGHAI');--视图就是一个虚拟的表,视图中的数据是从事实存在的基本表中来,
                            --当对视图执行增删改的操作时,实际上是对基本表执行增删改的操作

SELECT * FROM VI_DEPT;

SELECT * FROM DEPT;


--删除视图
DROP VIEW VI_DEPT;



--plsql编程
--是Oracle在标准的sql语言上的拓展
--特点:可以在数据库定义变量,常量,还可以使用条件语句和判断语句及异常符等.

PLSQL程序组成部分:
    声明部分,执行部分,异常处理部分
    
    
    DECLARE --声明
            --在此声明plsql用到的变量,类型
    
    BEGIN --(执行)
           --过程及sql语句
    EXCEPTION
          --执行异常:错误处理
    
    END;
    
    
 --简单的plsql块
 DECLARE   --声明并赋值 变量名 类型:=值;     :=赋值   =条件判断
      V_NUM NUMBER:=10; --注意:plsql在声明变量的时候前面加V_代表变量 VAR
  
 
 BEGIN
      
       --执行:对num+1输出
            V_NUM:=V_NUM+1;
            DBMS_OUTPUT.put_line('NUM'||V_NUM); -- ||连接符
              
     
 END;   


--[1]声明变量赋值为员工表中Smith的员工编号  SELECT…INTO
DECLARE
 V_NUM NUMBER; --声明

BEGIN
    SELECT EMPNO INTO V_NUM FROM EMP WHERE ENAME='SMITH';
     DBMS_OUTPUT.put_line('NUM'||V_NUM);
END;


--[2]声明变量,变量的类型是scott用户下emp表empno字段的字段类型  %TYPE

DECLARE
    V_NUM SCOTT.EMP.EMPNO% TYPE;

BEGIN
    SELECT EMPNO INTO V_NUM FROM EMP WHERE ENAME='SMITH';
     DBMS_OUTPUT.put_line('NUM'||V_NUM);
END;

--[3]取一行数据 %rowtype



DECLARE
    V_EMPROW SCOTT.EMP%ROWTYPE;

BEGIN
    SELECT * INTO V_EMPROW FROM EMP WHERE ENAME='SMITH';
     DBMS_OUTPUT.put_line(V_EMPROW.ENAME||V_EMPROW.EMPNO||V_EMPROW.JOB);
END;


--常量:
DECLARE
    --声明
    C_PI CONSTANT NUMBER:=3.1415;  --cinstant:常量,一旦设定不能更改, 命名规范:常量前加C
    V_R NUMBER:=20;
    V_AREA NUMBER;
    
BEGIN
  V_AREA:=C_PI*V_R*V_R;    
  DBMS_OUTPUT.put_line('圆的面积:'||V_AREA);

END;


--判断语句
--IF
--成绩大于90分就去玩游戏,否则去写作业  --声明学生成绩
--80;
--70;
--60;



DECLARE
  
  V_SCORE NUMBER;

BEGIN
  V_SCORE:='&请输入你的成绩';
  IF(V_SCORE>=90)THEN DBMS_OUTPUT.PUT_LINE('去玩游戏');
  ELSIF(V_SCORE>=80)THEN DBMS_OUTPUT.PUT_LINE('去报补习班');
  ELSIF(V_SCORE>=70)THEN DBMS_OUTPUT.PUT_LINE('去报两个补习班');
  ELSIF(V_SCORE>=60)THEN DBMS_OUTPUT.PUT_LINE('去跪键盘');
  ELSE
    DBMS_OUTPUT.PUT_LINE('去写作业');
  END IF;  
END;


--SWITCH

DECLARE
   V_SCORE NUMBER;
BEGIN
   V_SCORE:='&请输入';
   CASE
     WHEN V_SCORE>90 THEN DBMS_OUTPUT.PUT_LINE('去玩游戏');
     WHEN V_SCORE>80 THEN DBMS_OUTPUT.PUT_LINE('去玩');
     WHEN V_SCORE>70 THEN DBMS_OUTPUT.PUT_LINE('去');
     WHEN V_SCORE>60 THEN DBMS_OUTPUT.PUT_LINE('...');
     ELSE   
        DBMS_OUTPUT.PUT_LINE('去写作业');  
      END CASE;   
END;




--循环结构
LOOP
   WHILE
      FOR
        
      
  --LOOP
 --要求一个变量,每次循环减1,并输出结果,当变量小于3时,退出循环

DECLARE  
 V_COUNT NUMBER:=10;
BEGIN
  LOOP--循环的开始
  V_COUNT:=V_COUNT-1; --减1 num--
  EXIT WHEN V_COUNT<3; --满足条件 退出循环
  DBMS_OUTPUT.PUT_LINE(V_COUNT);  
  END LOOP; --循环的结束
END;


DECLARE  
 V_COUNT NUMBER:=10;
BEGIN
  LOOP--循环的开始
  V_COUNT:=V_COUNT-1; --减1 num--
  IF V_COUNT<3 THEN EXIT ; --满足条件 退出循环 
  END IF; 
   DBMS_OUTPUT.PUT_LINE(V_COUNT); 
  END LOOP; --循环的结束
END;


--WHILE
--声明变量1,每次循环加1,并输出结果,当变量 大于20的时候,退出循环
DECLARE
   V_NUM NUMBER:=1; --声明变量并赋值
BEGIN
  WHILE V_NUM<20 LOOP
      DBMS_OUTPUT.PUT_LINE(V_NUM);
      V_NUM:=V_NUM+1;
      
   END LOOP;
END;


--FOR
--变量从0,变量等于10,每次循环+1,算循环的次数
/*
int num=0;--记录次数
for(int a=0;i<=10;i++){
  syso(num);

}


*/


DECLARE
 V_NUM NUMBER:=0; 
BEGIN
  FOR I IN 0..10 LOOP --从0开始,<=10
  V_NUM:=V_NUM+1;
  END LOOP;
    DBMS_OUTPUT.PUT_LINE(V_NUM);
END;



--异常


DECLARE
 V_TEMP NUMBER(4);
BEGIN
  SELECT EMPNO INTO V_TEMP FROM  EMP WHERE DEPTNO=10;  
END;


--对错误进行处理
DECLARE
 V_TEMP NUMBER(4);
BEGIN
  SELECT EMPNO INTO V_TEMP FROM  EMP WHERE DEPTNO=100;  
EXCEPTION 
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.put_line('返回的记录太多了'); 
  WHEN NO_DATA_FOUND THEN  
    DBMS_OUTPUT.put_line('没有数据啊……');
  WHEN OTHERS THEN
    DBMS_OUTPUT.put_line('自他异常……');     
END;

--类型不匹配异常   --自定义异常
DECLARE
   V_NUMBER1 NUMBER; --声明变量
   V_NUMBER2 NUMBER;
   V_RESULT NUMBER;
   E_NOUNMBER EXCEPTION;--声明异常   
   PRAGMA EXCEPTION_INIT(E_NOUNMBER,-6502);--将错误代码跟我们自定义的异常名称绑定,并注册到系统里面
BEGIN 
  V_NUMBER1:='&请输入被除数';
  V_NUMBER2:='&请输入除数';
  V_RESULT:=V_NUMBER1/V_NUMBER2;
   DBMS_OUTPUT.put_line(V_RESULT);
EXCEPTION
  WHEN E_NOUNMBER THEN
       DBMS_OUTPUT.put_line('你输入的不是数字'); 
END;




--
CREATE TABLE ERROLOG( --错误日志
   ERROCODE NUMBER,   --出错的编码 (ORA-XXXX)
   ERROMSG VARCHAR2(1024),  --出错的信息
   ERRODATE DATE   --出错时间
);

DROP TABLE ERROLOG;

SELECT * FROM ERROLOG;

DECLARE
  V_DEPTNO DEPT.DEPTNO%TYPE:=10;--声明一个变量v_detno 是dept表的deptno类型
  ERROCODE NUMBER; --出错的编码
  ERROMSG VARCHAR2(1024);   --出错信息 
BEGIN
  DELETE FROM DEPT WHERE DEPTNO=V_DEPTNO;
    COMMIT;
EXCEPTION 
   WHEN OTHERS THEN
     ROLLBACK;
     ERROCODE:=SQLCODE;--打印错误编码
     ERROMSG:=SQLERRM;--打印错误信息
     INSERT INTO ERROLOG VALUES(ERROCODE,ERROMSG,SYSDATE);
     COMMIT;
END;

DELETE FROM DEPT WHERE DEPTNO=10;

SELECT * FROM DEPT;
SELECT * FROM EMP;



--游标
SELECT * FROM EMP WHERE DEPTNO=20;

--[1]取出emp表中所有人的名子

DECLARE
  CURSOR C IS  --声明游标
     SELECT * FROM EMP;
     V_EMP C%ROWTYPE;     
BEGIN
  OPEN C;  --打开游标
    FETCH C INTO V_EMP; --把当前的游标指向的数据拿出来
    DBMS_OUTPUT.put_line(V_EMP.ENAME);
    CLOSE C;
END;



DECLARE
  CURSOR C IS  --声明游标
     SELECT * FROM EMP;
     V_EMP C%ROWTYPE;     
BEGIN
  OPEN C;  --打开游标
   LOOP
    FETCH C INTO V_EMP; --把当前的游标指向的数据拿出来
    EXIT WHEN(C%NOTFOUND);
    DBMS_OUTPUT.put_line(V_EMP.ENAME);
    END LOOP;
    CLOSE C;
END;


--[2]带参数的游标
DECLARE
   CURSOR C(V_DEPTNO EMP.DEPTNO%TYPE,V_JOB EMP.JOB%TYPE)
   IS
    SELECT ENAME,SAL FROM EMP WHERE DEPTNO=V_DEPTNO AND JOB=V_JOB;
BEGIN
   FOR V_TEMP IN C(30,'CLERK')
     LOOP
       DBMS_OUTPUT.put_line(V_TEMP.ENAME);       
     END LOOP;
END;


SELECT * FROM EMP WHERE DEPTNO=30 AND JOB='CLERK';

--[3]可更新的游标
--创建一张表
CREATE TABLE EMP2
 AS 
    SELECT * FROM EMP;

SELECT * FROM EMP2;

--需求是工资大于2000*2,大于等于3000的删除
DECLARE 
 CURSOR C 
    IS
       SELECT * FROM EMP2 FOR UPDATE; --只要写for update:为了跟新才使用的游标
BEGIN
    FOR V_TEMP IN C
      LOOP
        IF(V_TEMP.SAL<2000)THEN
           UPDATE EMP2 SET SAL=SAL*2 WHERE CURRENT OF C; --当前游标
         ELSIF(V_TEMP.SAL=3000)THEN
           DELETE FROM EMP2 WHERE CURRENT OF C;  
         END IF;    
         END LOOP;  
END;



SELECT * FROM EMP2 FOR UPDATE;


--存储过程

--创建存储过程  名字为PPPP 关键字:PROCEDURE,OR REPLACE替换
CREATE OR REPLACE PROCEDURE PPP 
IS
   CURSOR C 
    IS
       SELECT * FROM EMP2 FOR UPDATE;  --可更新的游标
BEGIN
    FOR V_TEMP IN C
      LOOP
        IF(V_TEMP.SAL<2000)THEN
           UPDATE EMP2 SET SAL=SAL*2 WHERE CURRENT OF C; --当前游标
         ELSIF(V_TEMP.SAL=3000)THEN
           DELETE FROM EMP2 WHERE CURRENT OF C;  
         END IF;    
         END LOOP;  
END;


--执行存储过程

BEGIN
  PPP;
END;

SELECT * FROM EMP2;



--带参的存储过程
CREATE OR REPLACE PROCEDURE P
    (V_A IN NUMBER,V_B NUMBER,V_C OUT NUMBER,V_TEMP IN OUT NUMBER) --IN:传入参数 out:传出参数,IN,OUT既可以传出也可以传入
    IS
 BEGIN
   IF(V_A>V_B)THEN
     V_C:=V_A;
     ELSE 
       V_C:=V_B; 
  END IF;
     V_TEMP:=V_TEMP+1;
END;

--调用程序
DECLARE
   V_A NUMBER:=3;
   V_B NUMBER:=4;
   V_C NUMBER;
   V_TEMP NUMBER:=5;
BEGIN
  P(V_A,V_B,V_C,V_TEMP);
  DBMS_OUTPUT.put_line(V_C);
  DBMS_OUTPUT.put_line(V_TEMP);
END;



--函数
CREATE OR REPLACE FUNCTION SAL_TAX  --方法 计算薪水的个人所得税
  (V_SAL NUMBER) --行参number类型
  RETURN NUMBER
  IS 
 
BEGIN 
  IF(V_SAL<2000)THEN
    RETURN 0.10; 
   ELSIF(V_SAL<2750)THEN
     RETURN 0.15;
    ELSE 
      RETURN 0.20;
   END IF;
   
   END; 
 

SELECT LOWER(ENAME),SAL_TAX(SAL) FROM EMP;



--序列

--序列的名字为seq_aa,序列的第一值是1,每次执行增加1;
CREATE SEQUENCE SEQ_AA
START WITH 1  --从1开始
INCREMENT BY 1; --每次执行加1

--查看当前值
SELECT SEQ_AA.CURRVAL FROM DUAL;
--查看下一个值
SELECT SEQ_AA.NEXTVAL FROM DUAL;
    
--查看序列
SELECT SEQUENCE_NAME FROM USER_SEQUENCES;

DROP SEQUENCE SEQ_AA;


--如何把序列的值在表中插入数据的时候使用
INSERT INTO AA VALUES(SEQ_AA.NEXTVAL,'小濑');

SELECT * FROM AA;

CREATE TABLE AA(
  AID NUMBER,
  ANAME VARCHAR2(10)
);
   



DROP TABLE AA;


CREATE SEQUENCE SEQ_IDD
START WITH 100
INCREMENT BY -1
MAXVALUE 100
MINVALUE  90
CYCLE
CACHE 10; 


SELECT SEQ_IDD.CURRVAL FROM DUAL;
SELECT SEQ_IDD.NEXTVAL FROM DUAL;



--分页

--rowid:在数据创建时生成,指的是数据在硬盘上的存储位置,使用rowid直接访问快.(但人力无法控制)
SELECT ROWID,D.* FROM DEPT D;


--ROWNUM:伪列 --控制查询的返回行数
--查询用户表的前五条数据
SELECT ROWNUM,EMPNO,ENAME
FROM EMP
WHERE ROWNUM<=5;


--查询6到10条
SELECT ROWNUM,EMPNO,ENAME
FROM EMP
WHERE ROWNUM>=6
AND ROWNUM<=10;--<,<=

SELECT ROWNUM,EMPNO,ENAME,SAL
FROM EMP
WHERE ROWNUM<=5
ORDER BY SAL DESC; 


--[1]按工资进行降序排序
SELECT EMPNO,ENAME,SAL
FROM EMP ORDER BY SAL DESC;

--[2]将[1]中的结果做为一张表,查询rownum
SELECT ROWNUM,E.*
FROM (SELECT EMPNO,ENAME,SAL FROM EMP  ORDER BY SAL DESC)E
WHERE ROWNUM<=5;


--[3]查询6到10条
SELECT ROWNUM,E.*
FROM (SELECT EMPNO,ENAME,SAL FROM EMP  ORDER BY SAL DESC)E
WHERE ROWNUM<=10;

SELECT * FROM(SELECT ROWNUM R  ,E.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP  ORDER BY SAL DESC)E WHERE ROWNUM<=10) T
WHERE T.R>5  --5:(2-1)*5
AND T.R<=10;  --10:2*5


--每页显示3条数据,问第二页
SELECT * FROM(SELECT ROWNUM R ,E.* FROM (SELECT EMPNO,ENAME,SAL FROM EMP  ORDER BY SAL DESC)E WHERE ROWNUM<=10) T
WHERE T.R>3   --3:(2-1)*3
AND T.R<=6;   --6:2*3


--起始页: >(页数-1)*条数
--结束值: <=页数*条数





--三大范式:
第一范式:
    最基本的范式
       数据库表的每一列都是不可分割的基本数据项,同一列中不能多个值(字段不可再拆分)
       
第二范式:
    需要确保每一个列都和主键相关,而不是只与某一部门有关(主要针对联合主键而言)
    联合主键:一个表中只能有一个主键,但可以由多个列组成     
    在一个数据库表中只能保存一种数据,不可以把多种数据保存在同一张数据库表中
    (可以把多对多的属性,转为1对多)
    
第三范式:
   每一列数据都和主键直接相关
   不依赖于其他非主键键属性   

第一:列不能再拆分
第二:把多对多转为1对多
第三:列要和主键之间相关,不相关就拆

数据库表之间的关系
     1对1:学生和学生证
     1对多:学生和班级
     多对多:学生和课程
    

表示数据库表之间的关系: 外键



--触发器
--创建一个表记录操作记录

CREATE TABLE EMP_LOG(
   UNAME VARCHAR2(20),
   ATIME DATE
);

SELECT * FROM EMP_LOG;



--删除表中数据触发事件
CREATE OR REPLACE TRIGGER SSSSS
AFTER
     DELETE ON T_EMP
   BEGIN
      INSERT INTO EMP_LOG VALUES(USER,SYSDATE);
END;

DELETE FROM T_EMP WHERE EMPNO=7900;
   

CREATE TABLE T_EMP 
AS
 SELECT * 
 FROM EMP;  
   
   


SELECT * FROM T_EMP;


--触发器id自增  序列
--创建一张表
CREATE TABLE TEST_CREATE_TAB(
   ID NUMBER,
   VAL VARCHAR2(10),
   PRIMARY KEY (ID)
);

SELECT * FROM TEST_CREATE_TAB;


--创建序列
CREATE SEQUENCE TEST_SEQ
START WITH 1
INCREMENT BY 1
NOMAXVALUE
MINVALUE 1
NOCYCLE
 

--创建触发器
CREATE OR REPLACE TRIGGER AAAAA
BEFORE 
INSERT ON TEST_CREATE_TAB
FOR EACH ROW
BEGIN
  SELECT  TEST_SEQ.NEXTVAL INTO:NEW.ID FROM DUAL;
  END;   


   
INSERT INTO TEST_CREATE_TAB(ID,VAL)VALUES(1,'YING');



事物:
    是一个操作序列,这些操作要么都做,要么都不做,是一个不可分割的工作单位
      事物起始一条dml语句结束语:
      1.commit,rollback语句
      2.当执行ddl语句事物自动提交
      3.用户正常断开连接时,事物自动提交
      4.系统奔溃或断电时事物自动回退
  

  COMMIT:提交
  ROLLBACK:回退
  
    注:一旦执行commit语句,将目前对数据库的操作提交给数据库(实际写入db)以后就不能用ROLLBACK进行撤销
    
      回滚前数据的状态:
              以前的数据可恢复
              当前的用户可以看到dml操作的结果
              其他用户不能看dml操作的结果
              被操作的数据被锁住,其他用户不能修改这些数据
      
      提交后的数据状态:
          数据的修改被永久写在数据库中
          数据以前的状态永久性丢失
          所有用户都能看到操作后的结果
          记录锁被释放,其他用户可操作这些记录
          
          
       回滚后数据的状态:
            语句将放弃所有数据的修改
            修改的数据被回退
            恢复数据以前的状态
            行级锁被释放



--表空间
--表空间就是代表这个用户所管理的数据区域和数据表的范围
--创建表空间
CREATE TABLESPACE USER1
    DATAFILE'F:\USER1.DBF'--放到哪里
    SIZE 100M   --指该数据文件的大小,也就是表空间的大小
    AUTOEXTEND ON NEXT 32M MAXSIZE UNLIMITED  --大小自动扩展,没有最大限制
    LOGGING   --log在这里的意思 表示在创建
    EXTENT MANAGEMENT LOCAL--将数据存在本地 没有放到服务器
    SEGMENT SPACE MANAGEMENT AUTO;--设置表空间中段管理方式为递增



--将表空间分配给用户
--创建用户
CREATE USER UUU
IDENTIFIED BY HAHAHA
DEFAULT TABLESPACE USER1;--赋予表空间为user1


DROP TABLESPACE USER1;

--查看用户对应的默认表空间
SELECT USERNAME,DEFAULT_TABLESPACE FROM DBA_USERS WHERE USERNAME='UUU';

--修改用户的表空间
ALTER USER UUU DEFAULT TABLESPACE USERS;

--查看表空间的名称及大小
SELECT T.TABLESPACE_NAME,ROUND(SUM(BYTES/(1024*1024)),0)"TS_SIZE(M)"
FROM DBA_TABLESPACES T,DBA_DATA_FILES D
WHERE T.TABLESPACE_NAME=D.TABLESPACE_NAME
GROUP BY T.TABLESPACE_NAME;        
          
-- 查看表空间物理文件的名称及大小
SELECT TABLESPACE_NAME,
FILE_ID,
FILE_NAME,
ROUND(BYTES/(1024*1024),0)TOTAL_SPACE
FROM DBA_DATA_FILES
ORDER BY TABLESPACE_NAME;       


--查看表空间的使用情况
SELECT SUM(BYTES)/(1024*1024) AS "FREE_SPACE(M)",TABLESPACE_NAME
FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NAME;

--调整(修改)表空间
--修改数据文件大小
ALTER DATABASE DATAFILE'F:\USER1.DBF'
RESIZE 50M;

--删除表空间
--删除user只是删除了该user下的对象,如:表,触发器,视图等,是不会删除相应的tablespace
DROP USER UUU CASCADE
--删除tablespace
DROP TABLESPACE USER1 INCLUDING AND DATAFILES;

SELECT * FROM T_EMP;

INSERT INTO T_EMP VALUES(1002,'zhangsan','clerk',7902,Sysdate,10000,100,20);
       
SELECT * FROM STUDENT;

SELECT EMPNO,ENAME,JOB FROM EMP;


CREATE TABLE USERINFO(
   USERID NUMBER(3) PRIMARY KEY,
   UNAME VARCHAR2(10) NOT NULL,
   PSWD VARCHAR2(10) CHECK(LENGTH(PSWD)>=6)
);

--创建一个序列
CREATE SEQUENCE SEQ_UUID
START WITH 1
INCREMENT BY 1

--使用序列
INSERT INTO USERINFO VALUES (SEQ_UUID.NEXTVAL,'phoebe','phoebe');

SELECT * FROM USERINFO;

SELECT * FROM USERINFO WHERE UNAME='vsdv'OR'1'='1';



--[1]查询部门编号为20的员工编号,姓名,工资,入职时间
SELECT EMPNO 工号,ENAME,SAL,HIREDATE FROM EMP WHERE DEPTNO=20;



--[2]将'SMITH'的工资上调到3500
UPDATE EMP SET SAL=3500 WHERE ENAME='SMITH';

--[3]今天入职的员工到SMITH的部门
INSERT INTO EMP(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO)
VALUES(1009,'ASD','CLERK',SYSDATE,2000,20);


--[4]将1009的员工从部门表删除
DELETE EMP WHERE EMPNO=1009;



SELECT * FROM EMP;


开发顺序
   用户
   1.表示层    -->获取用户输入的数据信息,对数据进行封装
   2.业务逻辑层  -->比如:账号或密码的非空验证,密码加密  login register
   
   3数据访问层   -->和数据库打交道
         [1]实体类:  -->各层之间起传递的作用,是数据库当中的一张表,通常和表名相同
                         数据库中的一张表对应起java程序的一个实体类
                         表中的每个字段对应实体类的一个属性
                         表中的没一个记录对应一个实体类对象
                         
         [2]Dao包
              接口: EmoDao:
                    getAllEmp();
                    addEmp(Emp);
                    deleteEmp(int empno)
                    getByempNo(int empno)
               实现类:EmpDaoImpl
                      BaseDao:实现了代码的复用
                      
                      
             数据库
             
                 
             
             步骤:
                实体类的包:    cn.phoebe.entity
                接口    :     cn.phoebe.dao(增删改查方法接口)
                实现类  :    cn.phoebe.impl
                测试类  :   cn.phoebe.test
                
         Emp{
         
         //私有属性
         private int empno;   //表中字段,类型按照数据库的数据类型
         
         
        //公有的取值赋值方法 
        
        //构造方法
                
         }
             
      //接口
      interface EmpDao{   // 人事管理的系统
         //获取全部的数据方法
         public ArrayList<Emp> getAllEmp();
         //向表中添加员工
         public void addEmp(Emp emp);
         //删除一个员工
         public void deleteEmp(int emp);       
           //根据员工的编号去查询
           public Emp selectEmp(int emono);     
      
      }   
      
      //BaseDao
      BaseDao{
         连接的方法
         关闭的方法 
      }
     //实现类
     
     EmpDaoImpl{
        //实现接口中的四个方法
        //[1]获取连接
       //[2]创建预编译的发送器并发送sql语句
       
     }
     
     test{
       //测试是否完成需求
     
     
     }
   
   
   
   
   
   
     
   
   


