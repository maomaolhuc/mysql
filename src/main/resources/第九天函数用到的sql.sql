1 补 存储过程 用 if elseif 的示例。

  要求这个存储过程传入两个参数 姓名 ,成绩。
  你给成绩表（chengji）中保存 姓名和等级。

BEGIN
  if cj>=90 and cj<=100 THEN
  insert into xuesheng values(name,'优');
  elseif cj>=80 and cj<90 THEN
  insert into xuesheng values(name,'良');
  elseif cj>=60 and cj<80 THEN
  insert into xuesheng values(name,'中');
  else
  insert into xuesheng values(name,'差');
  end if;
END

2 找出姓张的人，用三种写法。
  select * from emp where left(ename,1)='张';

  select * from emp where substring(ename,1,1)='张';

  select * from emp where ename like '张%';

3 delimiter //
  ;表示结束。
  当你下次再遇到// 表示我 编程结束。

  delimiter ##
  create function fun1()
  returns varchar(100)
  begin
  return '汪峰的无处安放';
  end;
  ## delimiter


4 有传入参数的  根据传入时间 算出年月日 时分秒。

  delimiter //
  create function tz.formatmydate(mydate datetime)
  returns varchar(100)
  begin
    declare x varchar(100) default '';
    set x=date_format(mydate,'%Y年%m月%d日%h时%i分%s秒');
    return x;
  end
  // delimiter

5 马上要到 3 8 妇女节了，我要给妇女们发礼物。
  对员工有两个要求 1 女，  2  age>=25算妇女

  delimiter //
  create function tz.flw(sex char(1),bir datetime)
  returns varchar(100)
  begin
    declare res varchar(100) default '';
    if sex='女' and ceil(datediff(now(),bir)/365)>=25 then
    set res='发礼物';
    else
    set res='不发礼物';
    end if;
    return res;
  end
  // delimiter

6 发年终奖。
  写一个函数,传入两个参数，第一个参数是 性别，
  第二个参数 是出生日期 ，
  然后你给我返回  '发礼物' or '不发礼物'


   传入员工的入职日期 返回 员工发的年终奖钱数

   >=10  发10万

   入职年数>2 and 入职年数<10  发5万

   其他 发1万


BEGIN
  declare res varchar(100) default '';
  declare riqi int default 0;
  set riqi=round(datediff(now(),rq)/365);
  if riqi>=10 THEN
  set res='发10万';
  elseif riqi>=2 and riqi<10 THEN
  set res='发5万';
  else
  set res='发2万';
  end if;
  RETURN res;
END


7 判断你的字符的长度和你输入的长度是否一致，让你猜。
  如果你传入的长度大了 就输出猜大了。
  如果你闯入的长度小了 就输出猜小了。否则就是对了。

  funcd('我爱北京天安门，我也爱北京的姑娘',5);
  猜小了
  funcd('我爱北京天安门，我也爱北京的姑娘',115);
  猜大了

  不是要多少个字节？
  length() 返回字节数。
  char_length() 返回有几个字符。

BEGIN
	declare x varchar(100) default '';
  declare len int default 0;
  set len=CHAR_LENGTH(str);
  if len>num THEN
  set x='猜小了';
  elseif len<num THEN
  set x='猜大了';
  ELSE
  set x='猜对了';
  end if;
  return x;
END


第8题。
传入两个参数  第一个参数是 要处理的字符串
第二个参数是你要找的字符串。



funcs('姐抽的不是烟，姐抽的是寂寞','寂寞');


如果没有出现 返回0次。


出现几次就是出现几次。

BEGIN
  declare cishu int default 0;
  declare oldcd int default 0;
  declare newcd int default 0;
  set oldcd=(select CHAR_LENGTH(str));
  set str=replace(str,key1,'');
  set newcd=(select CHAR_LENGTH(str));
  set cishu=(oldcd-newcd)/CHAR_LENGTH(key1);
  RETURN cishu;
END


10  求1 到某个传入值之间的偶数的和。

BEGIN
  declare sum int default 0;
  declare i int default 0;
  while i<=num  DO
    if i%2=0 THEN
    set sum=sum+i;
    end if;
    set i=i+1;
  end while;
  RETURN sum;
END



11 求一个验证码的函数。

BEGIN
  declare arr varchar(1000) default '';
  declare resu varchar(100) default '';
  declare zifu varchar(10) default '';
  declare weizhi int default 0;
  set arr='ABCDEFGHIGKLMNabcdefghigklmn1234567890';
  while CHAR_LENGTH(resu)<cd DO
  set weizhi=floor(rand()*CHAR_LENGTH(arr));
  set zifu=substring(arr,weizhi,1);
  set resu=CONCAT(resu,zifu);
  end while;
  RETURN resu;
END










