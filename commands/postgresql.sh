#!/bin/bash

apt-get install postgresql postgresql-client postgresql-doc phppgadmin

adduser pguser
sudo su -c "ZDOTDIR=/home/vagrant" postgres
# sudo -u postgres ZDOTDIR=/home/vagrant zsh
createuser pguser
createdb -O pguser mypg_db
su  - pguser
psql mypg_db # psql -H localhost -U postgres

wget http://www.postgresqltutorial.com/wp-content/uploads/2017/10/dvdrental.zip
createdb dvdrental
pg_restore -U postgres -d dvdrental ./dvdrental.tar
psql -c "grant all privileges on database <dbname> to <username>"
# GRANT CONNECT ON <dbname> to <username>
# GRANT USAGE ON SCHEMA public TO username; ...
# GRANT SELECT ON table_name TO username; ...
# GRANT SELECT ON ALL TABLES IN SCHEMA public TO username; ...
# ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO username;
# GRANT SELECT, INSERT, UPDATE on <dbname> TO PUBLIC
# GRANT { { SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | ALL } [ PRIVILEGES ] }
#     ON { [ TABLE ] table_name [, ...]
#          | ALL TABLES IN SCHEMA schema_name [, ...] }
#     TO { [ GROUP ] role_name | PUBLIC } [, ...] [ WITH GRANT OPTION ]

# psql listing (S => show system objects, + verbose)
\l[+] # databases
\du[S+] # users
\dt[S+] # tables
\di[S+] # indexes
\dT[S+] # datatypes
\dp # table, view, and sequence access privileges

# psql formatting
\t # show only rows
\a # toggle aligned output
\x # toggle expanded output
\pset [NAME [VALUE]] # set table output:
# border|columns|expanded|feldsep|fieldsep_zero|footer|format|linestyle|null|numericlocale|pager|pager_min_lines|recordsep|recordsep_zero|tableattr|title|tuples_only|unicode_border_linestyle|unicode_column_linestyle

\e [FILE] # edit the query buffer
\ef [FUNCNAME] | \ev [VIEWNAME] # edit function/view definiition
\p # show contents of query buffer
\r # reset query buffer
\w FILE # write query buffer to file

\watch [SEC] # execute query every SEC
