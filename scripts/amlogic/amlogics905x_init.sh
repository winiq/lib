#!/bin/sh

#su -c 'echo "audio_on" > /sys/class/amhdmitx/amhdmitx0/config'

#docker daemon

#/etc/webmin/start &

#workaround to fix kernel setting permissions
dmesg -n 1
chmod 666 /sys/class/graphics/fb*/scal*
echo 16 | tee /sys/module/amvdec_h265/parameters/dynamic_buf_num_margin
chmod 666 /sys/class/display/mode
chmod 666 /sys/class/video/axis
chmod 666 /sys/class/video/screen_mode
chmod 666 /sys/class/video/disable_video
chmod 666 /sys/class/tsync/pts_pcrscr
chmod 666 /sys/class/audiodsp/digital_raw
chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 666 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

chmod 666 /dev/amvideo
chmod 666 /dev/amstream*
chmod 666 /sys/class/ppmgr/ppmgr_3d_mode
