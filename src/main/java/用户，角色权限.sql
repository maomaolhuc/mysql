--用户管理（创建用户，修改用户（密码，是否锁定，权限），删除用户 ，给用户赋权）
CREATE USER SCOTT1 IDENTIFIED BY 123456  --建立用户

ALTER USER SCOTT1 IDENTIFIED BY 123456  --修改用户密码

GRANT CREATE SESSION TO SCOTT1;   --会话权限

--不可能每种权限都分别赋给用户 ，那样太繁琐太不方便 所有就有了角色
--角色（某些权限的集合）
--DBA 拥有所有的系统权限 包括配置表空间 授予其它权限

--创建角色
CREATE ROLE TESTROLE;
--给角色赋权
GRANT CREATE SESSION TO TESTROLE;
--把角色赋权给用户
GRANT TESTROLE TO SCOTT1;
--收回角色权限
REVOKE CREATE SESSION FROM TESTROLE;
--撤销权限
REVOKE SESSION FROM SCOTT1;

--删除用户
DROP USER SCOTT1; --只是删除了用户
DROP USER SCOTT1 CASCADE;  --  除了删除用户，还会删除用户所创建的对象（表，索引，存储过程） 必须离职会带走所有东西

--查询当前的用户角色权限
SELECT * FROM USER_ROLE_PRIVS;

--当前当前的用户权限
SELECT * FROM SESSION_PRIVS;







































