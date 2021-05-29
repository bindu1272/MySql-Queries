#create database ecomerce;
create table SALESPEOPLE(
SNUM int(5) PRIMARY KEY,  SNAME CHAR(10),
  CITY CHAR(20),  COMM DECIMAL(8,3));
INSERT INTO SALESPEOPLE VALUES (1001, 'Peel', 'London',0.12); 
INSERT INTO SALESPEOPLE VALUES(1002, 'Serres','San Jose',0.13);
insert into salespeople values(1004,'motika','London',0.11);
insert into salespeople values(1007,'Rafkin','Barcelona',0.15);
insert into salespeople values(1003,'Axelrod','New York',0.1);

CREATE TABLE CUST(CNUM int(5) PRIMARY KEY,  
CNAME CHAR(20),  CITY CHAR(20), RATING int(3),SNUM int(4));
INSERT INTO CUST VALUES (2001, 'Hoffman', 'London',100,1001); 
INSERT INTO CUST VALUES (2002, 'Giovanne', 'Rome',200,1003); 
insert into cust values(2003,'Liu','San Jose',300,1002);
insert into cust values(2004,'Grass','Brelin',100,1002);
insert into cust values(2006,'Clemens','London',300,1007);
insert into cust values(2007,'Pereia','Rome',100,1004);


CREATE TABLE ORDERS(ONUM int(5) PRIMARY KEY,  AMT float(5,2), 
ODATE Date, CNUM int(4),SNUM int(4));
INSERT INTO ORDERS VALUES (3001,18.69,'1994-10-03',2008,1007);
INSERT INTO ORDERS VALUES (3003,767.19,'1994-10-03',2001,1001); 
insert into orders values(3002,900.10,	'1994-10-03',2007,1004);
insert into orders values(3005,160.45,'1994-10-03',2003,1002);
insert into orders values(3006,098.16,'1994-10-04',2008,1007);
insert into orders values(3009,713.23,'1994-10-04',2002,1003);
insert into orders values(3007,75.75,'1994-10-05',2006,1002);
insert into orders values(3008,723.00,'1994-10-05',2006,1001);
insert into orders values(3010,309.95,'1994-10-06',2004,1002);
insert into orders values(3011,891.88,'1994-10-06',2006,1001);
select * from cust;
select* from orders;
select * from salespeople;
#Display snum,sname,city and comm of all salespeople.
select snum,sname,city,comm from salespeople;
#Display all snum without duplicates from all orders.
select distinct(snum) from orders;
#Display names and commissions of all salespeople in london.
select sname,comm from salespeople where city ='London';
#All customers with rating of 100.
select * from cust where rating = 100;
#Produce orderno, amount and date form all rows in the order table.
select onum,amt,odate from orders;
#All customers in San Jose, who have rating more than 200
select cname from cust where rating > 200 and city = 'San Jose';
#All customers who were either located in San Jose or had a rating above 200.
select cname from cust where rating > 200 or city ='San Jose';
#All orders for more than $1000.
select * from orders where amt > 1000;
#Names and citires of all salespeople in london with commission above 0.10.
select sname,city from salespeople where city ='London' and comm > 0.10;
#All customers excluding those with rating < = 100 unless they are located in Rome.
select cname from cust where (rating <=100) or (city = 'Rome');
#All salespeople either in Barcelona or in london.
select sname from salespeople where city = 'Barcelona' or city ='London';
#All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
select sname from salespeople where comm > 0.10 and comm <0.12;
#All customers with NULL values in city column.
select cname from cust where city=null;
#All orders taken on Oct 3Rd and Oct 4th 1994.
select * from orders  where odate = '1994-10-03' and odate ='1994-10-04';
#All customers serviced by peel or Motika
select cname from cust, orders where orders.cnum = cust.cnum and orders.snum in(select snum from salespeople where sname in ('Peel','Motika'));
#All customers whose names begin with a letter from A or B.
select cname from cust where cname like 'A%' or cname like'B%';
#All orders except those with 0 or NULL value in amt field.
select onum from orders where amt !=0 or amt != null;
#Count the number of salespeople currently listing orders in the order table
select count(distinct snum) from orders;
#Largest order taken by each salesperson, datewise.
select odate,snum,max(amt) from orders group by odate,snum order by odate;
#Largest order taken by each salesperson with order value more than $3000.
select odate,snum,amt from orders  where amt > 3000 group by odate,snum;
#VWhich day had the hightest total amount ordered.
select odate,max(amt) from orders;
#count all orders for Oct 3rd.
select count(onum) from orders where odate = '1994-10-03' group by odate;
#Count the number of different non NULL city values in customers table.
select count(distinct city) from cust where city is not null;
#Select each customer’s smallest order.
select cnum,min(amt) from orders group by cnum;
#First customer in alphabetical order whose name begins with G.
select min(cname) from cust where cname  like 'G%';
#Get the output like "For dd/mm/yy there are_orders.
#Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
select onum,snum,amt, amt * 0.12 from orders order by snum;
#Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
select city,max(rating) from cust group by city;
Select 'For the city (' ,city , '), the highest rating is : ('  ,max(rating), ')' from cust group by city;
#Display the totals of orders for each day and place the results in descending order.
select odate,count(onum) from orders group by odate order by count(onum) desc;
#All combinations of salespeople and customers who shared a city. (ie same city )
select sname,cname from cust,salespeople where cust.city = salespeople.city;
#Name of all customers matched with the salespeople serving them.
select cname,sname from cust,salespeople where cust.cname = salespeople.sname;
#List each order number followed by the name of the customer who made the order.
select onum,cname from orders,cust where orders.cnum = cust.cnum;
#Names of salesperson and customer for each order after the order number.
select sname,cname,onum from salespeople,cust,orders where cust.snum = salespeople.snum and cust.cnum = orders.cnum;
#Produce all customer serviced by salespeople with a commission above 12%.
select cname,sname,comm from cust,salespeople where cust.snum=salespeople.snum and comm > 0.12;
#Calculate the amount of the salesperson’s commission on each order with a rating above 100.
select sname,comm*amt from orders,salespeople,cust where orders.snum = cust.snum and 
cust.snum = salespeople.snum and cust.rating > 100 ;
#Find all pairs of customers having the same rating.
select * from cust order by rating;
Select a.cname, b.cname,a.rating from cust a, cust b where a.rating = b.rating and a.cnum != b.cnum; 
#Policy is to assign three salesperson to each customers. Display all such combinations.
Select cname, sname from salespeople, cust
where sname in  ( select sname from salespeople where rownum <= 3)order by cname;
#Display all customers located in cities where salesman serres has customer.
Select cname from cust where city = ( select city  from cust, salespeople
where cust.snum = salespeople.snum and sname = 'Serres');
#Find all pairs of customers served by single salesperson.
Select cname from cust where snum in (
select snum from cust group by snum having count(snum) > 1);
#Produce all pairs of salespeople which are living in the same city. Exclude combinations 
#of salespeople with themselves as well as duplicates with the order reversed.
Select a.sname, b.sname from salespeople a, salespeople b where a.snum > b.snum and a.city = b.city;
#Produce names and cities of all customers with the same rating as Hoffman.
Select cname, city from cust where rating = 
(select rating from cust where cname = 'Hoffman') and cname != 'Hoffman'; 
#Extract all the orders of Motika.
select onum from orders,cust,salespeople where
 orders.snum = cust.snum and cust.snum = salespeople.snum and salespeople.sname = 'motika';
#All orders credited to the same salesperson who services Hoffman.
Select onum, sname, cname, amt from orders a, salespeople b, cust c
 where a.snum = b.snum and a.cnum = c.cnum and a.snum = ( 
 select snum from orders where cnum = ( select cnum from cust where cname = 'Hoffman')); 
#All orders that are greater than the average for Oct 4.	
select onum,odate from orders where amt >(select avg(amt) from orders where odate = '1994-10-03');  
#Find average commission of salespeople in london.
select avg(comm) from salespeople where city = 'london';
#Find all orders attributed to salespeople servicing customers in london.
Select snum, cnum  from orders where cnum in (select cnum  from cust where city = 'London'); 
#Extract commissions of all salespeople servicing customers in London.
Select comm from salespeople where snum in (select snum from cust where city = ‘London’);
#Find all customers whose cnum is 1000 above the snum of serres.
select cnum,snum from cust,salespeople where cust.cnum > 1000 and salespeople.sname ;
#Count the customers with rating above San Joses average.
select cnum,rating from cust where rating > (select avg(rating) from cust where city = 'san jose');
select cnum, rating from cust where rating > (select avg(rating)  from cust where city = 'San Jose'); 

















