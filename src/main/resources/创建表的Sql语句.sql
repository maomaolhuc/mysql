-- 创建一个表 sid 做主键 并且 自增
create table student(
    sid int primary key auto_increment,
    sname varchar(100),
    sex char(1) default '男',
    bir timestamp default current_timestamp()
);
insert into student(sid,sname,sex,bir) values(1,'','','');
drop table studnet;

-- 修改表结构
-- 添加一列  alter table 表名  add 字段名 字段类型;
-- 删除一列  alter table 表名  drop 字段名;
-- 修改一列：
   有两种写法:
   第一种：如果你只修改长度:alter table student modify 字段名 varchar(1000);
   第二种：修改字段名 还有字段的类型。
          alter table student change 老字段名 新字段名 新字段数据类型。

