$(call inherit-product, device/softwinner/wing-common/ProductCommon.mk)


DEVICE_PACKAGE_OVERLAYS := device/softwinner/wing-clover/overlay

# setupfs
PRODUCT_PACKAGES += \
    setupfs \
    e2fsck \
    mke2fs

# gps
BOARD_USES_GPS_TYPE := simulator
PRODUCT_PACKAGES += \
    gps.exDroid \
    Bluetooth \
    VibratorTest

# drm
PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true

# for recovery
PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/recovery.fstab:recovery.fstab \
    device/softwinner/wing-clover/modules/modules/disp.ko:obj/disp.ko \
    device/softwinner/wing-clover/modules/modules/lcd.ko:obj/lcd.ko \
    device/softwinner/wing-clover/modules/modules/hdmi.ko:obj/hdmi.ko \
    device/softwinner/wing-clover/modules/modules/hdcp.ko:obj/hdcp.ko \
    device/softwinner/wing-clover/modules/modules/gt82x.ko:obj/gt82x.ko \
    device/softwinner/wing-clover/modules/modules/gt811.ko:obj/gt811.ko \
    device/softwinner/wing-clover/modules/modules/ft5x_ts.ko:obj/ft5x_ts.ko \
    device/softwinner/wing-clover/modules/modules/zet622x.ko:obj/zet622x.ko \
    device/softwinner/wing-clover/modules/modules/gslX680.ko:obj/gslX680.ko \
    device/softwinner/wing-clover/modules/modules/gt9xx_ts.ko:obj/gt9xx_ts.ko \
    device/softwinner/wing-clover/modules/modules/sw_device.ko:obj/sw_device.ko 

PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/kernel:kernel \
    device/softwinner/wing-clover/init.sun7i.rc:root/init.sun7i.rc \
    device/softwinner/wing-clover/init.recovery.sun7i.rc:root/init.recovery.sun7i.rc \
    device/softwinner/wing-clover/ueventd.sun7i.rc:root/ueventd.sun7i.rc \
    device/softwinner/wing-clover/modules/modules/nand.ko:root/nand.ko

PRODUCT_COPY_FILES += \
	device/softwinner/wing-clover/configs/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/configs/camera.cfg:system/etc/camera.cfg \
    device/softwinner/wing-clover/configs/cfg-Gallery2.xml:system/etc/cfg-Gallery2.xml \
    device/softwinner/wing-clover/configs/gsensor.cfg:system/usr/gsensor.cfg \
    device/softwinner/wing-clover/configs/media_profiles.xml:system/etc/media_profiles.xml \
    device/softwinner/wing-clover/configs/sw-keyboard.kl:system/usr/keylayout/sw-keyboard.kl \
    device/softwinner/wing-clover/configs/ft5x_ts.idc:system/usr/idc/ft5x_ts.idc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml   \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
#    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/initlogo.rle:root/initlogo.rle \
    device/softwinner/wing-clover/media/boot.wav:system/media/boot.wav
    #device/softwinner/wing-clover/media/bootanimation.zip:system/media/bootanimation.zip \  
    #device/softwinner/wing-clover/media/bootlogo.bmp:system/media/bootlogo.bmp \
    #device/softwinner/wing-clover/media/initlogo.bmp:system/media/initlogo.bmp 

ifneq ($(filter 4.%, $(PLATFORM_VERSION)),)
# Android 4.x.x
PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/vold.fstab:system/etc/vold.fstab
else
# otherwise
PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/vold.fstab:system/etc/fstab.sun7i
endif

# for partition mount in mount_all
PRODUCT_COPY_FILES += \
    device/softwinner/wing-clover/fstab.sun7i:root/fstab.sun7i

##### hardware and soft permissions ########

# wifi & bt config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

# Need AppWidget permission to prevent from Launcher's crash, for Android L or later
ifneq ($(wildcard frameworks/native/data/etc/android.software.app_widgets.xml),)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml
endif


####### bt/wifi firmware ##########

# rtl8723au bt + wifi
PRODUCT_COPY_FILES += \
	device/softwinner/common/hardware/realtek/bluetooth/firmware/rtl8723au/rtk8723_bt_config:system/etc/firmware/rtk8723_bt_config \
	device/softwinner/common/hardware/realtek/bluetooth/firmware/rtl8723au/rtk8723a:system/etc/firmware/rtk8723a \
	device/softwinner/common/hardware/realtek/bluetooth/firmware/rtl8723au/rtk_btusb.ko:system/vendor/modules/rtk_btusb.ko


# rtl8723as bt fw and config
#PRODUCT_COPY_FILES += \
#   device/softwinner/wing-common/hardware/realtek/bluetooth/rtl8723as/rlt8723a_chip_b_cut_bt40_fw.bin:system/etc/rlt8723a_chip_b_cut_bt40_fw.bin \
#   device/softwinner/wing-common/hardware/realtek/bluetooth/rtl8723as/rtk8723_bt_config:system/etc/rtk8723_bt_config

# bcm40181 sdio wifi fw and nvram
#PRODUCT_COPY_FILES += \
#   hardware/broadcom/wlan/firmware/bcm40181/fw_bcm40181a2_p2p.bin:system/vendor/modules/fw_bcm40181a2_p2p.bin \
#   hardware/broadcom/wlan/firmware/bcm40181/fw_bcm40181a2_apsta.bin:system/vendor/modules/fw_bcm40181a2_apsta.bin \
#   hardware/broadcom/wlan/firmware/bcm40181/fw_bcm40181a2.bin:system/vendor/modules/fw_bcm40181a2.bin \
#   hardware/broadcom/wlan/firmware/bcm40181/bcm40181_nvram.txt:system/vendor/modules/bcm40181_nvram.txt

# bcm40183 sdio wifi fw and nvram
#PRODUCT_COPY_FILES += \
#   hardware/broadcom/wlan/firmware/bcm40183/fw_bcm40183b2_p2p.bin:system/vendor/modules/fw_bcm40183b2_p2p.bin \
#   hardware/broadcom/wlan/firmware/bcm40183/fw_bcm40183b2_apsta.bin:system/vendor/modules/fw_bcm40183b2_apsta.bin \
#   hardware/broadcom/wlan/firmware/bcm40183/fw_bcm40183b2.bin:system/vendor/modules/fw_bcm40183b2.bin \
#   hardware/broadcom/wlan/firmware/bcm40183/bcm40183_nvram.txt:system/vendor/modules/bcm40183_nvram.txt

# ap6210 sdio wifi fw and nvram
PRODUCT_COPY_FILES += \
#   hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2.bin:system/vendor/modules/fw_bcm40181a2.bin \
#   hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2_apsta.bin:system/vendor/modules/fw_bcm40181a2_apsta.bin \
#   hardware/broadcom/wlan/firmware/ap6210/fw_bcm40181a2_p2p.bin:system/vendor/modules/fw_bcm40181a2_p2p.bin \
#   hardware/broadcom/wlan/firmware/ap6210/nvram_ap6210.txt:system/vendor/modules/nvram_ap6210.txt \
#   hardware/broadcom/wlan/firmware/ap6210/bcm20710a1.hcd:system/vendor/modules/bcm20710a1.hcd

# When set ro.sys.adaptive_memory=1, firmware can adaptive different dram size.
# And dalvik vm parameters configuration will become invalid.
PRODUCT_PROPERTY_OVERRIDES += \
	ro.sys.adaptive_memory=1

# dalvik vm parameters
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=256m \
    dalvik.vm.heapstartsize=8m \
    dalvik.vm.heapgrowthlimit=96m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

# usb
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb \
    ro.udisk.lable=WING \
    ro.debuggable=1 

# ui
PRODUCT_PROPERTY_OVERRIDES += \
    ro.property.tabletUI=false \
    ro.sf.lcd_density=120 \
    ro.property.fontScale=1.4

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.firmware=v3.0.1

# function
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.mode=DISABLED \
    ro.sys.bootfast=true

# default language setting
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.country=CN \
    persist.sys.timezone=Asia/Shanghai \
    persist.sys.language=zh

# disable preloading of libEGL, which would block
# Zygote from booting up, as Mali libEGL can create
# threads which violates Zygote's boot design.
# See dalvik/src/main/java/dalvik/system/Zygote.java
# for detail.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zygote.disable_gl_preload=true

$(call inherit-product-if-exists, device/softwinner/wing-clover/modules/modules.mk)

# Overrides
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_BRAND := Android
PRODUCT_NAME := wing_clover
PRODUCT_DEVICE := wing-clover
PRODUCT_MODEL := AOSP on clover
PRODUCT_MANUFACTURER := SHENZHEN RERVISION CO,. Ltd
