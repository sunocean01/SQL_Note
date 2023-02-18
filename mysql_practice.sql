https://blog.csdn.net/weixin_64122448/article/details/124235492

1. 创建数据表:
create table fruits (f_id varchar(8) not null primary key,
					 s_id int not null,
					 f_name varchar(20) not null,
					 f_price decimal(10,2) not null
					 );

insert into fruits (f_id,s_id,f_name,f_price) values('a1',81,'apple',5.2), 
													('b1',81,'blackberry',8.2), 
													('bs1',82,'orange',11.2), 
													('bs2',85,'melon',8.2), 
													('t1',82,'banana',8.3), 
													('t2',82,'grape',5.3), 
													('o2',83,'coconut',9.2), 
													('c0',81,'cherry',3.2), 
													('a2',83,'apricot',2.2), 
													('l2',84,'lemon',6.4), 
													('b2',84,'berry',7.6), 
													('m1',86,'mango',15.6), 
													('m2',85,'xbabay',2.6), 
													('t4',87,'xbababa',3.6), 
													('m3',85,'xxtt',11.6), 
													('b5',87,'xxxx',3.6);

create table suppliers (s_id int not null auto_increment primary key,
						s_name varchar(50) not null,
						s_city varchar(20) null,
						s_zip varchar(20) null,
						s_call varchar(15) not null						
						)

create table orders (o_num int not null auto_increment primary key,
					 o_date datetime not null,
					 c_id int not null
					 );
					 
insert into orders (o_num,o_date,c_id) values (30001,'2008-09-01',8001), 
											  (30002, '2008-09-12', 8003),
											  (30003, '2008-09-30', 8004),
											  (30004, '2008-8-03', 8005),
											  (30005, '2008-8-08', 8001);

create table orderitems(o_num int not null, 
						o_item int not null, 
						f_id varchar(8) not null,
						quantity int not null,
						item_price decimal(8,2) not null,
						primary key (o_num,o_item)
						);
						
INSERT INTO orderitems(o_num, o_item, f_id, quantity, item_price) VALUES (30001, 1, 'a1', 8, 5.2),
																		 (30001, 2, 'b2', 3, 7.6),
																		 (30001, 3, 'bs1', 5, 11.2),
																		 (30001, 4, 'bs2', 15, 9.2),
																		 (30002, 1, 'b3', 2, 20.0),
																		 (30003, 1, 'c0', 80, 8),
																		 (30004, 1, 'o2', 50, 2.50),
																		 (30005, 1, 'c0', 5, 8),
																		 (30005, 2, 'b1', 8, 8.99),
																		 (30005, 3, 'a2', 8, 2.2),
																		 (30005, 4, 'm1', 5, 14.99);

create table customers (c_id int not null auto_increment,
						c_name varchar(50) null,
						c_city varchar(50) null,
						c_zip varchar(8) null,
						c_contact varchar(50) null,
						c_mail varchar(100) null,
						primary key(c_id)
						);

INSERT INTO customers(c_id, c_name, c_address, c_city, c_zip,  c_contact, c_email) 
			VALUES(8001, 'RedHook', '200 Street ', 'Tianjin',  '300000',  'LiMing', 'LMing@163.com'),
			(8002, 'Stars', '333 Fromage Lane', 'Dalian', '116000',  'Zhangbo','Jerry@hotmail.com'),
			(8003, 'Netbhood', '1 Sunny Place', 'Qingdao',  '266000', 'LuoCong', NULL),
			(8004, 'JOTO', '829 Riverside Drive', 'Haikou',  '570000',  'YangShan', 'sam@hotmail.com');
