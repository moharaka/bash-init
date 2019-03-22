#!/bin/sh

#argument: Applicaiton path
APP=$*

__log()
{
	echo $*
}


CHILD_PROCESS=-1

start_process()
{
	__log "running process $APP"
	$APP &
	CHILD_PROCESS=$!
}


__handler()
{
	__log "Trapped signal is: $1"
	__log "Child process is: $CHILD_PROCESS"
	kill -s $1 $CHILD_PROCESS 
  	exit 0
}

trap_signals()
{
	func="$1" ; shift
    	for sig ; do
        	trap "$func $sig" "$sig"
    	done
}

handle_signals()
{
	trap_signals __handler $(seq 64)
	while true; do : ; done
}


### Start child process ###
start_process

### Handle signals ###
handle_signals
