#!/bin/bash
#Autor: Felix Brilej

# Filters the slowest query time from the slow-query-log in ms and returns it in a format the monitoring
# tool can understand. Requires the "slow-log" option to be activated in mysql in the first place.
# Beware, the slow-query-log doesnt include all queries, but it is a good place to start (helped us last time).

# Enabling the slow-query-log also decreases performance, so monitoring slow queries might be the very cause
# of performance problems.


testfile="tmpfile"
lastminute="lastminute"

grep -B2 "Query_time" /var/log/mysql/mysql-slow.log > $testfile

mydate=$(date --date='1 minute ago' +"%-H:%-M"); grep -A3 "$mydate:[0-9][0-9]" $testfile > $lastminute
mydate=$(date --date='2 minute ago' +"%-H:%-M"); grep -A3 "$mydate:[0-9][0-9]" $testfile >> $lastminute

lastminute_size=$(wc -l <$lastminute)
if [ $lastminute_size -eq 0 ]; then
	slowest_query=0
else
	slowest_query=$(grep "Query_time" $lastminute | cut -f 3 -d " " | sort -n | tail -n 1)

	# convert seconds to whole miliseconds, since the monitoring tool can only handle whole integer values
	slowest_query=$(expr $slowest_query*1000 | bc)
	slowest_query=$(echo $slowest_query | cut -d "." -f 1)
fi

echo "0:$slowest_query:The slowest query of the mysql-slow log within the last 2 minutes in ms."

