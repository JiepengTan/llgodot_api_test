CC = gcc
CFLAGS = -fPIC -Isrc/godot -c
SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%,build/%,$(SOURCES:.c=.o))
ifeq ($(OS),Windows_NT)
	LIBRARY = bin/libmylib.dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		LIBRARY = bin/libmylib.so
	endif
	ifeq ($(UNAME_S),Darwin)
		LIBRARY = bin/libmylib.dylib
	endif
endif
all: bin build $(SOURCES) $(LIBRARY)
bin:
	mkdir -p bin
build:
	mkdir -p build
$(LIBRARY): $(OBJECTS)
	$(CC) -shared -o $@ $(OBJECTS)
build/%.o: src/%.c
	$(CC) $(CFLAGS) $< -o $@
clean:
ifeq ($(OS),Windows_NT)
	del /Q /F $(subst /,\,$(OBJECTS)) $(subst /,\,$(LIBRARY))
else
	rm -f $(OBJECTS) $(LIBRARY)
endif
