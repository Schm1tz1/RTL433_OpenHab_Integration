#!/usr/bin/env bash

while read -r sensorData; do
  result=($(echo "$sensorData" | jq 'select(.model == "GT-WT02" and .id == 57) | .temperature_C,.humidity'))

  if [ ${#result[@]} -eq 0 ]; then
    echo "Unable to parse RTL433-Message '$sensorData'."
  else
    echo "curl -X POST --header "Content-Type: text/plain" --header "Accept: application/json" -d "${result[0]}" "http://openhabianpi:8080/rest/items/Sensor_Weather_Temp""
    echo "curl -X POST --header "Content-Type: text/plain" --header "Accept: application/json" -d "${result[1]}" "http://openhabianpi:8080/rest/items/Sensor_Weather_Humidity""
  fi
done

