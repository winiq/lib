# This file is licensed under the terms of the GNU General Public
# License version 2. This program is licensed "as is" without any
# warranty of any kind, whether express or implied.
#

build_libmali()
{
	display_alert "Merging and packaging libMali" "@host" "info"
	
	local plugin_dir="armbian-libmali"
	[[ -d "$SOURCES/$plugin_dir" && -n "$SOURCES$plugin_dir" ]] && rm -rf $SOURCES/$plugin_dir
	
	mkdir -p $SOURCES/$plugin_dir/usr/lib
	# overlay our libMali
	cp -R $SRC/lib/bin/libmali-overlay/* $SOURCES/$plugin_dir/usr/lib

	# cleanup what's not needed for sure
	cd $SOURCES/$plugin_dir

	# set up control file
	mkdir -p DEBIAN
	cat <<-END > DEBIAN/control
	Package: armbian-libmali
	Version: $REVISION
	Architecture: $ARCH
	Maintainer: $MAINTAINER <$MAINTAINERMAIL>
	Installed-Size: 1
	Replaces:
	Section: kernel
	Priority: optional
	Description: libMali
	END

	cd $SOURCES
	# pack
	mv armbian-libmali armbian-libmali_${REVISION}_${ARCH}
	dpkg -b armbian-libmali_${REVISION}_${ARCH} >> $DEST/debug/install.log 2>&1
	mv armbian-libmali_${REVISION}_${ARCH} armbian-libmali
	mv armbian-libmali_${REVISION}_${ARCH}.deb $DEST/debs/ || display_alert "Failed moving libmali package" "" "wrn"
}

[[ ! -f $DEST/debs/armbian-libmali_${REVISION}_${ARCH}.deb ]] && build_libmali

# install basic libMali by default
display_alert "Installing libMali" "$REVISION" "info"
chroot $CACHEDIR/$SDCARD /bin/bash -c "dpkg -i /tmp/debs/armbian-libmali_${REVISION}_${ARCH}.deb" >> $DEST/debug/install.log
