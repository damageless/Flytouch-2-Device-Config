$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

PRODUCT_NAME := flytouch2
PRODUCT_MANUFACTURER := gome

# XXX how do I add that app properly to the src tree?
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
minus := -

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=ra0 \
    wifi.supplicant_scan_interval=120 \
    dalvik.vm.heapsize=32m \
		rild.libpath=/system/lib/libreference-ril.so \
		ro.kernel.android.checkjni=0 \
		debug.sf.hw=1 \
		debug.sensors.swap_mon_interval=3000 \
		debug.sensors.swap_accel=$(subst _,$(minus),_y,x,z)

# XXX these spaces will be converted to newlines, how to prevent?
#		rild.libargs="-d /dev/ttyUSB2 -u /dev/ttyUSB0" \

FT2RES := device/gome/flytouch2/resources

# Copy files from original firmware. All of these are used to support the hardware.
# Most of these files do not come with source, so until then, just copy the binaries
# and hope it will work. OpenGL driver and kernel + modules do!
PRODUCT_COPY_FILES := \
    $(FT2RES)/initlogo.rle:root/initlogo.rle \
    $(FT2RES)/init.rc:root/init.rc \
    $(FT2RES)/sbin/HDMI:root/sbin/HDMI \
    $(FT2RES)/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    $(FT2RES)/ts.conf:system/etc/ts.conf \
    $(FT2RES)/etc/firmware/rt2870.bin:system/etc/firmware/rt2870.bin \
    $(FT2RES)/etc/firmware/gps/igps.bin:system/etc/firmware/gps/igps.bin \
    $(FT2RES)/etc/Wireless/RT2870STA/RT2870STA.dat:system/etc/Wireless/RT2870STA/RT2870STA.dat \
    $(FT2RES)/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(FT2RES)/etc/aiding.bin:system/etc/aiding.bin \
    $(call find-copy-subdir-files,*,$(FT2RES)/lib,system/lib) \
    $(call find-copy-subdir-files,*,$(FT2RES)/lib/hw,system/lib/hw) \
    $(call find-copy-subdir-files,*,$(FT2RES)/lib/egl,system/lib/egl) \
    $(call find-copy-subdir-files,*,$(FT2RES)/lib/modules,system/lib/modules) \
    $(call find-copy-subdir-files,*,$(FT2RES)/bin,system/bin)

TARGET_CPU_ABI = armeabi

# Add tslib compilation
TARGET_HAVE_TSLIB := true
# Add alsa. For this, make sure to checkout alsa-lib into external/ , and alsa_sound
# into hardware/
BOARD_USES_ALSA_AUDIO := true
# For this, checkout alsa-utils into external/ 
BUILD_WITH_ALSA_UTILS := true
