#!/bin/bash

for net in $(seq 1 254); do
  timeout 1 bash -c "ping -c 1 10.10.18.$net" &>/dev/null && echo "[+] 10.10.18.$net IP-RECHEABLE" &
done
wait
