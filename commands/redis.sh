# redis-stat: vmstat like output of info
gem install redis-stat
redis-stat localhost:6379 1 10 --verbose

# redsmin web interface
npm install -g redsmin@latest
REDSMIN_KEY=5967f51501ab1ba4060e4c44 redsmin
redis://user:auth@domain.tld:port

# to monitor
redis-cli monitor
redis-benchmark -c 10 -n 100000 -q
telnet localhost 6379

redis-cli info # server, clients, memory, persistence, stats, replication, cpu, commandstats, cluster, keyspace
redis-cli -h jumponit-stage.ys76rf.0001.use1.cache.amazonaws.com -p 6379
redis-cli -r "keys *" -i 5 # repeat keys * every 5 seconds
redis-cli --stat # print rolling stats about server: mem, clients...

# redis-cli
info keyspace
keys *
dbsize
select 1
redis-cli --scan --pattern '*' # doesn't tie up redis

# removing
redis-cli flushall

# adding and getting
SET mykey "HELLO"
GET mykey

# lists
RPUSH mylist "one"
RPUSH mylist "two"
LSET mylist 0 "four"
LRANGE mylist 0 -1 # "four", "two"
LLEN mylist # 2
LREM mylist -2 "three" # remove first 2 occurences of 'three'
redis-cli KEYs "prefix:*" | xargs redis-cli DEL

# what metrics to watch for in performance monitoring
# https://www.datadoghq.com/blog/how-to-collect-redis-metrics/
# https://www.datadoghq.com/blog/how-to-monitor-redis-performance-metrics/

# to connect to aws redis, connect to ec2 instance in vpc
wget http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
src/redis-cli -c -h jumponit-stage.ys76rf.0001.use1.cache.amazonaws.com # taponit.ys76rf.ng.0001.use1.cache.amazonaws.com
src/redis-cli -c -h taponit.ys76rf.ng.0001.use1.cache.amazonaws.com --scan --pattern '*'

ssh_toi -N -L 4000:taponit.ys76rf.ng.0001.use1.cache.amazonaws.com:6379 ec2-user@52.205.254.219 &
redis-cli -p 4000
