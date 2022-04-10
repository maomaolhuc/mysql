--事物
/*
事物：是指作为单个逻辑工作单元执行的一系列操作，这些操作要么都执行 要么都不执行
1.原子性（Atomic） ：事物中所有数据的修改 要么全部执行 要么全部不执行
2.一致性（Consistence） ：事物完成时 要使所有的数据保持一致的状态
3.隔离性 （Isolation）: 事物应该在另一个事物对数据的修改前或修改后进行访问
4.持久性 （Durability）： 保证事物对数据库的修改是持久有效的   即使发现系统故障  也不应该丢失
*/
--银行转账
DECLARE
V_CHMONEY NUMBER (10);
       V_CURRMOENY NUMBER(10);
       E_MONEYCHAGE EXCEPTION;
       --自定义一个错误代码（错误代码范围 -20000 - -20999）
       PRAGMA EXCEPTION_INIT(E_MONEYCHAGE,-20001);
BEGIN
       V_CHMONEY := '&土豪，请输入你要转账的金额';
SELECT TMONEY  INTO V_CURRMOENY  FROM T_ACCOUNT  WHERE TNAME ='阿辉';

UPDATE T_ACCOUNT SET TMONEY = TMONEY - V_CURRMOENY WHERE TNAME ='阿辉';

IF   V_CHMONEY >  V_CURRMOENY  THEN
            --DBMS_OUTPUT.PUT_LINE('您当前的账户余额不足');
            --RAISE E_MONEYCHAGE;   --抛出异常
            RAISE_APPLICATION_ERROR(-20001,'您当前的余额不足');
            --RAISE_APPLICATION_ERROR 系统默认的存储过程 专门为自定义异常定义的存储过程
END IF;

UPDATE T_ACCOUNT SET TMONEY = TMONEY + V_CURRMOENY WHERE TNAME ='傻傻';
COMMIT;  --提交
EXCEPTION
       WHEN  E_MONEYCHAGE THEN
          ROLLBACK;  --回滚
         DBMS_OUTPUT.PUT_LINE(SQLCODE);
         DBMS_OUTPUT.PUT_LINE(SQLERRM);
WHEN OTHERS THEN
          ROLLBACK;  --回滚
         DBMS_OUTPUT.PUT_LINE(SQLCODE);
         DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--事物保存点案例
SELECT * FROM T_EMP
DECLARE
V_MONEY NUMBER;
     V_NUM NUMBER;
BEGIN
     V_MONEY := '&请输入涨工资的金额';
UPDATE T_EMP SET SAL = SAL + V_MONEY WHERE EMPNO =7369;
UPDATE T_EMP SET SAL = SAL + V_MONEY WHERE EMPNO =7499;
UPDATE T_EMP SET SAL = SAL + V_MONEY WHERE EMPNO =7521;

SAVEPOINT A;   -- 设置保存点
V_NUM := 1/0;    --错误
UPDATE T_EMP SET SAL = SAL + V_MONEY WHERE EMPNO =7521;
COMMIT ;
EXCEPTION
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('出现错误' ||SQLERRM);
ROLLBACK TO A;   --回滚到指定的点
END;

--设置事物自定提交
SET AUTOCOMMIT ON   --当执行数据的更新操作时，事物会自动提交
SET AUTOCOMMIT OFF    --当执行数据的更新操作时，事物不会自动提交




















