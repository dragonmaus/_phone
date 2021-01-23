#!/bin/sh
termux-dialog -p -t "${1:-Password:}" | jq -j .text
