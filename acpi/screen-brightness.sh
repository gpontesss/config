#!/bin/bash

## Got to put some usage here later...

usage() {
	echo \
'This should be the usage. Seeing this imply you did something wrong...'
	exit 1
}

BASE_PATH=/sys/class/backlight/intel_backlight
MAX_BRIGHTNESS=$(cat $BASE_PATH/max_brightness)
CURRENT_BRIGHTNESS=$(cat $BASE_PATH/brightness)

case $1 in
	"inc")
		NEW_VALUE=$(expr $CURRENT_BRIGHTNESS + $2)
		[[ $NEW_VALUE -gt $MAX_BRIGHTNESS ]] && NEW_VALUE=$MAX_BRIGHTNESS
		echo $NEW_VALUE
		;;
	"dec")
		NEW_VALUE=$(expr $CURRENT_BRIGHTNESS - $2)
		[[ 0 -gt $NEW_VALUE ]] && NEW_VALUE=0
		;;
	*) usage ;;
esac

echo $NEW_VALUE > $BASE_PATH/brightness || usage
