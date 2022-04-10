/*
一.what（什么是视图？）
1.视图是一种数据库对象，是从一个或者多个数据表或视图中导出的虚表，
视图所对应的数据并不真正地存储在视图中，而是存储在所引用的数据表中，
视图的结构和数据是对数据表进行查询的结果。

2.根据创建视图时给定的条件，视图可以是一个数据表的一部分，也可以是多个基表的联合，
它存储了要执行检索的查询语句的定义，以便在引用该视图时使用。

二.why（为什么要用视图？视图的优点）
1.简化数据操作：视图可以简化用户处理数据的方式。

2.着重于特定数据：不必要的数据或敏感数据可以不出现在视图中。

3.视图提供了一个简单而有效的安全机制，可以定制不同用户对数据的访问权限。

4.自定义数据：视图允许用户以不同方式查看数据。

5.导出和导入数据：可使用视图将数据导出到其他应用程序。

三 ：HOW (怎么样来建立视图，用视图)
*/
-- 注意:创建视图需要create view的权限
/*
视图的创建基本语法：
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name
[(alias[, alias]...)]

AS subquery
[WITH CHECK OPTION [CONSTRAINT constraint]]
[WITH READ ONLY]
--OR REPLACE  若所创建的视图以及存在，oracle自动重建该视图
--FORCE   不管基表是否在oracle都会自动创建该视图
--NOFORCE   只有基本存在Oracle才会创建该视图
--alias   为视图产生的列定义的别名
--subquery   一条完整的select语句，可以在该语句中定义别名
--WITH CHECK OPTION    插入或修改的数据行必须满足视图定义的约束
--WITH READ ONLY   该视图上不能进行任何dml操作
*/
--grant create view to scott;  授权语句

--案例
CREATE OR REPLACE VIEW VI_DEPT_SUM
        (DNAME,MINSAL,MAXSAL,AVGSAL)   --定义列的别名
AS
SELECT D.DNAME,MIN(E.SAL),MAX(E.SAL),AVG(E.SAL) FROM EMP E,DEPT D
WHERE E.DEPTNO =D.DEPTNO
GROUP BY D.DNAME;

--查询视图
SELECT * FROM VI_DEPT_SUM;

--视图的DML操作
SELECT * FROM T_EMP;

CREATE TABLE T_EMP AS SELECT * FROM EMP ;
CREATE TABLE T_DEPT AS SELECT * FROM DEPT;


--创建一个视图
CREATE OR REPLACE VIEW VI_ED_EDIT
AS
SELECT E.EMPNO,E.ENAME,E.SAL,D.DNAME,D.DEPTNO
FROM T_EMP E,T_DEPT D
WHERE E.DEPTNO = D.DEPTNO ;  --WITH READ ONLY


ALTER TABLE T_EMP ADD CONSTRAINTS PK_EMPNO PRIMARY KEY(EMPNO);
ALTER TABLE T_DEPT ADD CONSTRAINTS PK_DEPTNO PRIMARY KEY(DEPTNO);

SELECT * FROM VI_ED_EDIT

--UPDATE修改注意点：
--1.必须要有主键
--2. view的修改只能涉及一个表
--3.当视图定义中包含分组函数，group by子句，distinct关键字 rownum 的情况下不能执行update操作
UPDATE VI_ED_EDIT SET ENAME= 'SMITH_TEST'  WHERE EMPNO =7369;

--INSERT (注意：
--1.必须要有主键
--2. view的修改只能涉及一个表
--3当视图定义中包含分组函数，group by子句,distinct关键字 rownum 列的定义为表达式 不能执行insert操作)

INSERT INTO VI_ED_EDIT (EMPNO,ENAME,SAL) VALUES (2222,'TEST',99);


--delete (注意：
--1.必须要有主键
--2. view的修改只能涉及一个表
--3当视图定义中包含分组函数，group by子句,distinct关键字 rownum 列的定义为表达式 不能执行delete操作)

DELETE FROM VI_ED_EDIT WHERE EMPNO =7782;


SELECT * FROM VI_ED_EDIT

--删除视图
/*
   DROP VIEW VI_NAME 删除视图
   删除视图的定义不影响基本中的数据
   只有视图的所有者和具备drop view权限的用户才可以删除视图
   视图被删除之后 基于被删除视图的其它视图或应用将无效。
*/

DROP VIEW VI_ED_EDIT;


/*
一.what（什么是索引？）
1、 类似书的目录结构
2、 Oracle 的“索引”对象，与表关联的可选对象（可建也可以不建）
3、 索引直接指向包含所查询值的行的位置，减少磁盘I/O
4、 与所索引的表是相互独立的物理结构
5、 Oracle 自动使用并维护索引，插入、删除、更新表后，自动更新索引

二.why（为什么要用索引？）
    提高SQL查询语句的速度

三： HOW(怎么用)
索引的类型
1：唯一索引
2：组合索引
3: 反向索引
4：位图索引
5：基于函数或者条件的索引

*/
-- 创建索引
/*
create index 索引名 ON 表名 (列名)

tablespace 表空间名;
*/
CREATE TABLE TD_P
(
    P_ID NUMBER,
    P_NAME VARCHAR2(100),
    P_TYPE VARCHAR2(20)
);

INSERT INTO TD_P
SELECT 1,'JAVA',99 FROM DUAL UNION ALL
SELECT 2,'C++',99 FROM DUAL UNION ALL
SELECT 3,'WEB',99 FROM DUAL UNION ALL
SELECT 4,'C#',99 FROM DUAL;

--唯一索引
/*
 何时创建： 当某列的值都是唯一的时候
 1.当建议primary key 或者是unique 约束的时候，唯一索引将被自动建立
 CREATE UNIQUE NDEX 索引名 on 表名（列名）；
 UNIQUE 表示唯一
*/
CREATE UNIQUE INDEX P_ID_U ON TD_P(P_ID);

--组合索引
/*
  何时创建：当俩个或多个列经常一起出现在where条件当中时，则在这些列上面同时创建组合索引
  组合索引中列的顺序是任意的，也无需相邻 但是建议将最频繁访问的列放在列表的最前面
  语法：CREATE [UNIQUE]  IDEX 索引名 ON TABLE (列名1，列名2)
*/
CREATE UNIQUE INDEX NAME_TYPE_INDEX ON TD_P(P_NAME,P_TYPE);

SELECT * FROM T_EMP
--反向键索引
/*
  何时创建:比如索引值是一个自动增长的列
  目的：多个用户对集中在少数块上的索引进行修改，容易引起资源的争用，如果对数据块等待
  语法：CREATE INDEX 索引名 ON TABLE(列名) REVERSE
*/
CREATE INDEX P_ID_REV ON T_EMP(ENAME) REVERSE;

--位图索引
/*
何时创建：列中右非常多重复数据的时候 比如：性别

优点：位图以一种压缩格式存放，因此占用的磁盘工具比标准索引要小的多
语法：CREATE BITMAP INDEX 索引名 ON TABLE(列名)
*/
CREATE BITMAP INDEX T_JOB_INDEX ON T_EMP (JOB);

--基于函数索引
/*
何时创建：在where条件语句中包含函数或表达式时
函数包括：算术表达式，自定义函数，系统函数
语法：CREATE INDEX 索引名 on table (function(列名))
*/
CREATE INDEX MG_EMP_INDEX ON T_EMP (UPPER(MGR));

