--约束
--专业介绍：约束是强加在表上的规则或者是条件，确保数据库的满足业务规则，保证数据的完整性
--主要作用：保证数据库里面的数据的完整性和正确性
--约束的种类：
--约束种类
--1 主键约束： PRIMARY KEY  唯一+非空
--2 唯一约束：  UNIQUE 可以为空
--3 非空约束   not null 非空约束作用的列也叫强制列 ，必须要有值不能为空。 除非设置了默认值
--4 检查约束  check 检查格式，检查长度  比如邮箱 手机
--5 外键约束  foreign key
SELECT * FROM STUDENTS

--删除约束
ALTER TABLE STUDENT
DROP CONSTRAINT PK_STUDNET_SID

--注意点：
--如果是数据存在跟约束冲突的情况下，我们的约束是执行不成功的，必须得要先将数据进行修正
--之后才能执行我们的约束

--1.主键约束
--a.修改表的主键约束
--alter table tab_name
--add CONSTRAINT 主键约束名字  primary key (主键字段);
--CONSTRAINT  约束关键字
ALTER TABLE STUDENTS
    ADD CONSTRAINT PK_STUDNETS_SID PRIMARY KEY(S_ID);

--尝试下主键冲突错误，注意看错误提示
INSERT INTO STUDENTS VALUES (1,'傻傻',sysdate,null,null)

--b 新增表的时候建立主键约束
-- 列级定义
CREATE TABLE STUDENT(
    S_ID NUMBER(10) PRIMARY KEY
);

-- 表级定义
CREATE TABLE STUDENT(
                        S_ID NUMBER(10) ,
                        CONSTRAINT PK_STUDNET_SID PRIMARY KEY (S_ID)
);


--2 唯一约束
ALTER TABLE STUDENTS
    ADD CONSTRAINT UN_STUDENTS_SNAME UNIQUE (S_NAME);

DROP TABLE STUDENT
--列级定义
CREATE TABLE STUDENT (
                         S_ID NUMBER(10) PRIMARY KEY,
                         S_NAME VARCHAR2(10) UNIQUE
);

--表级定义
CREATE TABLE STUDENT(
                        S_ID NUMBER(10),
                        S_NAME VARCHAR2(10),
                        CONSTRAINT PK_STUDENT_SID PRIMARY KEY (S_ID),
                        CONSTRAINT UN_STUDENT_SNAME UNIQUE(S_NAME)
)

SELECT * FROM STUDENTS
--3.非空约束
ALTER TABLE STUDENTS
    MODIFY S_NAME NOT NULL;

--修改错误数据
UPDATE STUDENTS SET S_NAME ='大哈刘二' WHERE S_ID=7;
UPDATE STUDENTS SET S_NAME ='乔伊' WHERE S_ID=8;

--验证非空约束
INSERT INTO STUDENTS (S_ID,S_NAME)VALUES(9,NULL);

DROP TABLE STUDENT
--列级定义
--第一种写法
CREATE TABLE STUDENT (
                         S_ID NUMBER(10) PRIMARY KEY,
                         S_NAME VARCHAR2(10) UNIQUE,
                         S_DATE DATE NOT NULL
);
--第二种写法
CREATE TABLE STUDENT(
                        S_ID NUMBER(10),
                        S_NAME VARCHAR2(10),
                        S_DATE DATE CONSTRAINT CKNUULL_STUDNET_SDATE NOT NULL,
                        CONSTRAINT PK_STUDENT_SID PRIMARY KEY (S_ID),
                        CONSTRAINT UN_STUDENT_SNAME UNIQUE(S_NAME)
);

ALTER TABLE STUDENTS
DROP CONSTRAINT FK_SCORE_SID

SELECT * FROM STUDENTS
ALTER TABLE STUDENTS ADD(S_SEX VARCHAR2(10));
--检查约束 check
ALTER TABLE STUDENTS
    ADD CONSTRAINT  CK_STUDENTS_SSEX CHECK (S_SEX = '男' OR S_SEX = '女');

INSERT INTO STUDENTS (S_ID,S_NAME,S_SEX) VALUES(9,'傻傻','男');

--外键约束
--FK_SCORE_SID  外键约束的名字
--FOREIGN KEY 外键的关键字
--REFERENCES  指定要建立关联的表的信息
--ON DELETE CASCADE  指定在删除表中数据的时候 对关联表所做的相关操作

ALTER TABLE SCORE
DROP CONSTRAINT FK_SCORE_SID

SELECT * FROM STUDENTS;
SELECT * FROM SCORE ;
INSERT INTO SCORE VALUES (1,80);
DROP TABLE SCORE
CREATE TABLE SCORE(
                      S_ID NUMBER(10),
                      SCORE NUMBER(3),
                      CONSTRAINT FK_SCORE_SID FOREIGN KEY(S_ID) --s_id 外键字段
                          REFERENCES STUDENTS(S_ID)
    -- ON DELETE CASCADE     --当删除主表数据的时候 顺便把从表的数据也删除
);

ON DELETE SET NULL   --当删除主表数据的时候 把从表关联的字段设置为空。


--1.如果在没有设置其它主外键关系处理的时候 当子表存在记录时，主表对应的数据是不允许直接删除的
DELETE FROM STUDENTS WHERE S_ID=1;

ALTER TABLE SCORE ADD CONSTRAINT FK_SCORE_SID FOREIGN KEY(S_ID)
    REFERENCES STUDENTS(S_ID)
    ON DELETE CASCADE;


SELECT * FROM SCORE






