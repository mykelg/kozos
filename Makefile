H8_WRITER := out/host/bin/h8write

H8_WRITER_SRC := tools/h8write.c

$(H8_WRITER): $(H8_WRITER_SRC)
	mkdir -p $(dir $@)
	gcc $^ -o $@ -Wall
 
all: $(H8_WRITER)
	echo all

clean:
	rm -rf out/
