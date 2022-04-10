
select sex,count(*) '总人数',group_concat(studentname)
from student
group by sex;

-- WITH ROLLUP演示。
select sex,count(*)
from student
group by sex with rollup;


select ifnull(sex,'总和'),count(*)
from student
group by sex with rollup;

-- 找出姓张的人。
 select *
 from student
 where left(studentname,1)='张';

select *
from student
where substring(studentname,1,1)='刘';









