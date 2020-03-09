#!/bin/bash
echo waiting for build
FILE=/commands/start
while [ ! -f "$FILE" ]; do
  echo "$FILE does not exist"
  sleep 1s
done
if [ -f /commands/config.json ]; then
    echo copy docker creds from /commands/config.json to /kaniko/.docker/config.json
    cp /commands/config.json /kaniko/.docker/config.json
fi
if [ -f /commands/run ]; then
    echo running command /commands/run
    # cat /commands/run
    set -o pipefail
    sh -c /commands/run 2>&1 | tee /commands/output
    rc=$?
    echo done with code $rc
    if [ $rc != 0 ]
    then
      echo "error: $rc" | tee -a /commands/output
      touch /commands/code_error
    else
      touch /commands/code_ok
    fi
else
    echo /commands/run not found.
    touch /commands/code_error
fi
touch /commands/done
