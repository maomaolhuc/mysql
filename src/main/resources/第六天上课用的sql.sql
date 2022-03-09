--1  找到员工表中工资最高的员工的姓名和工资。

   select ename,salary
   from emp e
   where e.salary=(select max(salary) from emp)

   select ename,salary from emp order by salary desc limit 1;


--2  找出员工表中年龄大于20岁且工资大于2万的人的姓名和工资。
   select ename,salary
   from emp
   where salary>20000 and round(datediff(now(),birdate)/365)>20


--1、查询每个部门中谁的工资最高，显示人的姓名和工资。
    a 找出每个部门的最高工资
      select ename,salary
      from emp
      where salary in(
      select max(salary)
      from emp e
      group by e.deptid)

     不对  10000  20000   30000 分部门



-- 2  开发部有哪些人。 只知道 部门叫开发部。
    select *
    from emp
    where deptid=(select deptid from dept where dname='开发部')


 3  哪些人是员工。你没有下属 你就是员工。
    select *
    from emp e
    where e.eid not in
    (select distinct(leaderid) from emp where leaderid is not null )

5  谁和张三是同部门的，列出除了张三之外的人的姓名?

   select *
   from emp e
   where e.deptid=(select deptid from emp where ename='张三')
         and ename<>'张三'


7 找出公司中工资在第5和第6位的人的姓名和工资。从高到低。
  select *
  from emp e
  order by e.salary desc limit 4,2

7 统计哪个部门的平均工资高于公司的平均工资,
  求出该部门的名称和平均工资。
  select d.dname,tt.pj
  from
  (select t.deptid, t.pj
  from
  (select deptid,avg(salary) pj
  from emp
  group by deptid) t
  where t.pj>(select avg(salary) from emp)) tt inner join dept d
  on tt.deptid=d.deptid






找那些老师住的地方分部着我们的学生。找出这些老师的姓名。
select t.tname
from teacher t
where t.address in(select address from student)

select t.tname
from teacher t
where not exists(select * from student s
             where t.address=s.address)


找每个学生分别选修了什么课程，老师是谁？ 内连接。
select s.sname,c.cid,c.cname,t.tname
from student s,course c,teacher t
where s.courseid=c.cid and c.tid=t.tid

select s.sname,c.cid,c.cname,t.tname
from student s inner join course c inner join teacher t
on s.courseid=c.cid and c.tid=t.tid





找每个人的领导 ，如果没有领导,显示无领导。

select e.ename, ifnull(leader.ename,'无领导')
from emp e left join emp leader
on e.leaderid=leader.eid





create table boy(
   boyid  int primary key auto_increment,
   bname varchar(100) not null,
   age int,
   xdid int
);
-- 内连接 匹配两张表中匹配的数据 有两种写法
一种是 , where 的形式来写。
select b.*,g.*
from boy b,girl g
where b.xdid=g.grilid

select b.*,g.*
from boy b inner join girl g
on b.xdid=g.grilid

-- 外连接 只有一种写法
-- 外连接 偏向那边 就会把那边的数据全部查询出来
select b.*,g.*
from boy b left join girl g
on b.xdid=g.grilid
union all
select b.*,g.*
from boy b right join girl g
on b.xdid=g.grilid


insert into boy(bname,age) values('贾乃亮',38);
insert into boy(bname,age) values('谢霆锋',48)
insert into boy(bname,age) values('刘德华',58)
insert into boy(bname,age) values('刘能',51)
insert into boy(bname,age) values('赵四',48)
insert into boy(bname,age) values('王宝强',41)
create table girl(
   grilid int primary key auto_increment,
   gname varchar(100) not null,
   age int,
   xdid int
)auto_increment=101
insert into girl(gname,age) values('李小璐',32)
insert into girl(gname,age) values('唐嫣',38)
insert into girl(gname,age) values('马蓉',30)
insert into girl(gname,age) values('凤姐',39)
insert into girl(gname,age) values('赵丽颖',34)
insert into girl(gname,age) values('芙蓉姐姐',42)














1 建立老师表

  create table teacher(
     tid int(5) primary key auto_increment,
     tname varchar(100)  not null,
     age int(4),
     address varchar(100),
     courseid int
  )engine=innodb auto_increment=101

 insert into teacher(tname,age,address) values('马云',54,'杭州')
insert into teacher(tname,age,address) values('赵本山',64,'沈阳')
insert into teacher(tname,age,address) values('刘强东',44,'北京')
 create table student(
    sid int(5) primary key auto_increment,
    sname varchar(100) not null,
    age int(4),
    address varchar(100),
    courseid int,
    constraint fk_stu_cid foreign key (courseid)
       references course(cid)
 )engine=innodb

  insert into student(sname,age,address,courseid)values
  ('小沈阳',22,'沈阳',1003)
insert into student(sname,age,address,courseid)values
  ('刘能',52,'黑龙江',1003)
insert into student(sname,age,address,courseid)values
  ('王宝强',22,'北京',1002)
insert into student(sname,age,address,courseid)values
  ('小海子',20,'兰州',1002)

 create table course(
    cid int(5) primary key auto_increment,
    cname varchar(100),
    xuefen int(4),
    tid int,
    constraint fk_course_tid foreign key (tid)
       references teacher(tid)
 )engine=innodb auto_increment=1001

 insert into course(cname,xuefen,tid) values('C++',3,101)
insert into course(cname,xuefen,tid) values('Java',5,101)
insert into course(cname,xuefen,tid) values('相声表演',2,102)
insert into course(cname,xuefen,tid) values('电子商务',3,103)

 select t.tname
 from teacher t
 where exists
       (select *
        from student s
        where t.address=s.address
      )

 select t.tname
 from teacher t
 where t.address in(select address from student)





