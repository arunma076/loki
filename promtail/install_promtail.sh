#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

wget https://github.com/grafana/loki/releases/download/v2.9.0/promtail-linux-amd64.zip
unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail
sudo chmod +x /usr/local/bin/promtail

sudo mkdir -p /etc/promtail/
sudo mv promtail-local-config.yaml /etc/promtail/

SERVER_NAME=""
sed -i "s/server_name: .*/server_name: ${SERVER_NAME}/g" /etc/promtail/promtail-local-config.yaml

sudo mv promtail.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start promtail.service
sudo systemctl enable promtail.service
sudo systemctl status promtail.service