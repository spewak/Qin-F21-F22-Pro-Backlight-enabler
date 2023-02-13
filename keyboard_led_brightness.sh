#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

LCD_BRIGHTNESS_FILE=/sys/class/leds/lcd-backlight/brightness

for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do
LCD_VALUE=$(cat ${LCD_BRIGHTNESS_FILE})

# Enable keyboard backlight if LCD is on. Led values can range between 0 and 6. led2 increases brightness further
if [[ ${LCD_VALUE} != '0' && -d "/sys/class/leds/mt6370_pmu_led1" ]]; then

	echo 1 > /sys/class/leds/mt6370_pmu_led1/brightness
	echo 1 > /sys/class/leds/mt6370_pmu_led2/brightness

# Disable keyboard backlight if LCD is off
elif [[ ${LCD_VALUE} == '0' && -d "/sys/class/leds/mt6370_pmu_led1" ]]; then

	echo 0 > /sys/class/leds/mt6370_pmu_led1/brightness
	echo 0 > /sys/class/leds/mt6370_pmu_led2/brightness

elif [[ ${LCD_VALUE} != '0' && -d "/sys/class/leds/button-backlight" ]]; then

	echo 1 > /sys/class/leds/button-backlight/brightness

elif [[ ${LCD_VALUE} == '0' && -d "/sys/class/leds/button-backlight" ]]; then

	echo 0 > /sys/class/leds/button-backlight/brightness
	
fi
sleep 3

	LCD_VALUE=$(cat ${LCD_BRIGHTNESS_FILE}) 
	 
if [[ ${LCD_VALUE} == '0' && -d "/sys/class/leds/button-backlight" ]]; then
     
	echo 0 > /sys/class/leds/button-backlight/brightness
	break
elif [[ -d "/sys/class/leds/mt6370_pmu_led1" ]]; then
exit 0
fi
done
exit 0
