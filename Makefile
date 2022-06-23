BUILD_DIR := build

default: clox

clean:
	@ rm -rf $(BUILD_DIR)

# Compile a debug build of clox
debug:
	@ $(MAKE) -f c.mk NAME=cloxd MODE=debug SOURCE_DIR=src

# Compile the C interpreter
clox:
	@ $(MAKE) -f c.mk NAME=clox MODE=release SOURCE_DIR=src

.PHONY: debug clox clean default 


