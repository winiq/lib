#!/bin/sh

echo performance | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
wget http://www.phoronix-test-suite.com/benchmark-files/c-ray-1.1.tar.gz
tar xf c-ray-1.1.tar.gz
cd c-ray-1.1/
gcc -O3 -mcpu=cortex-a53 -o c-ray-mt c-ray-mt.c -lm -lpthread && ./c-ray-mt -t 32 -s 320x240 -r 8 -i sphfract -o output.ppm 
cd
