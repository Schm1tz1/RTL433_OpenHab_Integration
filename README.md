# RTL433 OpenHab Integration
Low-tech integration of weather sensors in OpenHAB using RTL-SDR, RTL433 and bash magic

## Installation
- git pull into your home directory (/home/openhabian)
- modify 'field_item_map.txt' to your needs - it has the format SOURCE_FIELD_RTL433;TARGET_ITEM_OPENHAB
- adapt JQ_FILTER in 'process_json.sh' to select your preferred sensor
- sudo ln -is $(readlink -e rtl433_items.service) /lib/systemd/system/
- start service: service rtl433_items start
- check status: service rtl433_items status
- enable on startup: systemctl enable rtl433_items.service
