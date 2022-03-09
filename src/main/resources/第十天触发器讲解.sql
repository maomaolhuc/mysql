-- 数据库的表结构
   表 视图  索引。
   存储过程 函数  触发器  游标。

-- 触发器讲解

create table test1(
      tid int,
      tname varchar(100));

create table test2(
      tid int,
      tname varchar(100));

在数据插入 test1的时候，在test2中也备份一份。
insert  update  delete

create trigger test1_trigger
after insert on test1
for each row
begin
   insert into test2 values(new.tid,new.tname);
end;

-- 现在看看new(是个虚表，不真正存在于数据库)模仿的是谁的结构。
   模仿的是 给谁做触发器，就是谁的结构。

create table boy(
   bid  int(5),
   bname varchar(100),
   address varchar(100));
-- 当给boy表插入一条数据的时候，在记录表中插入两条数据

create table jilu(
   jname varchar(100),
   homeaddress varchar(100));

create trigger boy_trigger
after insert on boy
for each row
begin
  insert into jilu values(new.bname,new.address);
end;


-- 做删除的触发器
create trigger boy_triggerdel
before delete on boy
for each row
begin
   delete from jilu where jname=old.bname;
end;

truncate 不会做事务，所以不会触发delete触发器。

delete 删除全部 当然会触发 触发器。


做修改类型的触发器。

create table testjilu(
oldname varchar(100),
newname varchar(100));



做一个表 书表
create table book(
   bid varchar(100),
   bname varchar(100),
   price double(8,2),
   author varchar(100));

另外做一个书的备份表(bookcopy)，

create table bookcopy(select * from book where 1=2);
当book表中插入数据时，bookcopy表中也插入数据。
当book表中删除数据时，bookcopy表中也删除数据。
当book表中修改数据时，bookcopy表中也修改数据。

-- 账户表
create table bank(

   customername  varchar(100) not null,

   cardid char(10) not null,

   currentMoney double(10,2) not null
);

-- 注意：我如果给 bank表中插入一条数据 代表开户操作。

做一个操作表
create table caozuo(
username varchar(100),
cz varchar(100),
sj datetime default now());

-- 交易信息表
create table transinfo(

   cardid char(10) not null,

   transtype char(4) not null,

   transmoney double(10,2) not null,

   transdate  datetime default now()
);

-- 支取   存入

customername | cardid | currentMoney

create trigger transinfo_trigger
after insert on transinfo
for each row
begin
  declare jcardid  char(10);
  declare jtranstype char(4);
  declare jtransmoney double(10,2);
  set jcardid=new.cardid;
  set jtranstype=new.transtype;
  set jtransmoney=new.transmoney;
  if(jtranstype='支取') then
     update bank set currentMoney=currentMoney-jtransmoney
     where cardid=jcardid;
  else
     update bank set currentMoney=currentMoney+jtransmoney
     where cardid=jcardid;
  end if;
end;
















