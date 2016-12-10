#!/bin/sh

hdmimode=720p60hz
bpp=24

for arg in $(cat /proc/cmdline); do
  case ${arg} in
    m_bpp=*) bpp=${arg#*=} ;;
    hdmimode=*) hdmimode=${arg#*=} ;;
  esac
done

# Set framebuffer geometry to match the resolution
case $hdmimode in
  480*)            X=720  Y=480  ;;
  576*)            X=720  Y=576  ;;
  720p*)           X=1280 Y=720  ;;
  *)               X=1920 Y=1080 ;;
esac

M="0 0 $(($X - 1)) $(($Y - 1))"
Y_VIRT=$(($Y * 2))

fbset -fb /dev/fb0 -g $X $Y $X $Y_VIRT $bpp
fbset -fb /dev/fb1 -g 1280 720 1280 1440 32
echo $hdmimode > /sys/class/display/mode
echo 0 > /sys/class/graphics/fb0/free_scale
echo 1 > /sys/class/graphics/fb0/freescale_mode
echo $M > /sys/class/graphics/fb0/free_scale_axis
echo $M > /sys/class/graphics/fb0/window_axis

echo 0 > /sys/class/graphics/fb1/free_scale

#echo 1 > /sys/class/video/disable_video

# Enable scaling for 4K output
case $hdmimode in
  4k*|smpte*|2160*)
    echo 0 0 1919 1079 > /sys/class/graphics/fb0/free_scale_axis
    echo 0 0 3839 2159 > /sys/class/graphics/fb0/window_axis
    echo 1920 > /sys/class/graphics/fb0/scale_width
    echo 1080 > /sys/class/graphics/fb0/scale_height
    echo 0x10001 > /sys/class/graphics/fb0/free_scale
  ;;
esac

# Include deinterlacer into default VFM map
#echo rm default > /sys/class/vfm/map
#echo add default decoder ppmgr deinterlace amvideo > /sys/class/vfm/map

# Enable framebuffer device
echo 0 > /sys/class/graphics/fb0/blank

# Blank fb1 to prevent static noise
echo 1 > /sys/class/graphics/fb1/blank

#for part in /sys/block/*/queue/add_random; do
#  echo 0 > "$part"
#done

#echo 1536000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

#su -c 'echo "audio_on" > /sys/class/amhdmitx/amhdmitx0/config'

#docker daemon

/etc/webmin/start &
