CC=g++
CFLAGS=-c -Wall
LDFLAGS=
SOURCES=main.cpp
OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=test

#emscripten
EMCC=em++
EMSCRIPTEN=$(EXECUTABLE).html
EMCC_OBJECTS=$(SOURCES:.cpp=.em.o)
EMCC_FLAGS= -s SAFE_HEAP=1

all: $(SOURCES) $(EXECUTABLE) $(EMSCRIPTEN)

$(EMSCRIPTEN): $(EMCC_OBJECTS)
	$(EMCC) $(EMCC_OBJECTS) $(EMCC_FLAGS) -o $@

$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

%.em.o: %.cpp
	$(EMCC) $(CFLAGS) $< -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) $< -o $@


