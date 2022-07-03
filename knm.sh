ps -ef | grep node_monitor | awk -F' '  '{print $2}' | xargs kill -9
