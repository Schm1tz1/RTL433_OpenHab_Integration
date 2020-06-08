#!/usr/bin/env bash

SCRIPTPATH="$( cd "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"

JQ_FILTER="select(.model == \"GT-WT02\" and .id == 57)"
FIELD_ITEM_MAP="$SCRIPTPATH/field_item_map.txt"
SED_LINE=""

function join_by { local IFS="$1"; shift; echo "$*"; }

declare -A itemMap
for field in $(cat ${FIELD_ITEM_MAP}); do
	mapFrom="$(echo $field | cut -d ';' -f1 | xargs)"
	mapTo="$(echo $field | cut -d ';' -f2 | xargs)"

	SED_LINE+="s/\<$mapFrom\>/$mapTo/g;"
	itemMap+=[$mapFrom]=$mapTo
done

RTL_FIELDS=($(cat ${FIELD_ITEM_MAP} | cut -d ';' -f1))

while read -r sensorData; do
  FILTERED_MESSAGE=$(echo "$sensorData" | jq "$JQ_FILTER | to_entries | from_entries")

  if [[ ! $FILTERED_MESSAGE ]]; then
    echo "Unable to parse RTL433-Message '$sensorData'."
  else

    for key in "${RTL_FIELDS[@]}"; do
	    targetItem=$(echo "$key" | sed "$SED_LINE")
	    value=$(echo "$FILTERED_MESSAGE" | jq ".$key")

	    if [[ ! $value ]]; then
	      echo "Error! No data for field '$key'."
      else
  	    echo "$key : $value -> $targetItem"
        echo "curl -X POST --header "Content-Type: text/plain" --header "Accept: application/json" -d "$value" "http://openhabianpi:8080/rest/items/$targetItem""
      fi
    done

  fi
done
