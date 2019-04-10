#!/bin/bash
# cluster health
curl 'localhost:9200/_cat/health/?v'
curl 'localhost:9200/_cat/nodes/?v'

# list indices
curl 'localhost:9200/_cat/indices?v'
curl 'localhost:9200/_cat/indices?v&s=index'

# delete index
curl -XDELETE 'localhost:9200/indexname?pretty'
curl -XDELETE --user elastic:changeme 'localhost:9200/indexname?pretty'

# show records
curl 'localhost:9200/indexname/_search?q=user:kimchy'

# delete all indices
curl -XDELETE 'localhost:9200/_all'

curl -XPUT -u elastic 'localhost:9200/_xpack/security/user/elastic/_password' -H "Content-Type: application/json" -d '{
  "password" : "elasticpassword"
}'

curl -XPUT -u elastic 'localhost:9200/_xpack/security/user/kibana/_password' -H "Content-Type: application/json" -d '{
  "password" : "kibanapassword"
}'

curl -XPUT -u elastic 'localhost:9200/_xpack/security/user/logstash_system/_password' -H "Content-Type: application/json" -d '{
  "password" : "logstashpassword"
}'

# templates
curl 'https://search-logs-4hxre7kjyw65yxh4v3zztgpc6y.us-east-1.es.amazonaws.com/_template/'
curl -XPUT -H "Content-Type: application/json" -d '{ "template" : "logstash-*", "settings":{"index.mapping.depth.limit":1} }' 'https://search-logs-4hxre7kjyw65yxh4v3zztgpc6y.us-east-1.es.amazonaws.com/_template/logstash'
curl -XPUT -H "Content-Type: application/json" 'https://search-logs-4hxre7kjyw65yxh4v3zztgpc6y.us-east-1.es.amazonaws.com/_template/logstash' -d '"logstash":{"order":0,"version":50001,"template":"logstash-*","settings":{"index":{"refresh_interval":"5s","mapping.depth.limit":1}},"mappings":{"_default_":{"dynamic_templates":[{"message_field":{"path_match":"message","mapping":{"norms":false,"type":"text"},"match_mapping_type":"string"}},{"string_fields":{"mapping":{"norms":false,"type":"text","fields":{"keyword":{"ignore_above":256,"type":"keyword"}}},"match_mapping_type":"string","match":"*"}}],"_all":{"norms":false,"enabled":true},"properties":{"@timestamp":{"include_in_all":false,"type":"date"},"geoip":{"dynamic":true,"properties":{"ip":{"type":"ip"},"latitude":{"type":"half_float"},"location":{"type":"geo_point"},"longitude":{"type":"half_float"}}},"@version":{"include_in_all":false,"type":"keyword"}}}},"aliases":{}}}'

POST _xpack/security/role/logstash_writer
{
  "cluster": ["manage_index_templates", "monitor"],
  "indices": [
    {
      "names": [ "logstash-*" ],
      "privileges": ["write","delete","create_index"]
    }
  ]
}

POST _xpack/security/user/logstash_internal
{
  "password" : "changeme",
  "roles" : [ "logstash_writer"],
  "full_name" : "Internal Logstash User"
}

POST _xpack/security/role/logstash_reader
{
  "indices": [
    {
      "names": [ "logstash-*" ],
      "privileges": ["read","view_index_metadata"]
    }
  ]
}

POST _xpack/security/user/logstash_user
{
  "password" : "changeme",
  "roles" : [ "logstash_reader"],
  "full_name" : "Kibana User"
}

# save kibana index patterns
elasticdump \
  --input=http://host1:9200/.kibana \
  --input-index=.kibana/index-pattern \
  --output=http://host2:9200/.kibana \
  --output-index=.kibana/index-pattern \
  --type=data
