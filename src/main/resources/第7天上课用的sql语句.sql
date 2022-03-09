建立一个视图 首先按照 工资的从大到小排序

create view empfz_view
as
select *
from empfz
order by salary desc
视图的本质 是按照从大到小

再在视图上加一个排序  按照从小到大排
select * from empfz_view
order by salary asc






1 找到员工表中工资最高的员工 的 姓名 和工资?

  select ename,salary
  from emp
  where salary=(select max(salary) from emp);

  select ename,salary
  from emp
  where salary=(select salary from emp order by salary desc limit 1);



2  查询出 每个部门中哪些人的薪水最高 ，
   然后求出这些人姓名,工资？

   a  求出每个部门的最高工资？

     select  *
     from emp e,
     (select deptid, max(salary) maxsalary
     from emp
     group by deptid) t
     where e.deptid=t.deptid and e.salary=t.maxsalary

   b 和原表关联。
     select  *
     from emp e inner join
     (select deptid, max(salary) maxsalary
     from emp
     group by deptid) t
     on e.deptid=t.deptid and e.salary=t.maxsalary


 创建视图

    create view 视图名
    as
    select 语句。
创建一个复杂视图？
 create view emp_view1
 as
 select deptid,avg(salary) pjsalary
 from emp
 group by deptid

查询每个部门中工资最高的人的信息。
要求 显示 人名，工资 ，部门名称。
--速度快。
create view emp_view3
as
select e.ename,e.salary,d.dname
from emp e,dept d
where e.deptid = d.deptid
and e.salary =
(select max(salary) from emp
where deptid = e.deptid)

-- 理解简单点。
select tt.ename,tt.maxsalary,d.dname
from dept d,
(select e.ename,t.maxsalary,t.deptid
from emp e,(
select max(salary) maxsalary ,deptid
from emp
group by deptid) t
where e.salary=t.maxsalary and e.deptid=t.deptid) tt
where d.deptid=tt.deptid
















  select ename,salary
  from emp
  order by salary desc limit 1;

update emp set salary=30009
where eid=5;
