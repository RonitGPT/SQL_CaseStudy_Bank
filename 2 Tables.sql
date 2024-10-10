/*------------- CREATION OF DATABASE -------------------*/

create database bank;
use bank;

/*------------- BANK TABLE CREATION -----------------*/

create table Bank (b_id int primary key auto_increment , b_name varchar (30) unique not null , b_location varchar (25) not null );
desc Bank ;
/* ------------ BANK VALUES -----------------------*/

insert into Bank values ( 1 , "HDFC" , "Mumbai" ) ,
( 2 , "SBI" , "Delhi" ),
( 3 , "INDUSIND" , "Chennai" ),
( 4 , "ICICI" , "Mumbai" ),
( 5 , "AXIS" , "Mumbai" ),
( 6 , "PNB" , "Punjab" ),
( 7 , "KOTAK" , "Banglore" ),
( 8 , "IDBI" , "Mumbai" ) ;
select * fron Bank ;

/*------------- BRANCHES TABLE CREATION -----------------*/

create table Branch ( branch_id int primary key , branch_name varchar (30) not null , ifsc varchar (20) unique not null ,
 address varchar (20) default ("Mumbai") , b_id int ,
 foreign key (b_id) references Bank (b_id)) ; 
 desc Branch ;

/* ------------ BRANCH VALUES -----------------------*/

insert into Branch values ( 100 , "Airoli" , "HDFC001111" , "Airoli" , 1 ) ,
( 101 , "Thane" , "HDFC001112" , "Naupada" , 1 ) ,
( 102 , "Parel" , "HDFC001113" , "Parel (W)" , 1 ) ,
( 103 , "Kalyan" , "HDFC001114" , "Kalyan" , 1 ) ,
( 104 , "Vashi" , "HDFC001115" , "Vashi" , 1 ) ,
( 200 , "Airoli" , "SBIN01111" , "Airoli" , 2 ) ,
( 201 , "Thane" , "SBIN01112" , "Manpada" , 2 ) ,
( 202 , "BKC" , "SBIN01113" , "Bandra" , 2 ) ,
( 203 , "Kalyan" , "SBIN01114" , "Kalyan" , 2 ) ,
( 300 , "Airoli" , "INDUS01111" , "Airoli" , 3 ) ,
( 301 , "Thane" , "INDUS01112" , "Naupada" , 3 ) ,
( 302 , "Dadar" , "INDUS01113" , "Dadar" , 3 ) ,
( 303 , "Mulund" , "INDUS01114" , "Mulund (E)" , 3 ) ,
( 304 , "Nerul" , "INDUS01115" , "Nerul" , 3 ) ,
( 400 , "Dadar" , "ICICI01111" , "Dadar" , 4 ) ,
( 401 , "Airoli" , "ICICI01112" , "Airoli" , 4 ) ,
( 402 , "BKC" , "ICICI01113" , "Bandra" , 4 ) ,
( 403 , "Kurla" , "ICICI01114" , "Kurla" , 4 ),
( 500 , "Juhu" , "AXIS01111" , "Juhu" , 5) ,
( 501 , "Byculla" , "AXIS01112" , "Byculla" , 5) ,
( 502 , "Vashi" , "AXIS01113" , "Vashi" , 5) ,
( 503 , "Dombivali" , "AXIS01114" , "Dombivali" , 5), 
( 600 , "CST" , "PNB001111" , "CST" , 6) ,
( 601 , "Airoli" , "PNB001112" , "Airoli" , 6) ,
( 602 , "BKC" , "PNB001113" , "BKC" , 6) ,
( 700 , "Nerul" , "KOTAK01111" , "Nerul" , 7 ) ,
( 701 , "Juinagar" , "KOTAK01112" , "Juinagar" , 7 ) ,
( 703 , "Thane" , "KOTAK01113" , "Thane" , 7 ),
( 800 , "Nerul" , "IDBI01111" , "Nerul" , 8 ) ,
( 801 , "Airoli" , "IDBI01112" , "Airoli" , 8 ) ,
( 802 , "BKC" , "IDBI01113" , "Bandra" , 8 ) ;
select * from Branch ;

/*--------- ACCOUNT TABLE CREATION -------------*/

create table account( acc_id int primary key , acc_type varchar (25) not null , b_id int , 
foreign key (b_id) references Bank (b_id)) ;
desc account ;

/*--------- ACCOUNT TABLE DATA -------------*/

insert into account values( 10 , "Savings Acc" , 1 ) ,
( 11 , "Current Acc" , 1 ) ,
( 12 , "Salary Acc" , 1 ) ,
( 20 , "Savings Acc" , 2 ) ,
( 21 , "Current Acc" , 2 ) ,
( 22 , "Salary Acc" , 2 ) ,
( 30 , "Savings Acc" , 3 ) ,
( 31 , "Current Acc" , 3 ) ,
( 32 , "Salary Acc" , 3 ) ,
( 40 , "Savings Acc" , 4 ) ,
( 41 , "Current Acc" , 4 ) ,
( 42 , "Salary Acc" , 4 ) ,
( 50 , "Savings Acc" , 5 ) ,
( 51 , "Current Acc" , 5 ) ,
( 52 , "Salary Acc" , 5 ) ,
( 60 , "Savings Acc" , 6 ) ,
( 61 , "Current Acc" , 6 ) ,
( 62 , "Salary Acc" , 6 ) ,
( 70 , "Savings Acc" , 7 ) ,
( 71 , "Current Acc" , 7 ) ,
( 72 , "Salary Acc" , 7 ) ,
( 80 , "Savings Acc" , 8 ) ,
( 81 , "Current Acc" , 8 ) ,
( 82 , "Salary Acc" , 8 ) ;
select * from account ;

/*--------- LOAN TABLE CREATION -------------*/

create table loan ( loan_id int primary key , loan_type varchar (25) not null , loan_amt int not null );
drop table loan ;
desc loan ;

/*--------- LOAN TABLE DATA -------------*/

insert into loan values ( 1 , "Personal Loan" , 500000 ) ,
( 2 , "Home Loan" , 1500000 ) ,
( 3 , "Car Loan" , 800000 ) ,
( 4 , "Education Loan" , 5000000 ) ,
( 5 , "Business Loan" , 2000000 ) ;
select * from loan ;

/* ------------- CUSTOMER TABLE CREATION ------------------*/

create table customer ( c_id int primary key , c_name varchar(25) not null , account_no long , phone_no long , branch_id int ,
address varchar(20) default ('Mumbai') , acc_id int , loan_id int  ,
 foreign key (branch_id) references Branch (branch_id) ,
 foreign key (acc_id) references Account (acc_id) ,
 foreign key (loan_id) references loan (loan_id));
 desc customer ;
 drop table customer ;
 
 /* ------------- CUSTOMER TABLE DATA ------------------*/
 truncate table customer ;
 insert into customer values (1 , "Vishal Mourya" , 20403107878 , 9372692474 , 100 , "Rabale" , 11 , null ) ,
 (2 , "Yash Katkar" , 20403109999 , 9137997402 , 402 , "Airoli" , 40 ,null  ) ,
 (3 , "Manasi Kamble" , 20403107879 , 9372692747 , 302 , "Vashi" , 32  ,null ) ,
 (4 , "Sahil Kamble" , 204034578 , 937269734 , 400 , "Bandra" , 41 , 5  ) ,
 (5 , "Parth Amburle" , 20403109876 , 8763692474 , 602 , "Kharghar" , 61,3 ) ,
 (6 , "Rohan Pujari" , 20403106543 , 8750692474 , 700 , "Parner" , 72 ,null) ,
 (7 , "Vikrant Pol" , 20403103746 , 9372467474 , 802 , "Pune" , 82 ,null ) ,
 (8 , "Karan Lohot" , 20403100409 , 9372690909 , 101 , "Pune" , 12,4  ) ,
 (9 , "Pooja Jaybhaye" , 20403103787 , 9372692234 , 102 , "Juinagar" , 10 ,null ), 
 (10 , "Sahil Jadhav" , 20403198467 , 9372692445 , 703 , "Ghatkopar" , 71 ,null ) ,
 (11 , "Tejas Kamble" , 20403189889 , 9372692434 , 501 , "Pune" , 50 ,null ) ,
 (12 , "Prachit Mhatre" , 20403469778 , 9372334574 , 400 , "Alibaug" , 42 ,2 ) ,
 (13 , "Vinay Ghule" , 20403167736 , 9372691243 , 302 , "Ghansoli" , 30 ,null ) ,
 (14 , "Ritesh Jaiswal" , 20400000878 , 9323422474 , 602 , "Kharghar" , 62,null  ) ,
 (15 , "Rupesh Kanojia" , 20403103456 , 9372444474 , 500 , "Kharghar" , 50 ,null ) ,
 (16 , "Akshay Walgude" , 40403107898 , 9376656474 , 100 , "Parel" , 11,null  ) ,
 (17 , "Anushree Walishete" , 40203107878 , 8092692474 , 103 , "Kharghar" , 12 ,1 ) ,
 (18 , "Akanksha Suryawanshi" , 20403107870 , 3472692474 , 202 , "Kanjurmarg" , 21 ,null ) ,
 (19 , "Sahil Mahadik" , 2040314445 , 9372690090 , 600 , "Vashi" , 62 ,null ) ,
 (20 , "Aniket Karale" , 20403103343 , 9372694444 , 802 , "Bhandup" , 80,4  ) ,
 (21 , "Pranjal Kashid" , 20403109989 , 9372647474 , 302 , "Rabale" , 31 ,null ) ,
 (22 , "Namrata Medkar" , 20403100090 , 9372692478 , 401 , "Rabale" , 42,3  ) ,
 (23 , "Niharika Kakade" , 20403144348 , 9372600984 , 201 , "Thane" , 20 ,null  ) ,
 (24 , "Sagar Jadhav" , 204031098764 , 9372332346 , 302 , "Airoli" , 31 ,null ) ,
 (25 , "Om Nishad" , 20403107832 , 9372692750 , 501 , "Diva" , 52 ,1 ) ,
 (26 , "Mrunali Prabhu" , 204098707878 , 9232692474 , 601 , "Koparkhairne" , 62,null  ) ,
 (27 , "Sneha Rai" , 20403107123 , 9372692009 , 701 , "Turbhe" , 72 ,null ) ,
 (28 , "Chaitali Godse" , 20403107800 , 93727692474 , 402 , "Vasind" , 40 ,null ) ,
 (29 , "Akash Viswakarma" , 20403107078 , 7509692474 , 402 , "Diva" , 40 ,3 ) ,
 (30 , "Sushant Jadhav" , 20403104432 , 9372692421 , 602 , "Bhiwandi" , 60 ,null ) ,
 (31 , "Pradnya Jadhav" , 20403105465 , 93726924213 , 500 , "Kalyan" , 50 ,null ) ,
 (32 , "Nitin Singh" , 20403107888 , 9372692000 , 500 , "Bhiwandi" , 50 ,4 ) ,
 (33 , "Usha Shende" , 20403107873 , 9372691234 , 602 , "Airoli" , 62 ,null ) ,
 (34 , "Sujit Pradhan" , 20403100978 , 9372699974 , 701 , "Digha" , 72,null  ) ,
 (35 , "Rohit Bhagat" , 20403107077 , 9372692471 , 100 , "Satara" , 12 ,null ) ,
 (36 , "Vedika Bhoir" , 20403107887 , 9372692472 , 200 , "Rabale" , 21 ,null ) ,
 (37 , "Sejal Bhitade" , 20403107888 , 9372692444 , 302 , "Airoli" , 30 ,2 ) ,
 (38 , "Shraddha Patil" , 204031000008 , 9372696474 , 502 , "Bandra" , 51 ,null ) ,
 (39 , "Snehal Ratnaparkhe" , 20403133245 , 9334692474 , 602 , "Kurla" , 61,2  ) ,
 (40 , "Tejal Khanvilkar" , 20403102213, 9372600474 , 802 , "Ghansoli" , 81 ,null ) ;

select * from customer ;

==============================================================================================================================================





