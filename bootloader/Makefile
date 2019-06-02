include $(CLEAR_VARS)

LOCAL_MODULE := kzload

LOCAL_SRC_FILES :=
LOCAL_SRC_FILES += vector.c
LOCAL_SRC_FILES += startup.s
LOCAL_SRC_FILES += main.c
LOCAL_SRC_FILES += lib.c
LOCAL_SRC_FILES += serial.c
LOCAL_SRC_FILES += xmodem.c
LOCAL_SRC_FILES += elf.c
LOCAL_SRC_FILES += intr.S
LOCAL_SRC_FILES += interrupt.c

LOCAL_SRC_DIR := bootloader
LOCAL_CFLAGS := -DKZLOAD
LOCAL_LFLAGS := -T $(LOCAL_SRC_DIR)/ld.scr

include $(BUILD_EXECUTABLE)

TARGET_KZLOAD := $(BIN_DIR)/$(LOCAL_MODULE)

$(TARGET_KZLOAD).mot: $(TARGET_KZLOAD)
	$(Q) $(OBJCOPY) -O srec $(TARGET_KZLOAD) $(TARGET_KZLOAD).mot

image: $(TARGET_KZLOAD).mot

# FreeBSD-4.x:/dev/cuaaX, FreeBSD-6.x:/dev/cuadX, FreeBSD(USB):/dev/cuaUx
# Linux:/dev/ttySx, Linux(USB):/dev/ttyUSBx, Windows:comX
H8WRITE_SERDEV := /dev/ttyUSB0
write: $(TARGET_KZLOAD).mot $(H8_WRITER)
	$(Q) $(H8_WRITER) -3069 -f20 $(TARGET_KZLOAD).mot $(H8WRITE_SERDEV)
