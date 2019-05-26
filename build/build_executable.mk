LOCAL_OBJ_DIR := $(OBJ_DIR)/$(LOCAL_SRC_DIR)

LOCAL_OBJ_FILES := $(LOCAL_SRC_FILES)
LOCAL_OBJ_FILES := $(subst .c,.o,$(LOCAL_OBJ_FILES))
LOCAL_OBJ_FILES := $(subst .s,.o,$(LOCAL_OBJ_FILES))
LOCAL_OBJ_FILES := $(addprefix $(LOCAL_OBJ_DIR)/,$(LOCAL_OBJ_FILES))

LOCAL_CFLAGS := $(CFLAGS) $(LOCAL_CFLAGS)
LOCAL_CFLAGS += -I$(LOCAL_SRC_DIR)
LOCAL_LFLAGS := $(LFLAGS) $(LOCAL_LFLAGS)
LOCAL_LFLAGS += -L$(LOCAL_OBJ_DIR)

LOCAL_TARGET := $(BIN_DIR)/$(LOCAL_MODULE)

$(LOCAL_TARGET): PRIVATE_TARGET := $(LOCAL_TARGET)
$(LOCAL_TARGET): PRIVATE_OBJ_FILES := $(patsubst %vector.o,,$(LOCAL_OBJ_FILES))
$(LOCAL_TARGET): PRIVATE_CFLAGS := $(LOCAL_CFLAGS)
$(LOCAL_TARGET): PRIVATE_LFLAGS := $(LOCAL_LFLAGS)
$(LOCAL_TARGET): $(LOCAL_OBJ_FILES)
	$(Q) mkdir -p $(BIN_DIR)
	$(Q) $(CC) $(PRIVATE_OBJ_FILES) -o $(PRIVATE_TARGET) $(PRIVATE_CFLAGS) $(PRIVATE_LFLAGS)
	$(Q) cp $(PRIVATE_TARGET) $(PRIVATE_TARGET).elf
	$(Q) $(STRIP) $(PRIVATE_TARGET)

PRIVATE_CFLAGS := $(LOCAL_CFLAGS)

$(LOCAL_OBJ_DIR)/%.o: $(LOCAL_SRC_DIR)/%.c
	$(Q) mkdir -p $(dir $@)
	$(Q) $(CC) $(PRIVATE_CFLAGS) -o $@ -c $<

$(LOCAL_OBJ_DIR)/%.o: $(LOCAL_SRC_DIR)/%.s
	$(Q) mkdir -p $(dir $@)
	$(Q) $(CC) $(PRIVATE_CFLAGS) -o $@ -c $<

all: $(LOCAL_TARGET)
