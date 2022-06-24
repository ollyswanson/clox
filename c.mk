# Makefile for building the C interpreter, stolen shamelessly from the Crafting 
# Interpreters repo

CFLAGS := -std=c99 -Wall -Wextra -Wno-unused-parameter

# If we're building at a point in the middle of the chapter, don't fail if there
# are functions that aren't used yet.
ifeq ($(SNIPPET),true)
	CFLAGS += -Wno-unused-function
endif

# Mode configuration
ifeq ($(MODE),debug)
	CFLAGS += -O0 -DDEBUG -g -fsanitize=address
	BUILD_DIR := build/debug
else
	CFLAGS += -O3 -flto
	BUILD_DIR := build/release
endif

HEADERS := $(wildcard $(SOURCE_DIR)/*.h)
SOURCES := $(wildcard $(SOURCE_DIR)/*.c)
OBJECTS := $(addprefix $(BUILD_DIR)/$(NAME)/, $(notdir $(SOURCES:.c=.o)))

# Link the interpreter
build/$(NAME): $(OBJECTS)
	@ printf "%8s %-40s %s\n" $(CC) $@ "$(CFLAGS)"
	@ mkdir -p build
	@ $(CC) $(CFLAGS) $^ -o $@

# Compile object files
$(BUILD_DIR)/$(NAME)/%.o: $(SOURCE_DIR)/%.c $(HEADERS)
	@ printf "%8s %-40s %s\n" $(CC) $< "$(CFLAGS)"
	@ mkdir -p $(BUILD_DIR)/$(NAME)
	@ $(CC) -c $(CFLAGS) -o $@ $<

.PHONY: default
