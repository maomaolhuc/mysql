--锁
/*
  当oracle执行dml语句的时候 ，系统自动在所要操作的表上申请表级类型的锁
  当表级锁获得后 系统在自动申请行级类型的锁
*/
--打开a，b两个窗口
--在a窗口中执行
UPDATE T_EMP SET ENAME ='DD' WHERE EMPNO = 1;
--在b窗口中执行（会出现等待情况，除非a窗口中的事物提交）
UPDATE T_EMP SET ENAME ='DD' WHERE EMPNO = 1;


--排他锁
SELECT * FROM T_EMP FOR UPDATE;
/* 用户在发出这条命令之后  Oracle将会对返回集中的数据建立行级封锁 以防止其它用户的修改
*/
--1. 在a窗口中执行
SELECT * FROM T_EMP FOR UPDATE;
--在b窗口中执行（报错：ORA-00054: 资源正忙, 但指定以 NOWAIT 方式获取资源, 或者超时失效）
ALTER TABLE T_EMP DROP COLUMN COMM;

SELECT * FROM T_dept
--死锁
--任务a,b 资源1,2 任务a独占了资源1，任务b独占资源2，如果任务a要资源b 向任务b提出请求并等待
--任务b要求资源1 并且也等待  ab两者均不释放所占用的资源 就造成了死锁
--1 在a窗口中执行
UPDATE T_EMP SET ENAME ='C' WHERE EMPNO =1;
--2 在b窗口中执行
UPDATE T_DEPT SET DNAME ='C' WHERE DEPTNO =10;
--3 在a窗口中执行
UPDATE T_DEPT SET DNAME ='C' WHERE DEPTNO =10;
--4 在b窗口中执行
UPDATE T_EMP SET ENAME ='C' WHERE EMPNO =1;

--怎么解决
--查询锁表的进程
SELECT OBJECT_NAME,MACHINE,S.SID,S.SERIAL#
FROM V$LOCKED_OBJECT L,DBA_OBJECTS O,V$SESSION S
WHERE L.OBJECT_ID = O.OBJECT_ID
  AND L.SESSION_ID = S.SID

--KILL 进程解锁
ALTER SYSTEM KILL SESSION '69,922';  --sid ,serial#  就是上个查询语句的字段






















