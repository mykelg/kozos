PREFIX  = /usr/local
ARCH    = h8300-elf
BINDIR  = $(PREFIX)/bin
ADDNAME = $(ARCH)-

AR      = $(BINDIR)/$(ADDNAME)ar
AS      = $(BINDIR)/$(ADDNAME)as
CC      = $(BINDIR)/$(ADDNAME)gcc
LD      = $(BINDIR)/$(ADDNAME)ld
NM      = $(BINDIR)/$(ADDNAME)nm
OBJCOPY = $(BINDIR)/$(ADDNAME)objcopy
OBJDUMP = $(BINDIR)/$(ADDNAME)objdump
RANLIB  = $(BINDIR)/$(ADDNAME)ranlib
STRIP   = $(BINDIR)/$(ADDNAME)strip

# FreeBSD-4.x:/dev/cuaaX, FreeBSD-6.x:/dev/cuadX, FreeBSD(USB):/dev/cuaUx
# Linux:/dev/ttySx, Linux(USB):/dev/ttyUSBx, Windows:comX
H8WRITE_SERDEV := /dev/ttyUSB0

#Q := @
SRC_DIR := bootloader
OUT_TARGET_H8_DIR := out/target/h8
BIN_DIR := $(OUT_TARGET_H8_DIR)/bin
OBJ_DIR := $(OUT_TARGET_H8_DIR)/obj
OBJ_BOOTLOADER := $(OBJ_DIR)/$(SRC_DIR)

LOCAL_SRC_FILES :=
LOCAL_SRC_FILES += vector.c
LOCAL_SRC_FILES += startup.s
LOCAL_SRC_FILES += main.c
LOCAL_SRC_FILES += lib.c
LOCAL_SRC_FILES += serial.c
LOCAL_SRC_FILES += xmodem.c
LOCAL_OBJ_FILES := $(subst .c,.o,$(LOCAL_SRC_FILES))
LOCAL_OBJ_FILES := $(subst .s,.o,$(LOCAL_OBJ_FILES))

SRC_FILES := $(addprefix $(SRC_DIR)/,$(LOCAL_SRC_FILES))
OBJ_FILES := $(addprefix $(OBJ_BOOTLOADER)/,$(LOCAL_OBJ_FILES))

TARGET := $(BIN_DIR)/kzload

CFLAGS := -Wall -mh -nostdinc -nostdlib -fno-builtin
CFLAGS += -I$(SRC_DIR)
#CFLAGS += -g
CFLAGS += -Os
CFLAGS += -DKZLOAD

LFLAGS := -static -T $(SRC_DIR)/ld.scr
LFLAGS += -L$(OBJ_BOOTLOADER)

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	$(Q) mkdir -p $(BIN_DIR)
	$(Q) $(CC) $(subst $(OBJ_BOOTLOADER)/vector.o,,$(OBJ_FILES)) -o $(TARGET) $(CFLAGS) $(LFLAGS)
	$(Q) cp $(TARGET) $(TARGET).elf
	$(Q) $(STRIP) $(TARGET)

$(OBJ_BOOTLOADER)/%.o: $(SRC_DIR)/%.c
	$(Q) mkdir -p $(dir $@)
	$(Q) $(CC) $(CFLAGS) -o $@ -c $<

$(OBJ_BOOTLOADER)/%.o: $(SRC_DIR)/%.s
	$(Q) mkdir -p $(dir $@)
	$(Q) $(CC) $(CFLAGS) -o $@ -c $<

$(TARGET).mot: $(TARGET)
	$(Q) $(OBJCOPY) -O srec $(TARGET) $(TARGET).mot

image: $(TARGET).mot

write: $(TARGET).mot $(H8_WRITER)
	$(Q) $(H8_WRITER) -3069 -f20 $(TARGET).mot $(H8WRITE_SERDEV)

clean:
	rm -rf out
