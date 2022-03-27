DROP DATABASE IF EXISTS ESTIMIZEDB;

CREATE DATABASE ESTIMIZEDB;

USE ESTIMIZEDB;


CREATE TABLE COMPANY_DETAILS(
  ticker VARCHAR(45) PRIMARY KEY,
  company_name VARCHAR(45),
  sector VARCHAR(45),
  industry VARCHAR(45),
  follower_count INT,
  no_of_analysts INT
 );

CREATE TABLE EPS_DATA(
  company_name VARCHAR(45) NOT NULL REFERENCES COMPANY_DETAILS(ticker),
  quarter VARCHAR(10) NOT NULL,
  reported_earnings FLOAT NOT NULL,
  estimize_consensus FLOAT,
  estimize_mean FLOAT,
  wall_street_consensus FLOAT,
  PRIMARY KEY(company_name, quarter) 
 ); 
 
 CREATE TABLE ANALYST_EPS(
  company_name VARCHAR(45) NOT NULL REFERENCES COMPANY_DETAILS(ticker),
  quarter VARCHAR(10) NOT NULL,
  analyst_id VARCHAR(45) NOT NULL REFERENCES ANALYST_DATA(analyst_id),
  analyst_name VARCHAR(100),
  eps_estimation FLOAT NOT NULL,
  PRIMARY KEY(analyst_id, company_name, quarter)
 ); 
 
 CREATE TABLE ANALYST_DATA(
  analyst_id VARCHAR(45) NOT NULL,  
  analyst_name VARCHAR(100) NOT NULL,  
  analyst_role VARCHAR(100),  
  join_date VARCHAR(10),
  confidence_score FLOAT, 
  error_rate FLOAT, 
  accuracy_percentile FLOAT, 
  points FLOAT, 
  points_estimate FLOAT, 
  stocks INTEGER, 
  pending INTEGER,
  PRIMARY KEY(analyst_id)
 );

CREATE TABLE STOCKS(
  analyst_id VARCHAR(45) NOT NULL REFERENCES ANALYST_DATA(analyst_id),
  ticker VARCHAR(45) NOT NULL,
  reports VARCHAR(45),
  quarters INTEGER,	
  points INTEGER,		
  pts_est FLOAT,	
  error_rate FLOAT,
  accuracy FLOAT,
  PRIMARY KEY(ticker, analyst_id) 
);

CREATE TABLE PENDING_EST_DATA(
  analyst_id VARCHAR(45) NOT NULL REFERENCES ANALYST_DATA(analyst_id), 	
  ticker VARCHAR(45) NOT NULL,	
  quarter VARCHAR(45) NOT NULL, 	
  reports VARCHAR(45),	
  published VARCHAR(45),	
  eps FLOAT,
  revenue FLOAT,
  PRIMARY KEY(ticker, quarter, analyst_id) 
 ); 

CREATE TABLE SCORED_ESTDATA(
  analyst_id VARCHAR(45) NOT NULL REFERENCES ANALYST_DATA(analyst_id),
  ticker VARCHAR(45) NOT NULL,	
  quarter VARCHAR(45) NOT NULL,	
  reported VARCHAR(45),
  ana_rank VARCHAR(45),	
  eps_points FLOAT,	
  revenue_points INTEGER,	
  total_points INTEGER,
  PRIMARY KEY(ticker, quarter, analyst_id) 
);
#Problem 1
select P.Analyst_ID, Confidence_Score, Points, Error_rate, Accuracy_Percentile from ANALYST_DATA A
inner join ANALYST_EPS P
using (Analyst_ID)
where P.company_name = 'NKE'
group by P.Analyst_ID
order by Confidence_Score desc, Points desc, Error_rate desc, Accuracy_Percentile desc;



# Problem 2
select count(distinct(C.ticker)) as NUM_COMPANIES, avg(no_of_analysts) as AVG_ANALYSTS, avg(E.Reported_Earnings - E.Estimize_Consensus) as MEAN_DIFF, Industry
from COMPANY_DETAILS C
inner join EPS_DATA E
on c.ticker=e.company_name
where C.Industry= 'Biotechnology'
group by C.Industry;



# Problem 3
select distinct(C.Ticker),count(I.Analyst_ID) as nof from Company_details C
inner join Analyst_eps P
on C.Ticker=P.company_name
inner join Analyst_data I
on P.Analyst_ID=I.Analyst_ID
where I.Confidence_Score >7
group by C.Ticker
order by no_of_analysts desc
limit 1;



# Problem 4
select Ticker from Company_details
where Follower_count =
(select max(Follower_count) from Company_details);