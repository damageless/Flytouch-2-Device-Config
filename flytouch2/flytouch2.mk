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

PRODUCT_COPY_FILES := \
    device/gome/flytouch2/init.rc:root/init.rc \
		device/gome/flytouch2/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
		device/gome/flytouch2/ts.conf:system/etc/ts.conf

TARGET_CPU_ABI = armeabi

# Add tslib compilation
TARGET_HAVE_TSLIB := true
# XXX ts.conf must also exist in /system/etc... ?
