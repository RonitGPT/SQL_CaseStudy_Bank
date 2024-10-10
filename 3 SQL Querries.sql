/*================ QUERRY TO SELECT DATABASE =========================*/
use bank ;
/*================ QUERRY TO VIEW STRUCTURE OF TABLE =========================*/
Desc Bank ;
Desc Branch ;
Desc account ;
Desc loan ;
Desc customer ;
/*================ QUERRY TO VIEW TABLE DATA =========================*/
select * from Bank ; 
select * from Branch ; 
select * from account ; 
select * from loan ; 
select * from customer ; 
/*================ QUERRY ALTER THE TABLE DATA =========================*/
alter table account rename to Account ;
alter table Bank change column b_location b_city varchar(15) ; 
alter table Bank modify b_city varchar(15) default('Mumbai') ;
/*================ QUERRY UPDATE THE TABLE DATA =========================*/
update loan set loan_amt = 2500000 where loan_id = 2 ;
update customer set loan_id = 4 where c_id =14 ; 
update Bank set b_loacation = "Kolkata" where b_name = "IDBI" ;
update customer set address = "Airoli" where c_name="Pranjal Kashid" ;
/*================ WHERE CLAUSE FOR SEARCH CONDITION =========================*/
select * from Bank where b_name = "KOTAK" ;
select c_id ,c_name , account_no , branch_id , address from customer where c_id = 21 ;
select b_name as Name , b_id from Bank where  b_city = "Mumbai";
/*================ OPERATORS =========================*/
/* Arithmatic operator*/
select loan_id , loan_type , loan_amt + 50000 as Updated_Amt from loan where loan_id = 1 ;
/*Comparison operator*/
select loan_type from loan where loan_amt > 700000 ;
select c_name from customer where address = "Airoli" ;
select c_name from customer where address != "Airoli" ;
select c_name from customer where address <> "Kalyan" ;
/* Logical Oprator*/
select * from customer where address = "Kalyan" and loan_id = 3 ;
select * from customer where address = "Thane" or loan_id = 3 ;
/*Range Operator*/
select * from customer where c_id between 21 and 35 ;
/*================ CLAUSES =========================*/
/*Distinct Clause */
select distinct address from customer ;
/* IN Clause */
select * from loan where loan_id in (1 , 3, 5) ;
select * from customer where address in ("Kalyan" , "Airoli", "BKC");
/*ORDER BY Clause */
select * from customer order by c_name asc ;
select * from customer order by c_name desc ;
/*LIMIT Claude */
select * from loan order by loan_amt desc limit 2 ;
select * from loan order by loan_amt desc limit 1,2 ;
/* Like Clause */
select c_name from customer where c_name like ("P%") ;
select c_name from customer where c_name like ("__a%") ;
select c_name from customer where c_name like ("_a%") ;
select c_name from customer where c_name like ("%as%") ;
/*============= INBUILD FUNCTIONS =======================*/
/* String function */
select concat(c_name,'_',address) as Cust_Details from customer ;
select upper (c_name) as Names from customer;
select lower(c_name )as Names from customer ;
select replace (b_city ,'Chennai','Chennai_') from Bank ;
select length(address) as len from customer ;
/*Substring Functiom*/
select substring('Good_Morning', 5,13) as result ;
/*Date Function*/
select date_format(now(), '%D %M %Y') as result;
/*========== AGGREGATE FUNCTION (GROUP BY CLAUSE)-- count, min, max, avg, sum ======================*/
select count(c_name) from customer group by loan_id having loan_id = 3 ;
select min(loan_amt) from  loan group by loan_amt ;
select max(loan_amt) from  loan group by loan_amt ;
select avg(loan_amt) as avg_amt from loan group by loan_amt ;
/*======================== JOINS =======================================*/

/* Q1. Write a querry to create a table that joins the Bank And Branch tables which displays bankid , Bank name and its Branches and IFSC Code. */
select Bank.b_id , Bank.b_name , Branch.branch_name , Branch.ifsc from Bank
INNER JOIN Branch 
WHERE Bank.b_id = Branch.b_id ;

/*Q2. Write a querry to display the Customers who have availed Loans from their respective Banks . Querry must return  cust id , cust name ,
cust Account no ,Loan type , loan amt . */
SELECT customer.c_id, customer.c_name , customer.account_no , loan.loan_type , loan.loan_amt from customer
INNER JOIN loan
WHERE customer.loan_id=loan.loan_id ;
/*======================= SUB QUERRIES ===============================*/
/* Q3. Write a querry to find the Loan id of customers whose loan amount is greater than the loan amont of customer with customer id =12 */
select loan_id from loan where loan_id > any (select loan_id from customer where c_id = 12) ;

/*Q4. Write a querry to find the Type of Account of the customer having accoun no = 20403109989 */
select acc_type from account where acc_id in (select acc_id from customer where account_no = 20403109989 );

/*========================= VIEWS =====================================*/

/*Q5. Write a querry to create a view as Account_Details which displays the name of custome ,  phone number , account type 
,Bank name.*/
Create view  Account_Details as 
select customer.c_name  , customer.phone_no , account.acc_type , Bank.b_name from customer 
INNER JOIN account 
ON customer.acc_id = account.acc_id 
INNER JOIN Bank
ON account.b_id = Bank.b_id ;

/*======================== CURSOR =====================================*/
/*Q6. Create a Curse to Display the Loan Amount Remark such that if Loan Amount is between 5L to 8L then dispay ' Not high ' , 
 if Loan Amount is between 8L to 15L then dispay ' Moderate ' , if Loan Amount is between 15L to 20L then dispay ' high ' 
 if Loan Amount is Greater than 20L then dispay ' Very high ' */

delimiter $$
create procedure Loan_Reminder ()
begin 
declare cur cursor for select loan_amt from loan ;
open cur ;
if loan_amt >= 500000 or loan_amt <=800000 then
Select "Loan Amt is Not High" as Loan_Remark ;
elseif loan_amt > 800000 or loan_amt <1500000 then
Select "Loan Amt is Moderate" as Loan_Remark ;
elseif loan_amt >= 1500000 or loan_amt <2000000 then
Select "Loan Amt is High" as Loan_Remark ;
else 
Select "Loan Amt is Very High" as Loan_Remark ;
end if;
close cur ;
end $$ 
delimiter ;

/*======================== TRIGGERS ===============================*/

/*Q7. Write a querry that reflects the creation of new account along with its date and time */
create table logtable ( action varchar (30) , datetime datetime ) ;

delimiter $$
create trigger Acc_Created after insert on customer
for each row 
begin 
insert into logtable(action , datetime ) values ("Account_Created" , now()) ;
end $$
delimiter ;

Insert into customer values (42 , "Krutika Khanvilkar" , 20403100367, 9372690765 , 301 , "Ghansoli" , 31 , null ) ;
select * from logtable ;

-------------------------------------------------------------------------------------------------------------------------

/*Q8. Write a querry that  reflects the Deletion of existing account along with its date and time */

delimiter $$
create trigger Acc_Deleted after delete on customer
for each row 
begin 
insert into logtable(action , datetime ) values ("Account_Deleted" , now()) ;
end $$
delimiter ;

delete from customer where c_id = 42 ;
select * from logtable ;