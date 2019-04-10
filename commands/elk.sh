# create db and insert
curl -XPOST "http://localhost:8086/query" --data-urlencode "q=CREATE DATABASE test_db"
curl -XPOST "http://localhost:8086/query" --data-urlencode "q=SHOW DATABASES"
curl -XPOST "http://localhost:8086/write?db=mydb" -d 'cpu,host=server01,region=uswest load=42 1434055562000000000'
curl -XPOST "http://localhost:8086/write?db=mydb" -d 'cpu,host=server02,region=uswest load=78 1434055562000000000'
curl -XPOST "http://localhost:8086/write?db=mydb" -d 'cpu,host=server03,region=useast load=15.4 1434055562000000000'
# query and analyze
curl -G "http://localhost:8086/query?pretty=true" --data-urlencode "db=mydb" --data-urlencode "q=SELECT * FROM cpu WHERE host='server01' AND time < now() - 1d"
curl -G "http://localhost:8086/query?pretty=true" --data-urlencode "db=mydb" --data-urlencode "q=SELECT mean(load) FROM cpu WHERE region='uswest'"
