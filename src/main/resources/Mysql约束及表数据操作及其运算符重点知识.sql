建立主键的方式。
第一种:
create table book(
    bid int primary key auto_increment,
    bname varchar(100)
);
-- 如果没有名字 默认和字段名相同。
第二种:
 create table book1(
    bid int,
    bname varchar(100),
    constraint pk_book1_bid primary key(bid)
);
pk_book1_bid 关系名。不写也可以 但是一般建议你写。

联合主键： 如果一个字段不能完全代表这一条记录 我们也可以用几个字段
           同时来做主键，来代表他唯一。
create table book(
    bid int(4),
    bname varchar(100),
    author varchar(100),
    constraint pk_book_lh primary key(bname,author)
);
如果表已经建好。
添加主键约束
alter table student add primary key(sid);
删除主键
alter table student drop primary key;

添加非空约束
alter table teacher modify sex char(1) not null;
删除非空约束。
alter table teacher modify sex char(1);
alter table teacher modify sex char(1) null;

添加唯一键约束
alter table book add unique(author);
alter table book add unique(author,pwd);

删除唯一键约束        index 字段名
alter table book drop index bname;

check约束 语法支持
 create table people(
    pid int primary key auto_increment,
    pname varchar(100),
    age int,
    check(age>20)
);

创建表

create table student(
     studentNo int(4) primary key auto_increment,
     loginpwd  varchar(100) not null,
     studentName varchar(100) not null,
     age  int(3),
     sex char(1) default '男',
     birdate datetime,
     comedate timestamp default now()
);
插入数据
insert into student(studentName,loginpwd) values('张三','123');
insert into student(studentName,loginpwd) values('李四','11'),('王五','22'),('赵六','33');

创建表的语法：
  标准Sql都一样。
  create table 表名(列1 数据类型,列2 数据类型,列3 数据类型)；

  类型创建。
  Mysql(有) Oracle(有) SqlServer(有)。
  写法不一样。
  复制一个表
  create table studentnew(select * from student);

  复制部分字段和 部分记录。
  create table studentnew(select studentname,loginpwd from student where sex='男');

  复制字段，但是不要表中的数据。
  create table studentnew(select * from student where 1=2);

Sql语句有书写 顺序

   select 字段
   from  表名
   where 过滤条件

update修改数据
update student set age=20 where studentname='范冰冰';

like模糊查询
% 表示0到多个字符。
select * from student where studentname like '刘%';
_ 表示任意一个字符。










