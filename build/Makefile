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

#Q := @
OUT_TARGET_H8_DIR := out/target/h8
BIN_DIR := $(OUT_TARGET_H8_DIR)/bin
OBJ_DIR := $(OUT_TARGET_H8_DIR)/obj

CFLAGS :=
CFLAGS += -Wall -mh -nostdinc -nostdlib -fno-builtin
#CFLAGS += -g
CFLAGS += -Os

LFLAGS :=
LFLAGS += -static

CLEAR_VARS := build/clear_vars.mk
BUILD_EXECUTABLE := build/build_executable.mk

$(foreach mkfile,$(MAKEFILES),$(eval include $(mkfile)))

all:

clean:
	rm -rf out
