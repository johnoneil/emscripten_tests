TARGET=test
CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=main.cpp
OBJECTS=$(SOURCES:.cpp=.o)
BUILD_DIR=bin/native/
OBJ_DIR=obj/
EXECUTABLE=$(BUILD_DIR)$(TARGET)

#emscripten
EMCC=em++
EMCC_OBJECTS=$(SOURCES:.cpp=.em.o)
EMCC_FLAGS= -s SAFE_HEAP=1
EMCC_BUILD_DIR=bin/emscripten/
EMSCRIPTEN_EXECUTABLE=$(EMCC_BUILD_DIR)$(TARGET).html


all: $(SOURCES) $(EXECUTABLE) $(EMSCRIPTEN_EXECUTABLE)

$(EMSCRIPTEN_EXECUTABLE): $(EMCC_OBJECTS)
	mkdir -p $(EMCC_BUILD_DIR)
	$(EMCC) $(EMCC_OBJECTS) $(EMCC_FLAGS) -o $@

$(EXECUTABLE): $(OBJECTS) 
	mkdir -p $(BUILD_DIR)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

%.em.o: %.cpp
	$(EMCC) $(CFLAGS) $< -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) $< -o $@


