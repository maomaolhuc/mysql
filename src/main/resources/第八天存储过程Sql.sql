1 分隔符  为了防止编译器执行;

  delimiter //
  create procedure first()
     begin
     select '你好,学习mysql的同学';
     select '为什么不好';
     end;
   // delimiter;
  调用 call first();
2 做一个输入参数的列子

  delimiter //
    create procedure second(in id int)
      begin
      select id;
      end;
  // delimiter;
  调用 call second(100);
3  可以传入 varchar 类型的值。
  delimiter //
    create procedure proc1(in name varchar(100))
    begin
    select name;
    set name='好好听课';
    select name;
     end;
  // delimiter;
  调用 call proc1('你好');

4  传入两个存储过程

  delimiter //
    create procedure proc2(in name varchar(100),in age int)
    begin
    select concat(name,'的年龄是',age);
    end;
  // delimiter;

5 两个参数 ，一个传入参数 一个传出参数。
  BEGIN
   select ename into name from emp where eid=id;
  END
  调用的时候
  传入参数 要先 申明  set  @name='';
  call 名字(1,@name);

  BEGIN
  set name=(select ename from emp where eid=id);
  END

条件语句。
if  then  else  end if;
不传入参数。
BEGIN
  declare a int;
  set a=100;
  if a>=10 THEN
  select 'a是大于等于10的';
  ELSE
  select 'a是小于10的';
  end if;
END

写 我有一个传入参数。然后你判断传入参数是不是大于10


做题 用 case when then else 。
先创建一个表
create table xuesheng(
   name varchar(100),
   level char(10)); 优 良  中  差


BEGIN
	case cj
  when 100 THEN
  insert into xuesheng values(name,'优');
  when 90  THEN
  insert into xuesheng values(name,'优');
  when 60  THEN
  insert into xuesheng values(name,'中');
  else
  insert into xuesheng values(name,'其他');
  end case;
END

讲解 while 循环？

做两个参数 一个传入参数 一个传出参数
BEGIN
  declare i int;
  declare sum int;
  set i=0;
  set sum=0;
  while i<=max  DO
    set sum=sum+i;
    set i=i+1;
  end while;
  set he=sum;
END


插入 10000行数据

BEGIN
  declare i int;
  set i=1;
	while i <= 10000 do
  insert into ceshi values(i,'张三');
  set i= i+1;
  end while;
END

用repeat 求和 这是先执行，再判断

BEGIN
  declare i int;
  declare he int;
  set i=0;
  set he=0;
  repeat
    set he=he+i;
    set i=i+1;
    until i>100
  end repeat;
  select he;
END


课后题
BEGIN
   if cj>=90 and cj<=100 THEN
   insert into xuesheng values(name,'优');
   end if;
   if cj>=80 and cj<90 THEN
   insert into xuesheng values(name,'良');
   end if;
   if cj>=60 and cj<80 THEN
   insert into xuesheng values(name,'中');
   end if;
   if cj>=0 and cj<60 then
   insert into xuesheng values(name,'差');
   end if;
END


BEGIN
  case floor(cj/10)
  when 10 THEN
  insert into xuesheng values(name,'优');
  when 9 THEN
  insert into xuesheng values(name,'优');
  when 8 THEN
  insert into xuesheng values(name,'良');
  when 7 THEN
  insert into xuesheng values(name,'中');
  when 6 THEN
  insert into xuesheng values(name,'中');
  ELSE
  insert into xuesheng values(name,'差');
  end case;
END









