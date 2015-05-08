#! /usr/bin/env bash
set -eu

# Proxy signals
function kill_app(){
/usr/local/Calpont/bin/infinidb stop
exit $? # exit okay
}
trap "kill_app" SIGINT SIGTERM

# Launch daemon
/usr/local/Calpont/bin/infinidb restart
sleep 2

# Loop while infinidb is running
while /usr/local/Calpont/bin/infinidb status | grep -q "InfiniDB is running"; do
sleep 0.5
done
exit 1000 # exit unexpected
