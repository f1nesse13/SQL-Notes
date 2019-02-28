-- Each value we want needs to be followed by its type (INTEGER, TEXT, etc.)
    -- NOT NULL makes sure when we enter data that the value has to be there to add it to the table
    -- FOREIGN KEY allows us to connect two tables together passing the two ids theyre connected by
    -- PRIMARY KEY definition - 
    -- A primary key, also called a primary keyword, is a key in a relational database that is unique for each record. It is a unique identifier, such as a driver license number, telephone number (including area code), or vehicle identification number (VIN). A relational database must always have one and only one primary key. Also guarentee value is NOT NULL
    -- These CREATE TABLES are a example of a DDL


CREATE TABLE plays (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    year INTEGER NOT NULL,
    playwright_id INTEGER NOT NULL,

    FOREIGN KEY (playwright_id) REFERENCES playwrights(id)
);

CREATE TABLE playwrights (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    birth_year INTEGER
);

-- We will use DML to add the data to the tables
-- We have to start with playwrights table because of our foreign key in plays - We cannot add to plays
-- without the reference in playwrights

INSERT INTO
    playwrights (name, birth_year) -- ID will be generated by SQL
VALUES
    ('Arthur Miller', 1915),
    ('Eugene O''Neill', 1888); -- To insert a ' we need to use '' when we need a ' inside of quotes

INSERT INTO
    plays (title, year, playwright_id)
VALUES
    ('All My Sons', 1947, (SELECT id FROM playwrights WHERE name='Arthur Miller')), -- We can embed the
    -- playwright id by querying the table inside our VALUES definition
    ('Long Day''s Journey Into Night', 1956, (SELECT id FROM playwrights WHERE name='Eugene O''Neill'));

    -- This file will construct and partially seed our database
    -- in order to generate the database we need to run cat import_db_demo.sql | sqlite3 plays.db in bash
    -- what this means is we want to concatenate the information in this file to a sqlite3 plays.db file
    -- and thats where the database will be stored (inside the file)
    -- Once we create the .db file we can connect using sqlite3 filename
    -- Some important cmds include .tables and .schema as well as ability to run queries and build
    -- onto the tables
    
    -- We can load sqlite3 and our db to issue commands in pry by loading pry
    -- using "require 'sqlite3'" and SQLite3::Database.new(db_filename) to create an instance

    -- After we create the instance we can access the database using the supplied method .execute and passing
    -- a query/insert as an argument eg: plays_db = SQLite3::Database.new(plays.db)
    -- plays_db.execute('SELECT * FROM playwrights')