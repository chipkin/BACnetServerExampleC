# The Compiler: gcc for C, g++ for C++
CC := gcc
CPP := g++
NAME := CASBACnetStackExampleC

# Compiler flags:
# -m32 for 32bit, -m64 for 64bit
# -Wall turns on most, but not all, compiler warnings
#
CPPFLAGS := -m64 -Wall -std=c++11

DEBUGFLAGS = -O0 -g3 -DCAS_BACNET_STACK_USE_SOURCE
RELEASEFLAGS = -O3 -DCAS_BACNET_STACK_USE_SOURCE
OBJECTFLAGS = -c -fmessage-length=0 -fPIC -MMD -MP
LDFLAGS = -static

SOURCES = $(wildcard /*.c) $(wildcard submodules/cas-bacnet-stack/adapters/cpp/*.cpp)  $(wildcard submodules/cas-bacnet-stack/submodules/cas-common/source/*.cpp) $(wildcard submodules/cas-bacnet-stack/source/*.cpp) 
OBJECTS = $(addprefix obj/,$(notdir $(SOURCES:.cpp=.o)))
INCLUDES =  -Isubmodules/cas-bacnet-stack/adapters/cpp -Isubmodules/cas-bacnet-stack/source -Isubmodules/cas-bacnet-stack/submodules/cas-common/source -Isubmodules/cas-bacnet-stack/submodules/xml2json/include

# Build Target
TARGET = $(NAME)

all: $(NAME)

$(NAME): obj/main.o $(OBJECTS)
	@echo 'Building target: $@'
	$(CPP) $(CPPFLAGS) $(LDFLAGS) -o $(NAME) obj/main.o $(OBJECTS)
	@echo 'Finished building target: $@'
	@echo ' '

# Build the "C" project file with the "C" GCC compiler.
obj/main.o: main.c
	@mkdir -p obj
	@echo 'Building file: $<'
	@echo 'Invoking: GCC __C__ Compiler'
	$(CC) $(RELEASEFLAGS) $(OBJECTFLAGS) $(INCLUDES) -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o $@ $<
	@echo 'Finished building: $<'
	@echo ' '

obj/%.o: submodules/cas-bacnet-stack/adapters/cpp/%.cpp
	@mkdir -p obj
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(CPP) $(RELEASEFLAGS) $(CPPFLAGS) $(OBJECTFLAGS) $(INCLUDES) -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o $@ $<
	@echo 'Finished building: $<'
	@echo ' '

obj/%.o: submodules/cas-bacnet-stack/source/%.cpp
	@mkdir -p obj
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(CPP) $(RELEASEFLAGS) $(CPPFLAGS) $(OBJECTFLAGS) $(INCLUDES) -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o $@ $<
	@echo 'Finished building: $<'
	@echo ' '

obj/%.o: submodules/cas-bacnet-stack/submodules/cas-common/source/%.cpp
	@mkdir -p obj
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	$(CPP) $(RELEASEFLAGS) $(CPPFLAGS) $(OBJECTFLAGS) $(INCLUDES) $(LIBPATH) -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o $@ $<
	@echo 'Finished building: $<'
	@echo ' '

install:
	install -D $(NAME) bin/$(NAME)
	$(RM) $(NAME)

# make clean
# Removes target file and any .o object files, 
# .d dependency files, or ~ backup files
clean:
	$(RM) $(NAME) obj/* *~
