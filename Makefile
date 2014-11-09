TARGET=test
CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=main.cpp
BUILD_DIR=bin/native/
OBJ_DIR=obj/
EXECUTABLE=$(BUILD_DIR)$(TARGET)
OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)%.o,$(SOURCES))

#emscripten
EMCC=em++
EMCC_OBJECTS = $(patsubst %.cpp,$(OBJ_DIR)%.em.o,$(SOURCES))
EMCC_FLAGS= $(CFLAGS) -DEMSCRIPTEN -s SAFE_HEAP=1
EMLN_FLAGS= -DEMSCRIPTEN -s SAFE_HEAP=1
EMCC_BUILD_DIR=bin/emscripten/
EMSCRIPTEN_EXECUTABLE=$(EMCC_BUILD_DIR)$(TARGET).html

EMCC_FLAGS+= -I$(EMSCRIPTEN)/system/include/emscripten/

dummy: all

all: clean $(SOURCES) $(EXECUTABLE) $(EMSCRIPTEN_EXECUTABLE)

clean:
	rm -fr $(OBJ_DIR)
	rm -fr bin

$(EMSCRIPTEN_EXECUTABLE): $(EMCC_OBJECTS)
	mkdir -p $(EMCC_BUILD_DIR)
	$(EMCC) $(EMCC_OBJECTS) $(EMLN_FLAGS) -o $@

$(EXECUTABLE): $(OBJECTS) 
	mkdir -p $(BUILD_DIR)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

$(OBJ_DIR)%.em.o: %.cpp $(OBJ_DIR)
	$(EMCC) $(EMCC_FLAGS) $(INCLUDES) $< -o $@

$(OBJ_DIR):
	mkdir -p $@

$(OBJ_DIR)%.o: %.cpp
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) $< -o $@


