# vim: syn=sql
influx
CREATRE DATABASE process
USE process
CREATE USER "grafana" WITH PASSWORD 'grafana' WITH ALL PRIVILEGES
DROP DATABASE collectd
CREATE DATABASE collectd

SHOW SERIES
SELECT * FROM swap_value
DROP SERIES FROM temperature WHERE machine='jessie'

SELECT * from disk_read WHERE "type" = 'disk_octets' limit 10000

CREATE DATABASE telegraf
CREATE USER "telegraf" WITH PASSWORD 'telegraf' WITH ALL PRIVILEGES
CREATE RETENTION POLICY six_month_only ON telegraf_database DURATION 26w REPLICATION 1 DEFAULT
GRANT ALL ON telegraf_database TO telegraf
SHOW GRANTS FOR telegraf
