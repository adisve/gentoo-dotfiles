#!/bin/bash

current_temp=$(cat /path/to/temp_sensor) # Example command

if [ "$current_temp" -gt 75 ]; then
    echo "" # Icon for temperature > 75
    echo "#FF0000" # Color for temperature > 75 (Red)
else
    echo "" # Snowflake icon or any other icon for default
    echo "#FFFFFF" # Default color (White or your choice)
fi
