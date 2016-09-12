setenv m "720p"
setenv vout_mode "hdmi"
setenv m_bpp "32"
setenv condev "console=ttyS0,115200n8 console=tty0 consoleblank=0"
setenv bootargs "root=LABEL=ROOTFS rootwait rw ${condev} no_console_suspend logo=osd1,loaded,0x7900000,720p,full hdmimode=${m} m_bpp=${m_bpp} vout=${vout_mode}"
setenv loadaddr "0x21000000"
setenv dtb_loadaddr "0x21800000"
setenv initrd_loadaddr "0x22000000"
setenv boot_start bootm ${loadaddr} ${initrd_loadaddr} ${dtb_loadaddr}
if fatload usb 0:1 ${dtb_loadaddr} dtb.img; then setenv dtb_img "1"; else if store dtb read $dtb_loadaddr; then setenv dtb_img "1"; else setenv dtb_img "0";fi;fi;
if fatload usb 0:1 ${initrd_loadaddr} uInitrd; then if fatload usb 0:1 ${loadaddr} zImage; then if test "${dtb_img}" = "1"; then run boot_start;fi;fi;fi;
if fatload mmc 0:1 ${dtb_loadaddr} dtb.img; then setenv dtb_img "1"; else if store dtb read $dtb_loadaddr; then setenv dtb_img "1"; else setenv dtb_img "0";fi;fi;
if fatload mmc 0:1 ${initrd_loadaddr} uInitrd; then if fatload mmc 0:1 ${loadaddr} zImage; then if test "${dtb_img}" = "1"; then run boot_start;fi;fi;fi;
