#!/bin/sh

echo '-------------------------------------------------------------------------------'

OUTFILE=/tmp/mpv-deletion

PIDS=$(pidof mpv)

if [ "$(echo "$PIDS" | wc -w)" -ne 1 ] ; then
  echo "Unable to determine mpv's PID from: '$(echo "$PIDS" | xargs)'"
else

IFS='
'
  for FILE in $(
    lsof -p ${PIDS} -Ftn | grep -A1 '^tREG' | grep '^n' \
      | perl -pe 's/^n//; s/ \(.+\)$//' \
      | egrep -i '\.(3gp|asf|avd|avi|dat|divx|fid|flv|mkv|mov|mp4|mp4v|mpeg|mpg|rm|skm|swf|wmv)$'
    ) ; do
    if [ -f "${FILE}" ]; then
        echo "Found: $FILE"
        echo "$FILE" >> $OUTFILE
    fi
  done
fi

echo '-------------------------------------------------------------------------------'
