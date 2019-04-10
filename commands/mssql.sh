# vim:syntax=sql
sqsh
sqsh -S localhost -U sa
sqsh -S jumponit-stage.cyiwtm0qww1w.us-east-1.rds.amazonaws.com -U jump_sa -P

SELECT @@version
SELECT @@servername


-- list databases
SELECT name FROM master.dbo.sysdatabases;
\go -m vert

-- create database & user
CREATE DATABASE <dbName>;
CREATE LOGIN <name> WITH PASSWORD="<password>";
use <dbName>;
CREATE USER <name> FOR LOGIN <name>;
go

-- list tables
SELECT table_name FROM information_schema.tables WHERE table_type='base table';
SELECT name FROM sys.tables;
USE <dbName>
sp_tables;

-- list columns
SELECT column_name FROM information_schema.columns WHERE table_name = 'campaign'

-- exploring
select top 100 * from <tableName>
select top 100 * from tbl_name order by id desc


-- deleting
USE jumpOnIt;
SELECT COUNT(*) AS BeforeCount FROM campaign;
TRUNCATE TABLE campaign;
SELECT COUNT(*) AS AfterCount FROM campaign;

-- go formatting
go -m pretty (meta | bcp | vert)
go -m vert | less
\alias go='\go -m pretty'

-- get row count of all tabes
CREATE TABLE --counts
(
    table_name varchar(255),
    row_count int
)
EXEC sp_MSForEachTable @command1='INSERT --counts (table_name, row_count) SELECT ''?'', COUNT(*) FROM ?'
SELECT table_name, row_count FROM --counts ORDER BY table_name, row_count DESC
DROP TABLE --counts


-- export table
sqsh -S SERV -U user -P passwd -D db -L bcp_colsep=',' -m bcp \
  -C 'select * from some_table where foo=bar' | tee /path/to/output.out
sqsh -S jumponit-stage.cyiwtm0qww1w.us-east-1.rds.amazonaws.com -U jump_sa -P 17U9Vj0744iN16U -D jumpOnIt_08_07_2017 -L bcp_colsep='|' -m bcp -C 'select * from campaign' | tee ./campaign.out

-- import table
BULK INSERT campaign FROM '/tmp/campaign.out' WITH (FIELDTERMINATOR = '|', ROWTERMINATOR = '0x0a')

-- get extended information
sp_help
sp_help <objname>
