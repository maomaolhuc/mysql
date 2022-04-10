/*
	表空间是数据库最大的逻辑单元，一个Oracle数据库至少包含一个表空间，
	就是名为SYSTEM的系统表空间。
	每个表空间是由一个或多个数据文件组成的，一个数据文件只能与一个表空间相关联。
	在oracle中所有的表都存储在表空间中。
	参考:素材/Oracle存储结构简单介绍.jpg
*/
/*============================================================
                      创建user1_tablespace表空间
  ============================================================*/
-- 注意:创建表空间需要对应的(create tablespace)权限
CREATE TABLESPACE user1_tablespace --表空间名称
DATAFILE 'E:\user1.DBF'  --路径名称
SIZE 100M    --是指定该数据文件的大小，也就是表空间的大小。
AUTOEXTEND ON NEXT 32M MAXSIZE UNLIMITED   --大小自动扩展，没有最大限制
LOGGING --logging 表示在创建表空间时，将生成日志记录
EXTENT MANAGEMENT LOCAL  --表示创建的表空间采用"本地化"方式管理
SEGMENT SPACE MANAGEMENT AUTO; --设置表空间中段的管理方式为自动；

--取默认设置创建user1_tablespace表空间
CREATE TABLESPACE user1_tablespace
DATAFILE 'E:\user1.DBF'
SIZE 100M;

/*============================================================
                      创建user1用户并指定表空间
============================================================*/
CREATE USER user1
IDENTIFIED BY user1
DEFAULT TABLESPACE user1_tablespace;

--查看用户对应的默认表空间
SELECT USERNAME, DEFAULT_TABLESPACE FROM DBA_USERS where USERNAME='JACK';


--修改用户的默认表空间
alter user jack default tablespace user1_tablespace;

--查看表空间的名称及大小
SELECT t.tablespace_name, round(SUM(bytes / (1024 * 1024)), 0) "ts_size(M)"
FROM dba_tablespaces t, dba_data_files d
WHERE t.tablespace_name = d.tablespace_name
GROUP BY t.tablespace_name;
--查看表空间物理文件的名称及大小
SELECT tablespace_name,
       file_id,
       file_name,
       round(bytes / (1024 * 1024), 0) total_space
FROM dba_data_files
ORDER BY tablespace_name;

--查看表空间的使用情况
SELECT SUM(bytes) / (1024 * 1024) as "free_space(M)", tablespace_name
FROM dba_free_space
GROUP BY tablespace_name;

/*
      在ORACLE 9i数据库中，创建数据库用户时，如果没有指定默认的永久性表空间，
      则系统使用SYSTME表空间分别作为该用户的默认永久表空间，默认的临时表空间为TEMP。
      在ORACLE 10/11g中，如果不指定默认永久性表空间，则是USERS.
*/
--调整表空间
--增加数据文件
ALTER TABLESPACE user1_tablespace
ADD DATAFILE 'E:\user1_add.DBF' --添加数据文件
SIZE 100M   --大小100M
AUTOEXTEND ON -- 大小自动扩展
NEXT 10M --扩展的增量为10M
MAXSIZE 1024M; --最大扩展到1024M

--修改数据文件的大小
ALTER DATABASE DATAFILE 'E:\user1_add.DBF' -- 文件路径

RESIZE 50M;
--删除数据文件
ALTER TABLESPACE user1_tablespace

DROP DATAFILE 'E:\user1_add.DBF'
