#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
rtl_433 -F json -M protocol -M level | $SCRIPTPATH/process_json.sh