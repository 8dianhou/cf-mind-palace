[¶ install guide: https://www.elastic.co/guide...](https://www.elastic.co/guide/en/elastic-stack/current/installing-elastic-stack.html)

## config logstash
conf_dir: `/etc/logstash`
```
input {
	redis {
		host => $host
		password => $pwd
		data_type => channel
		key => logs
	}
}
output {
    elasticsearch {
        hosts => [ "localhost:9200" ]
    }
#    stdout {
#        codec => json
#    }
}
```

###

- elasticsearch list all indices
	`curl localhost:9200/_cat/indices?v` !do not run this in zsh, use /bin/sh

- elasticsearch delete indices
	`curl -XDELETE localhost:9200/logstash-*`
