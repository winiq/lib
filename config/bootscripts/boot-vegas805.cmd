setenv condev "console=ttyS0,115200n8 console=tty0 consoleblank=0 no_console_suspend"
setenv bootargs "root=LABEL=ROOTFS rootwait rw ${condev} logo=osd1,loaded,0x7900000,720p,full hdmimode=${m} m_bpp=${m_bpp} mac=${mac}"
setenv kernel_loadaddr "0x14000000"
setenv dtb_loadaddr "0x11800000"
setenv initrd_loadaddr "0x15000000"
setenv boot_start bootm ${kernel_loadaddr} ${initrd_loadaddr} ${dtb_loadaddr}
if fatload mmc 0 ${initrd_loadaddr} uInitrd; then if fatload mmc 0 ${kernel_loadaddr} uImage; then if fatload mmc 0 ${dtb_loadaddr} dtb.img; then run boot_start;fi;fi;fi;
if fatload usb 0 ${initrd_loadaddr} uInitrd; then if fatload usb 0 ${kernel_loadaddr} uImage; then if fatload usb 0 ${dtb_loadaddr} dtb.img; then run boot_start;fi;fi;fi;
