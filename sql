create database lab;

create table agent(
agent_id varchar PRIMARY KEY,
agent_name varchar,
agent_city varchar
);

desc table agent;

create table customer (
cust_code varchar PRIMARY KEY,
cust_name varchar,
cust_address varchar
);
show tables ;

alter table customer
add agent_id varchar;

desc table customer;

alter table customer
add constraint FK1 FOREIGN KEY(agent_id) references agent(agent_id); 

desc table customer;
alter table agent
add column agent_code varchar ;

alter table customer
rename to customers;

alter table agent
rename to agents
;
desc table agents;


select * from agents;

insert into agents (agent_id,agent_name,agent_city,agent_code) values
(001,'Vinod','sikkim',0761),
(002,'Rakesh','Banglore',0670),
(003,'James','LA',007);
select * from agents;

update agents
set agent_code= 890 
where agent_id = 3;

desc table customers;

update agents
set agent_id = 'A003'
where agent_name = 'James';

desc table customers;
INSERT INTO customers (cust_code,cust_name,cust_address,agent_id) values
('B010','Bond','Dubai',101),
('B011','Ravish','Abu_dabi',102),
('B012','Devond','Iraq',103);

insert into agents (agent_id,agent_name,agent_city,agent_code) values
(001,'Vinod','sikkim',0761),
(002,'Rakesh','Banglore',0670),
(003,'James','LA',007);
select agent_code,cust_name from customers,agents;

select * from agents;
select * from customers;

select agents.agent_id , cust_code from agents,customers
where agents.agent_id = customers.agent_;
show databases;
use mayur_db;
show tables;

select dept_no, count(dept_no) from emp as employee_count group by dept_no; 

select emp_id, concat(first_name,last_name) as full_name,
length(concat(first_name,last_name))as full_name_length from emp ;

select concat(first_name,last_name) as full_name,
AVG(length(concat(first_name,last_name))as avg_name_length from emp;

SELECT
  AVG(LENGTH(first_name || last_name)) AS avg_name_length
FROM
  emp;

select Avg(length(first_name || last_name)) as con_fullname from emp;

select * from emp;

select length(employee_name) as count_fullname from emp
where dept_no = 20; 

select emp_id,employee_name from emp where dept_no = 10 and first_name like 'A%';

select avg(salary) as avg_salary from emp;

select max(salary) - min(salary) as salary_diff from emp;
select emp_id,employee_name from emp
where salary > 5000;

select * from emp;

create database mongo_db;

create table book(
book_id INT,
book_name VARCHAR(50)
);

create table author(
author_id INT primary key,
author_name varchar(50)

);

alter table book
add constraint pk1 primary key (book_id);

create table book_author(
book_id INT,
author_id INT
);
show tables;
desc table author;

alter table book_author
add constraint fk1 foreign key (book_id) references book(book_id);

alter table book_author
add constraint fk2 foreign key(author_id) references author(author_id);

desc table book;

insert into book values (1,'wings of fire'),(2,'2states'),(3,'half girlfriend');
select * from book;

update book
set book_name = '2 states'
where book_id = 2;

desc table author;
insert into book values (4,'born to blossom');
insert into author values (101,'APJ Abdul kalam'),(102,'chetan bhagat'),(103,'chetan bhagat');
select * from author;

insert into book_author values (4,102);

update author
set author_name = 'arun tiwati'
where author_id =103;

select * from book_author;

select book_name , author_name
from book B,author A , book_author BA 
where
B.book_id=BA.book_id
and
A.author_id=BA.author_id;

CREATE TABLE SalesData (
TransactionID INT PRIMARY KEY, 
ProductID INT,
Category VARCHAR(50), 
SaleDate DATE,
Quantity INT,
PricePerUnit DECIMAL(10, 2) );

show tables;

create database mayur;
select * from author;

show databases;
use mongo_db;
show tables;

show tables;
select * from book;
select * from author;
select * from book_author;

select book_name,author_name 
from book,author,book_author
where
book.book_id=book_author.book_id
and 
author.author_id=book_author.author_id;








INSERT INTO SalesData VALUES
(1, 101, 'Electronics', '2022-01-05', 10, 500.00),
(2, 102, 'Clothing', '2022-01-10', 8, 600.00),
(3, 103, 'Home Goods', '2022-02-15', 12, 300.00),
(4, 101, 'Electronics', '2022-02-20', 15, 600.00), 
(5, 104, 'Clothing', '2022-03-01', 10, 400.00),
(6, 105, 'Electronics', '2022-01-15', 18, 550.00), 
(7, 106, 'Clothing', '2022-02-01', 14, 700.00),
(8, 107, 'Home Goods', '2022-02-25', 20, 400.00),
(9, 108, 'Electronics', '2022-03-10', 25, 480.00), 
(10, 109, 'Clothing', '2022-03-15', 12, 550.00);

CREATE TABLE Returns (
ReturnID INT PRIMARY KEY,
ProductID INT,
ReturnDate DATE, 
QuantityReturned INT
);

INSERT INTO Returns VALUES 
(1, 101, '2022-01-08', 3),
(2, 104, '2022-03-05', 2),
(3, 107, '2022-02-28', 5);

select * from salesdata;

select * from salesdata
where SaleDate < '2022-02-01';

select * from returns r
right join salesdata s on
r.PRODUCTID= s.PRODUCTID
where r.PRODUCTID is NULL;



select * from returns r
join salesdata s on
r.PRODUCTID= s.PRODUCTID;
select * from salesdata;
select * from returns;
select ProductID,Category from salesdata where category IN ('Electronics','Home Goods') group by ProductID , Category;

select * from salesdata 
where Quantity > (select max(QuantityReturned) from returns);

select distinct s.transactionid,s.productid,category,saledate,quantity,priceperunit from salesdata s
join returns r on
s.PRODUCTID= r.ProductID or (select max(QuantityReturned) from returns);

SELECT ProductID, Category, SaleDate, Quantity, PricePerUnit
FROM SalesData
WHERE ProductID IN (SELECT DISTINCT ProductID FROM Returns);

select distinct s.productID from salesdata s 
left join (select ProductID , max(QuantityReturned) from  returns group by PRODUCTID) r
ON
s.ProductID = r.ProductID;

SELECT ProductID, Category, SaleDate, Quantity, PricePerUnit
FROM SalesData
WHERE ProductID IN (SELECT DISTINCT ProductID FROM Returns)

UNION

SELECT s.ProductID, s.Category, s.SaleDate, s.Quantity, s.PricePerUnit
FROM SalesData s
JOIN (
  SELECT ProductID, MAX(ReturnQuantity) AS MaxReturnQuantity
  FROM Returns
  GROUP BY ProductID
) r ON s.ProductID = r.ProductID
WHERE s.Quantity > r.MaxReturnQuantity;



SELECT DISTINCT sd.*
FROM SalesData sd
JOIN (
    SELECT ProductID, MAX(QuantityReturned) AS MaxReturnQuantity
    FROM Returns
    GROUP BY ProductID
) AS MaxReturns ON sd.ProductID = MaxReturns.ProductID
WHERE sd.Quantity > MaxReturns.MaxReturnQuantity;

show tables;
select * from author;
select * from book;
select * from book_author;

select book_name,author_name                           
from book B,author A,book_author BA
where
B.book_id=BA.book_id
and
A.author_id=BA.author_id;


select book_name , author_name
from book B,author A , book_author BA 
where
B.book_id=BA.book_id
and
A.author_id=BA.author_id;

show databases;
use database COVID19_DATA;
show tables;

select count(*) from APPLE_MOBILITY;

select * from APPLE_MOBILITY limit 10;

select count(*) from APPLE_MOBILITY
where TRANSPORTATION_TYPE = 'walking'
and country_region = 'Leeds'
and PROVINCE_STATE = 'England';

show databases;
drop database Mayur;

use mongo_db;
show tables;

create table look as
select * from book;

create warehouse Mywf warehouse_size=large;

drop warehouse Mywf;

use warehouse godown;

--- account    AQMQQZM-QKB73601

show tables;

create database M5;
CREATE TABLE SalesData (
TransactionID INT PRIMARY KEY,
ProductID INT,
Category VARCHAR(50), 
SaleDate DATE,
Quantity INT,
PricePerUnit DECIMAL(10, 2) );

INSERT INTO SalesData VALUES
(1, 101, 'Electronics', '2022-01-05', 10, 500.00), 
(2, 102, 'Clothing', '2022-01-10', 8, 600.00),
(3, 103, 'Home Goods', '2022-02-15', 12, 300.00), 
(4, 101, 'Electronics', '2022-02-20', 15, 600.00),
(5, 104, 'Clothing', '2022-03-01', 10, 400.00),
(6, 105, 'Electronics', '2022-01-15', 18, 550.00), 
(7, 106, 'Clothing', '2022-02-01', 14, 700.00),
(8, 107, 'Home Goods', '2022-02-25', 20, 400.00),
(9, 108, 'Electronics', '2022-03-10', 25, 480.00), 
(10, 109, 'Clothing', '2022-03-15', 12, 550.00);

show tables;
select * from Saledata;
alter table Salesdata
rename to saledata;

CREATE TABLE Returns (
ReturnID INT PRIMARY KEY,
ProductID INT,
ReturnDate DATE, 
QuantityReturned INT
);
INSERT INTO Returns VALUES
(1, 101, '2022-01-08', 3),
(2, 104, '2022-03-05', 2),
(3, 107, '2022-02-28', 5);

show tables;
select * from saledata limit 1;
select * from saledata
where saledate < '2022-02-01' ;
select * from returns;

select productID from saledata
where ProductID NOT IN (select productID from returns);

select distinct category,totalquantity,totalrevenue
from saledata; 

select category,
 sum(quantity) as TOTALQUANTITY,
 sum(quantity * priceperunit) as totalrevenue
 from saledata
 group by category;
---- 5th pdf -----
show tables; 
select * from saledata 
where saledate < '2022-02-01';

select  productID from saledata
where ProductID NOT IN (select productID from returns );

select category ,
 sum(quantity) as totalquantity,
 sum(quantity * priceperunit) as totalrevenue from saledata
 group by category;

 select * from saledata;

select distinct productID,category 
from saledata
where category IN('Electronics','Home Goods');

select productID,category,Priceperunit
from saledata
where category IN('Electronics','Clothing') and Priceperunit IN(500,600);

select * from saledata
where saledate = '2022-03-01';

SELECT TransactionID,ProductID, Category,SaleDate,quantity,priceperunit
FROM SaleData
WHERE EXISTS (
    SELECT 1
    FROM Returns
    WHERE Returns.ProductID = SaleData.ProductID
);













