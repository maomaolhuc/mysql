------------------------------第四天剩余Sql语句
-- 员工表
-- 工号、姓名、年龄、性别、薪资、部门
-- 工号为主键  姓名不能为空

改改改 做自连接 员工表 deptid 代表员工的部门号
create table emp(
   eid int(5) primary key auto_increment,
   ename varchar(100) not null,
   sex char(1) default '男',
   salary double(8,2),
   deptid  varchar(100),
   leaderid  int,
   birdate  timestamp,
   income timestamp default now()
)
-- 1  统计有几个部门
      a 种写法
      select count(distinct(deptid))  from emp;
      b 种写法  其实任何一个查询 结果你都可以把它当成一个表
      select count(*)
      from
      (select deptid
      from emp
      group by deptid) tttt
  2  统计 年龄大于等于28(如果是 28.7 按28截取)  的各部门 有多少人。

     第一步 得出每个人的年龄
     select ename, round(datediff(now(),birdate)/365) from emp;
     第二部  统计
     select deptid,count(*) he
     from emp
     where round(datediff(now(),birdate)/365)>=28
     group by deptid
     order by he desc

create table tt(
     tid int primary key auto_increment,
     tname varchar(100)
    )engine=innodb auto_increment=1000 default charset=utf8;


1001 董事会 马云
1002 开发部  张三（经理）  张三丰  张无忌(员工)
1003 测试部  范冰冰(经理)  范伟   范桶(员工)
1004 行政综合部  刘亦菲(经理) 刘能
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('马云','男',1,1001,null,'1978-09-09','2003-07-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('张三','男',30009,1002,1,'1988-09-09','2003-09-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('张三丰','男',20000,1002,2,'1998-09-09','2013-07-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('张无忌','男',10000,1002,2,'1989-09-09','2006-07-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('马云','男',1,1001,null,'1978-09-09','2003-07-12')

insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('范冰冰','女',19800,1003,1,'1988-09-09','2003-09-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('范伟','男',9800,1003,5,'1999-09-09','2013-09-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('范桶','女',8800,1003,5,'1999-09-09','2013-09-12');

insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('刘亦菲','女',19800,1004,1,'1988-09-09','2003-09-12');
insert into emp(ename,sex,salary,deptid,leaderid,birdate,income)
values('刘德华','男',8800,1004,8,'1988-09-09','2003-09-12');



-- 新建一个部门表
create table dept(
   deptid int,
   dname varchar(100),
   createtime timestamp
)
1001 董事会 马云
1002 开发部  张三（经理）  张三丰  张无忌(员工)
1003 测试部  范冰冰(经理)  范伟   范桶(员工)
1004 行政综合部  刘亦菲(经理) 刘能
insert into dept values(1001,'董事会','2001-01-01');
insert into dept values(1002,'开发部','2003-04-01');
insert into dept values(1003,'测试部','2005-07-11');
insert into dept values(1004,'行政综合部','2003-01-01');






-------------------------------第五天Sql语句。

-- 老师表
create table teacher(
   tid  int(5) primary key auto_increment,
   tname varchar(100) not null,
   age  int,
   phone char(11)
)engine=INNODB
insert into teacher(tname,age,phone) values('张三',54,'18919900000');
-- 课程表  查询那些老师没有代课。老师的姓名，年龄。
--     哪些老师带课了。
    select distinct(t.tname) ,t.age
    from teacher t inner join course c
    on t.tid=c.tid
  --哪些老师没有代课
    select t.tname,t.age,c.cname
    from teacher t left join course c
    on t.tid=c.tid
    where c.cname is null
-- 老师表
create table course(

       cid int(5) primary key auto_increment,
       cname varchar(100),

       score int(2),

       tid int(5),

       constraint fk_tid_cou foreign key (tid)
       references teacher(tid)

)engine=innodb auto_increment=1001 default charset=utf8;
-- 查询所有老师带的课程  如果没有带课程 也显示出来。
select  t.tname ,c.cname
from teacher t left join course c
on t.tid=c.tid

--右外连接
select  t.tname ,c.cname
from teacher t right join course c
on t.tid=c.tid

--内连接
select c.cname,c.score,t.tname
from course c inner join teacher t
on c.tid=t.tid
--内连接
select c.cname,c.score,t.tname
from course c,teacher t
where c.tid=t.tid










