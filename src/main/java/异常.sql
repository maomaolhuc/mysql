--异常
--1. 预定义异常 ：oracle自带
--2.自定义异常  （1，错误  2，业务上的逻辑需要）

--系统自定义异常的处理方式
DECLARE
V_NUM1 NUMBER(5);
     V_NUM2 NUMBER(5);
     V_RESULT NUMBER(5);
BEGIN
     V_NUM1 := '&请输入被除数';
     V_NUM2 := '&请输入除数';
     V_RESULT := V_NUM1/V_NUM2;
     DBMS_OUTPUT.PUT_LINE('V_RESULT:' || V_RESULT);
EXCEPTION
       WHEN ZERO_DIVIDE THEN   --当遇到系统自定义异常的时候不需要做另外的处理，直接调用异常代码即可捕获
          DBMS_OUTPUT.PUT_LINE('输入的除数为0');
          DBMS_OUTPUT.PUT_LINE(SQLCODE);
          DBMS_OUTPUT.PUT_LINE(SQLERRM);
WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('其它错误');
          DBMS_OUTPUT.PUT_LINE(SQLCODE);
          DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--怎么进行异常的自定义
DECLARE
V_NUM1 NUMBER(5);
     V_NUM2 NUMBER(5);
     V_RESULT NUMBER(5);
     E_NUMBER EXCEPTION;
     --将这个错误代码跟我们自定义的异常名称绑定并注册到系统里面
     -- Oracle自定义的错误代码范围（-1000000，-100）
     PRAGMA EXCEPTION_INIT(E_NUMBER,-6502);
BEGIN
     V_NUM1 := '&请输入被除数';
     V_NUM2 := '&请输入除数';
     V_RESULT := V_NUM1/V_NUM2;
     DBMS_OUTPUT.PUT_LINE('V_RESULT:' || V_RESULT);
EXCEPTION
       WHEN E_NUMBER THEN
          DBMS_OUTPUT.PUT_LINE('输入的不是数字');
END;

SELECT * FROM EMP

SELECT SAL FROM EMP WHERE ENAME ='SMITH';
--银行转账
DECLARE
V_CHMONEY NUMBER(10);
          V_CURRMONEY NUMBER(10);
          E_MONTYCHANGE EXCEPTION;
          --自定义错误编码范围 （-20000 -  -20999）
          PRAGMA EXCEPTION_INIT(E_MONTYCHANGE,-20001);
BEGIN
      V_CHMONEY := '&土豪，请输入你要转入的金额';
SELECT SAL INTO V_CURRMONEY FROM EMP WHERE ENAME ='SMITH';
IF V_CHMONEY  >  V_CURRMONEY  THEN
        --RAISE_APPLICATION_ERROR 这个是系统默认的存储过程，专门为自定义异常定义的
        RAISE_APPLICATION_ERROR(-20001,'您当前的账户余额不足');
END IF;
      --UPDATE 语句
COMMIT;
DBMS_OUTPUT.PUT_LINE('转账成功');

EXCEPTION
      WHEN E_MONTYCHANGE THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('SQLCODE' || SQLCODE );
        DBMS_OUTPUT.PUT_LINE('SQLERRM' || SQLERRM );
        DBMS_OUTPUT.PUT_LINE('您当前的账户余额不足');

WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('出现其它异常');
        DBMS_OUTPUT.PUT_LINE('SQLCODE' || SQLCODE );
        DBMS_OUTPUT.PUT_LINE('SQLERRM' || SQLERRM );
END ;




