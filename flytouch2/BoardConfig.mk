TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_CPU_ABI := armeabi
HAVE_HTC_AUDIO_DRIVER := false
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
# XXX: shouldn't I actually build camera support in there? But how?
USE_CAMERA_STUB := true
