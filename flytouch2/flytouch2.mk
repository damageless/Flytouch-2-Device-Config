$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

PRODUCT_NAME := flytouch2
PRODUCT_MANUFACTURER := gome

# XXX how do I add that app properly to the src tree?
PRODUCT_PACKAGES += \
    TSCalibration

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=ra0 \
    wifi.supplicant_scan_interval=15 \
    dalvik.vm.heapsize=32m

FT2RES := device/gome/flytouch2/resources

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
