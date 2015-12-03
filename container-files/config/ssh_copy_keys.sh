#!/bin/bash

from_path="/config/authorized_keys"
to_path="/root/.ssh/authorized_keys"
to_dir=$(dirname $to_path)

if [[ -f "$from_path" ]]; then
	mkdir -p $to_dir
	chmod 0700 $to_dir
	cp $from_path $to_path
	chmod 0400 $to_path
fi

exit 0
