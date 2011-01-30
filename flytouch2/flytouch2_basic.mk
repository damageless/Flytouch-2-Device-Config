# Inherit from those products. Most specific first.
$(call inherit-product, device/gome/flytouch2/device_flytouch2.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)

PRODUCT_NAME := flytouch2_basic
PRODUCT_MANUFACTURER := gome
PRODUCT_DEVICE := flytouch2
