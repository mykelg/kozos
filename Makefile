all:
MAKEFILES :=
MAKEFILES += tools/Makefile
MAKEFILES += bootloader/Makefile
MAKEFILES += os/Makefile
include build/Makefile
