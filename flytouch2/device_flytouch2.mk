PRODUCT_PACKAGES += \
    TSCalibration

# checkjni: enable by eng build, but makes some apps fail
# debug.sf.hw: Use GPU to render interface
# scan_interval: only used when not in range of remembered access points. Saves
#                battery life then
# rild*: Use reference implementation which fakes all phone-related features
# debug.sensors*: Used to swap the accelerometer, as it's misplaced at 90 degrees.
#                 Some games break because of this, so they can be swapped back on 
#                 demand by the user by monitoring the property every X milliseconds.
# log.redirect-stdio: See stdout/stderr output in the logs (for debugging)
# opencore.asmd : video decoding acceleration (I think)
minus := -

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=ra0 \
    wifi.supplicant_scan_interval=120 \
    dalvik.vm.heapsize=32m \
		rild.libpath=/system/lib/libreference-ril.so \
		ro.kernel.android.checkjni=0 \
		debug.sf.hw=1 \
		debug.sensors.swap_mon_interval=3000 \
		debug.sensors.swap_accel=$(subst _,$(minus),_y,x,z) \
		opencore.asmd=1\
		log.redirect-stdio=false

# XXX these spaces will be converted to newlines, how to prevent?
#		rild.libargs="-d /dev/ttyUSB2 -u /dev/ttyUSB0" \

FT2RES := device/gome/flytouch2/resources
FW1170 := $(FT2RES)/fw1170
ZT180  := $(FT2RES)/zt180_froyo

# Copy files from several different firmwares. 
# Most of these files do not come with source, so until then, just copy the binaries
# and hope it will work.

#PRODUCT_COPY_FILES := \
#    $(call find-copy-subdir-files,*,$(FT2RES)/lib,obj/lib)

# Copy custom written files
#    $(FT2RES)/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Copy files from zt180 froyo firmware
PRODUCT_COPY_FILES = \
    $(call find-copy-subdir-files,*,$(ZT180)/lib,system/lib) \
    $(call find-copy-subdir-files,*,$(ZT180)/lib/hw,system/lib/hw)

# Copy custom files
PRODUCT_COPY_FILES += \
    $(FT2RES)/init.rc:root/init.rc \
    $(call find-copy-subdir-files,*,$(FT2RES)/etc,system/etc)
	
# Copy files from official firmware v1170
PRODUCT_COPY_FILES += \
		$(FW1170)/rootinfo.conf:root/rootinfo.conf \
    $(FW1170)/initlogo.rle:root/initlogo.rle \
    $(FW1170)/sbin/HDMI:root/sbin/HDMI \
    $(FW1170)/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    $(FW1170)/etc/firmware/rt2870.bin:system/etc/firmware/rt2870.bin \
    $(FW1170)/etc/firmware/gps/igps.bin:system/etc/firmware/gps/igps.bin \
    $(FW1170)/etc/Wireless/RT2870STA/RT2870STA.dat:system/etc/Wireless/RT2870STA/RT2870STA.dat \
    $(call find-copy-subdir-files,*,$(FW1170)/etc,system/etc) \
    $(call find-copy-subdir-files,*,$(FW1170)/lib,system/lib) \
    $(call find-copy-subdir-files,*,$(FW1170)/lib/hw,system/lib/hw) \
    $(call find-copy-subdir-files,*,$(FW1170)/lib/egl,system/lib/egl) \
    $(call find-copy-subdir-files,*,$(FW1170)/lib/modules,system/lib/modules) \
    $(call find-copy-subdir-files,*,$(FW1170)/bin,system/bin) \
    $(call find-copy-subdir-files,*,$(FW1170)/app,system/app)

# Copy files from archos market addon
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(FT2RES)/market/system/lib,system/lib) \
    $(call find-copy-subdir-files,*,$(FT2RES)/market/system/app,system/app) \
    $(call find-copy-subdir-files,*,$(FT2RES)/market/system/framework,system/framework)

# Include audio media such as default ringtones
#include frameworks/base/data/sounds/OriginalAudio.mk
$(call inherit-product, frameworks/base/data/sounds/OriginalAudio.mk)
