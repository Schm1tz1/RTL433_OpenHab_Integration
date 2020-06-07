# RTL433 OpenHab Integration
Low-tech integration of weather sensors in OpenHAB using RTL-SDR, RTL433 and bash magic

## Installation
- git pull into your home directory (/home/openhabian)
- configure JSON fields and filters to your needs
- sudo ln -is $(readlink -e rtl433_items.service) /lib/systemd/system/
- start service: service rtl433_items start
- check status: service rtl433_items status
- enable on startup: systemctl enable rtl433_items.service
