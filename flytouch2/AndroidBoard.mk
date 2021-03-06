LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_PREBUILT_KERNEL),)
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel
endif

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file): $(TARGET_PREBUILT_KERNEL) | $(ACP)
  $(transform-prebuilt-to-target)

LOCAL_PATH := device/gome/flytouch2
#
include $(CLEAR_VARS)
#
# include more board specific stuff here? Such as Audio parameters.      
#

# We want ALSA support
BUILD_WITH_ALSA_UTILS := true

# And TSLib
TARGET_HAVE_TSLIB := true
