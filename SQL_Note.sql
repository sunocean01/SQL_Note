-- 数据库的操作
	-- 启动/关闭数据库
		-- 1. 计算机管理/服务和应用程序/服务: 找到MySQL80/属性/启动(关闭)  #这个地方也查到"服务名称",比如MySQL80
		-- 2. 计入DOS命令,输入: net start mysql80 或 net stop mysql80     #注意"mysql80"是服务名称,在第一步中可以查到
	
	-- 导入外部的sql数据
		1. cmd 窗口输入: mysql -uroot -p -t < employees.sql
		2. 进入mysql:
			use python_test;  -- 选择要导入数据的数据库
			show tables:  -- 检查数据表, 数据表事先要要建好, 比如 areas表
			source areas.sql:
		
	-- 连接数据库: 命令行输入: 
	mysql -uroot -p
	mysql -uroot -ppassword
	
	-- 退出:  
	exit/quit/Ctrl+d
	
	-- 查看数据库,分号结尾,即使已经enter: 大小写不区分
	show databases;
	show databases like "py%";  --模糊查询,显示'py'开头的数据库名称
		
	-- 显示时间
	select now()
		
	-- 查询数据库版本:
	select version();
	
	-- 创建数据库
	-- create database 数据库名 charset=utf8
	create database python04;
	create database python04new charset=utf8;   -- 默认时 latin
	
	-- 查看创建数据库的语句
	-- show create database ...
	show create database python04;
	
	-- 删除数据库
	-- drop database ...
	drop database python04;    -- show databases
	drop database `python-04`;  -- 如果中间有 - ,需要用 ``:Tab键上面的那个撇;
	
	-- 查看当前使用的数据库
	select database();
	
	-- 使用数据库
	-- use 数据库名
	use python04;
	
-- 数据表的操作
	
	-- 查看当前数据中的所有数据表
	show tables;
	show tables like "s%"
	
	-- 创建数据表
	-- auto_increment: 表示自动增长
	-- not null: 表示不能为空
	-- primary key: 表示主键
	-- default: 默认值
	-- create table 数据表名 (字段 类型 约束[,字段 类型 约束])
	create table classes(id int, name varchar(30))
	
	-- 创建classes表(id, name)
	create table classes2(id int unsigned primary key not null auto_increment,
						name varchar(30)
						);
	-- Practice: 创建students表
	create table students(
						id int unsigned not null auto_increment primary key,
						name varchar(30),
						age tinyint unsigned,
						high decimal(5,2),
						gender enum("男","女","中性","保密") default "保密",
						cls_id int unsigned      -- 最后一个不需要',',否则报错
						);
	
	-- 查看表的结构
	-- desc 表名
	desc classes;
	describe students;
	show columns from students;
	
	-- 插入数据
	insert into students values(0,"老王",18,188.88,"男",0);  --
	
	-- 查询数据
	select * from students;
	
	-- 查看table的创建过程: 仔细观察它的创建过程和自己写的有什么不同
	show create table students;
	
	-- 修改表结构: alter table xxx
		-- 添加字段
		alter table students add birthday datetime;
		alter table students add address varchar(80) after gender;  -- 指定位置追加
		alter table students add school varchar(30) first;    		-- 追加在首列;
		
		-- 修改字段: 不重命名, 只修改数据类型
		alter table students modify birthday date;

		-- 修改字段: 重命名
		alter table students change birthday birth date default "1990-01-01";
		
		-- 删除字段: 值也会被删掉
		alter table students drop high;
		
		-- 删除表
		-- drop table 表名
		drop table students;
		
-- 增删改查
	-- 增加
		-- 全列插入
			-- intsert [into] 表名 values(...)
			-- 主键字段可以用 0 null default 来占位
			-- 向classes表中插入一个班级
			insert into classes values(0,"菜鸟班");  -- 全部插入,及 values里的个数要个表里的字段个数一致
			
			-- 向students表插入一个学生信息
			insert into students values(0,"小李飞刀",20,'男',1,"1990-01-01");
			insert into students values(null,"小李飞刀",20,'男',1,"1990-01-01");
			insert into students values(default,"小李飞刀",20,'男',1,"1990-01-01");
			
			insert into students values(0,"小李飞刀",20,1,1,"1990-01-01");   -- 枚举的下标从1开始
			insert into students values(0,"小李飞刀",20,2,1,"1990-01-01");
			insert into students values(0,"小李飞刀",20,3,1,"1990-01-01");
		
		-- 部分插入
		insert into students (name,gender) values ("小乔","女");
			
		-- 多行插入
		insert into students (name,gender) values ("小乔","女"),("大乔","女");
		insert into students values (0,"小乔",15,"女",1,"2022-10-06"),(0,"大乔","男",18,"女",1,"2022-10-06");
	
	-- 修改
		update students set gender="男";    -- 全部都改
		update students set gender="男" where name="小乔";   -- 符合条件的被修改
		update students set gender="男" where id=3;   -- 符合条件的被修改
		update students set age=30, gender="男" where id=3;   -- 同时修改两个字段的内容
		
	-- 删除
		-- 物理删除: delete from 表名 where
		delete from students;    -- 删除整个数据表
		delete from students where name='小李飞刀';
		
		-- 逻辑删除: 用一个字段表示,这条信息已经不再使用: 
		-- 给students表添加一个 is_delete字段bit类型
		alter table students add is_delete bit default 0;
		update students set is_delete=1 where id=11;
		select * from students where is_delete=0;   -- 按条件查询,
		

	-- 查询基本使用
		-- 查询所有列   select * from 表名
		select * from students;
		
		-- 按条件查询
		select * from students where name = "大乔";
		select * from students where id>6;
		
		-- 查询指定字段: 
		select name,gender from students;
		select students.name,students.gender from students;
		select s.name, s.gender from students as s;
		select students.name, students.gender from students as s;   -- 失败的
		
		-- as为列或表指定别名: select 字段[as 别名] from 数据表 where ...
		select name as 姓名, gender as 性别 from students;
		
		-- 字段顺序: 结果的顺序就是select的顺序
		select gender as 性别,name as 姓名 from students;
		
		-- 去重查询: distinct 字段
		select distinct gender from students;
		
		-- concat: 拼接
		select concat(name,':',age) from students;
		select name, concat(age,':',height) from students;
		
	-- 条件查询: 
		-- 比较运算符: >,<,>=,<=,=,!=/<>
		-- 逻辑运算符: and, or, not, 
		select * from students where age>18 or heigh >188;
		
		select * from students where age>18 and heigh >188;
		
		select * from students where not age>18 and gender="女";    -- 不在18岁以上, 且是女性
		select * from students where not (age>18 and gender="女");  -- 不在18岁以上的女性
		select * from students where (not age>18) and gender="女";  -- 不在18岁以上, 且是女性
		
	-- 模糊查询: 
		-- like:
		-- % 替代1个或多个
		-- _替代1个
		select name from students where name=like "小%";  -- 以"小"开头的名字
		
		-- 查询名字中有"小"的所有名字
		select name from students where name=like "%小%";
		
		-- 查询有两个字的名字
		select name from students where name like "__";  -- "__%":两个以上的
		
		-- rlike 正则
		select name students where name rlike "^周.*";  -- 以"周"开头的
		
	-- 范围查询
		-- in (1,3,8) 表示在一个非连续的范围内
		select name,age from students where age in (18,34,12);
		
		-- not in:
		select nam,age from students where age not in (12,18,34);
		
		-- between ... and ... :表示在一个连续范围内
		select name,age from students where age between 18 and 34;
		select name,age from students where age not between 18 and 34;   -- 不能写成 not (between 18 and 34)
		select name,age from students where not age between 18 and 34;   -- 也可以
		
		-- 空判断
			-- 判空 is null
			select * from students where heigh is null;
			
			-- is not null
			select * from students where heigh is not null;
		
	-- 排序查询
		order by: 排序;支持多个字段
		asc: 从小到大排;可以省略
		desc: 从大到小排;
		select * from students where (age between 18 and 30) and gender=1 order by age asc; 
		
		order by 多个字段
		select * from students where (age between 18 and 30) and gender=1 order by age asc,heigh desc; 
		
	
	-- 聚合函数
		count: 个数
		select count(*) from students where gender=1;
		select count(*) as male_Qty from students where gender=1;
		
		max: 最大值
		select max(age) from students;
		
		min: 最小值
		select min(age) from students;
		
		sum: 求和
		select sum(age) from students;
		
		avg: 平均值
		select avg(age) from students;
		
		表达式计算:
		select sum(age)/count(age) from students;
		
		round: 四舍五入
		select round(avg(age),2) from students;
	
	-- 分组: group by
		-- 按照性别分组,查询所有性别
		select gender from students group by gender;
		
		-- 计算每组性别种的人数
		select gender,count(*) from students group by gender;
		
		-- 可以对 group by之后的表使用上面所有的聚合函数
			select gender,max(age) from students group by gender;  -- 查每组中年龄最大值
			select gender,group_concat(name) from students group by gender;  -- 查询每组中有哪些人
			
		-- 计算男性的人数
		select gender,count(*) from students where gender=1 group by gender;
		
		-- with rollup: 在分组统计数据的基础上再进行统计汇总
		select gender, count(*) from students with rollup;
		
		-- group_concat: 查询每组中的指定内容
		select gender,group_concat(name) from students group by gender;
		select gender,group_concat(name,age,id) from students group by gender;
		select gender,group_concat(name,"_",age,id) from students group by gender;
		
		--having: 对分组进行条件判断
			-- 查询平均年量超过30的性别,以及姓名 having avg(age)>30
			select gender,group_concat(name),avg(age) from students group by gender having avg(age)>30;
			
			-- 查询每种性别中的人数多于2的信息
			select gender,group_concat(name) from students group by gender having count(*)>2;
			
	-- 分页: limit 在语句的最后
		-- limit 2: 限制查询出来数据的个数
		select * from students where gender=1 limit 2;
		
		-- limit 2,6: 2是起始位置, 6是要查的个数 
		select * from students limit 0,5;
		
		-- limit (第N-1页)*每页的个数,每页的个数
		limit 2;
		where gender=2
		order by age
		
	-- 连接查询
		-- inner join ... on
		-- left: 左链接
		-- right: 右链接
		
		-- 查询 有能够对应班级的学生以及班级信息
		select * from students inner join classes on students.cls_id=classes.id;
		
		-- 按照要求显示姓名,班级
		select students.*,class.name inner join classes on students.cls_id=classes.id;
		
		-- 给数据表起名
		select s.name,c.name from students as s inner join classes as c on s.cls_id=c.id;
		
		-- 查询,有能够对应班级的学生以及班级信息,显示学生的所有信息,只显示班级名称
		select s.*,c.name from students as s inner join classes as c on s.cls_id=c.id;
		
		-- 将班级的名字放在第一列
		select c.name,s.* from students as s inner join classes as c on s.cls_id=c.id;
		
		-- 上一条,按照班级进行排序
		select c.name,s.* from students as s inner join classes as c on s.cls_id=c.id order by c.name;
		select c.name,s.* from students as s inner join classes as c on s.cls_id=c.id order by c.name,s.id;
		
		-- 查询没有对应班级信息的学生
		-- select ... from xxx as s left join xxx as c on .... where ....
		-- select ... from xxx as s left join xxx as c on .... having....
		select * from students as s left join classes as c on s.cls_id=c.id having c.id is null;
	
	-- 自关联
		-- 一张表,包括全国所有的省份以及下属的市,县/区,...
		-- 表结构: id,atitle,pid
		-- 查询上海市下面所有的区
		select * from areas as provice inner join areas as city on city.pid=provice.id having provice.atitle="上海市";
		select provice.atitle,city.atitle from areas as provice inner join areas as city on city.pid=provice.id having provice.atitle="上海市";
	
	-- 子查询: 一个select里面嵌套另一个select
		-- 查询最高的男生信息:
			select * from students where height=(select max(height) from students);
	
		
		
		
create table students(
id integer primary key autoincrement,
name varchar(30) not null,
gender varchar(20),
age tinyint);	
	