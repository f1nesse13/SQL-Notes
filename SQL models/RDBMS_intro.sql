-- The Relational Database model is a very common model
-- It organizes its data types into columns and instances into rows
-- Relational Ex:
--  id |   name    | state
--   1 |   Joe     |    PA
--   2 |   Liz     |    NJ
--   3 |   Layla   |    NY

-- In order to access these table we use a RDBMS or Relational DataBase Managment System
-- There are many different RDBMS's including Oracle, postgres, SQLite, MySQL etc.

-- SQLite3 is serverless and stores data in a file so its very lightweight but cannot handle multiple requests at
-- once so will never be seen when using web apps but is good for some projects such as local phone
-- storage

-- To create our data we use 2 different languages
-- DDL and DML
-- Data Definition Language - define the structure of our database / build tables (CREATE tables,
--  DROP tables)
-- Data Manipulation Language - ADD, EDIT or DELETE data INSIDE our tables (SELECT is an example of
-- a DML being used as well as INSERT, UPDATE and DELETE)