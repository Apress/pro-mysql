-----------------------------------------------------------------------------

Each folder contains a create_*.sql file that contains 
a set of SQL statements that are featured in the chapter. 
Each .sql file contains the commands to set up the database, 
tables, data and database object (procedure, function, trigger, view etc).

If you don't see any files for a specific chapter, that means that either
we weren't dealing with SQL scripts in that chapter, OR we meant for
you to follow along with the smaller listing samples yourself.

In linux, You can easily set up your MySQL database 
to look like the one used in each chapter by piping 
the SQL statements into the database:

#> cat create_triggers.sql | mysql

in Windows, you can use the mysql client's SOURCE 
command, making sure you are in the correct working 
directory where the code is located:

mysql> SOURCE C:\pro_mysql_source\Chapter4\create.sql

-----------------------------------------------------------------------------

NOTE ON Chapter 8 use of ZCTA data.

For your convenience, we've done two data dumps of the actual zip code
tabulation areas condensed from the US census data.  You are free to 
use either the zcta.sql or the zcta.txt files to populate your 
database.

Note that the zcta.sql file is a dump file containing the SQL statements
to create the table we use in the chapter if you are following along 
step by step in the material.  The zcta.txt file contains a dump of the
data in the final ZCTA table, including the converted radians measurements.
Feel free to use this data dump file to load up a production database
quickly using the LOAD DATA INFILE command.

-----------------------------------------------------------------------------
