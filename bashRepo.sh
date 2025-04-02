#!/bin/bash


FREE_SPACE=$(free -mt | grep "Total" | awk '{print $4}')
TH=1000

if [[ $FREE_SPACE -lt $TH ]]
then
        echo "⚠️ Warning , RAM Is Running Low"
else
        echo "✅ Your Are Good To Go"
fi



CPU_LOAD=$(top -bn1 | grep "load average:" | awk '{print $10}' | sed 's/,//')
THRESHOLD=2.0
if (( $(echo "$CPU_LOAD > $THRESHOLD" | bc -l) )); then
    echo "⚠️ Warning: High CPU usage detected! Current load: $CPU_LOAD"
else
    echo "✅ CPU usage is within normal limits. Current load: $CPU_LOAD"
fi




BATTERY_LEVEL=$(upower -i $(upower -e | grep BAT) | grep "percentage" | awk '{print $2}' | sed 's/%//')

THRESHOLD=20

if [[ $BATTERY_LEVEL -lt $THRESHOLD ]]; then
    echo "⚠️ Warning: Battery level is low ($BATTERY_LEVEL%)"
else
    echo "🔋 Battery level is good ($BATTERY_LEVEL%)"
fi



TOTAL_MEMORY=$(free -m | grep Mem: | awk '{print $2}')
USED_MEMORY=$(free -m | grep Mem: | awk '{print $3}')


MEMORY_USAGE=$((USED_MEMORY * 100 / TOTAL_MEMORY))

THRESHOLD=90

if [ "$MEMORY_USAGE" -gt "$THRESHOLD" ]; then
    echo "⚠️ High memory usage: $MEMORY_USAGE%"
else
    echo "✅ Memory usage is normal: $MEMORY_USAGE%"
fi




UPTIME_SECONDS=$(cat /proc/uptime | awk '{print $1}')


UPTIME_HOURS=$(echo "$UPTIME_SECONDS / 3600" | bc)

THRESHOLD=48

if [ "$UPTIME_HOURS" -gt "$THRESHOLD" ]; then
    echo "⚠️ System has been running for a long time ($UPTIME_HOURS hours). Consider rebooting."
else
    echo "✅ System uptime is normal: $UPTIME_HOURS hours."
fi



CPU_TEMP=$(cat /sys/class/thermal/coolin/temp)
CPU_TEMP_C=$((CPU_TEMP / 1000))

THRESHOLD=80

if [ "$CPU_TEMP_C" -gt "$THRESHOLD" ]; then
    echo "⚠️ CPU temperature is high: $CPU_TEMP_C°C"
else
    echo "✅ CPU temperature is normal: $CPU_TEMP_C°C"
fi






LOAD_AVERAGE=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}')

THRESHOLD=2.0  # Load average threshold

if (( $(echo "$LOAD_AVERAGE > $THRESHOLD" | bc -l) )); then
    echo "⚠️ High system load: $LOAD_AVERAGE"
else
    echo "✅ System load is normal: $LOAD_AVERAGE"
fi

