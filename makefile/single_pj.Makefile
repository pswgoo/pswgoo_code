# Excute binary file or Library file Path, the follow dirs can be empty
BIN_DIR := ../bin_linux/
#OBJ_DIR := ./obj/
# Project Name or Library Name 
PRO_EXE = 
PRO_LIB = $(BIN_DIR)common.a

# Libraries references
LIB_REFERENCES = 

# Include files
INCS = -I ../

# Compiler
CC = g++
# Compiler options during compilation
CC_FLAGS = -O2 -Wall -std=c++0x -m64

#Static library use 'ar' command 
AR = ar
RANLIB = ranlib

# AR options
AR_FLAGS = -rv

# Libraries for linking
LIBS = -lstdc++ -lm

# Subdirs to search for additional source files
SUBDIRS := $(shell ls -F | grep "\/" )
DIRS := ./ $(SUBDIRS) 
SOURCE_FILES := $(foreach d, $(DIRS), $(wildcard $(d)*.cpp) )

# Create an object file of every cpp file
OBJECTS = $(patsubst %.cpp, %.o, $(SOURCE_FILES))

DEPEND_FILES = $(OBJECTS:.o=.d)
	
.PHONY: all
# Make $(PRO_EXE) $(PRO_LIB) the default target
all: $(PRO_EXE) $(PRO_LIB)

$(PRO_EXE): $(OBJECTS)
	$(CC) -o $(PRO_EXE) $(OBJECTS) $(LIB_REFERENCES) $(LIBS)

$(PRO_LIB): $(OBJECTS)
	$(AR) $(AR_FLAGS) $(PRO_LIB) $(OBJECTS)
	$(RANLIB) $(PRO_LIB)
	
# Compile every cpp file to an object
%.o: %.cpp
	$(CC) -c $(CC_FLAGS) $(INCS) -o $@ $<
	
# Generate header dependence file: *.d for each *.cpp
%.d: %.cpp
	@set -e; rm -f $@; \
	$(CC) -MM $< $(INCS) > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$

# Include header dependence file: *.d for each *.cpp
-include $(DEPEND_FILES)

# Clean
clean:
	rm -f $(PROJECT) $(PRO_LIB) $(OBJECTS) $(DEPEND_FILES)

.PHONY: clean