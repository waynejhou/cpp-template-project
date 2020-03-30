# Modify from here
# https://stackoverflow.com/questions/7004702/how-can-i-create-a-makefile-for-c-projects-with-src-obj-and-bin-subdirectories

# project name aka output exe file name
TARGET   = cpp-template-project

# command for compile
COMPILE = g++ -Wall -O2
# compile include reference
COMPILE_INCS = `pkg-config --cflags gtkmm-3.0`
# command for link
LINK = g++
# command for link liberaries
LINK_LIBS = `pkg-config --libs gtkmm-3.0`

# dir name for three src/obj/bin
SRCDIR = src
OBJDIR = obj
BINDIR = bin

# scan file from src
SOURCES  := $(wildcard $(SRCDIR)/*.cpp) $(wildcard $(SRCDIR)/**/*.cpp)
INCLUDES := $(wildcard $(SRCDIR)/*.h) $(wildcard $(SRCDIR)/**/*.h)

# get needed object file names
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)

# command for remove file 
rm        = rm -f

# do all things for build this project
all: init $(BINDIR)/$(TARGET).exe
	@echo "Build $(BINDIR)/$(TARGET).exe successfully!"

# init before start building
init:
# echo related file names
	@echo SOURCES:\ \ $(SOURCES)
	@echo INCLUDES:\ $(INCLUDES)
	@echo OBJECTS:\ \ $(OBJECTS)
# make sure bin dir exist
	@mkdir -p bin
# make sure obj dir has same struct with src dir
	@cd $(SRCDIR) && find . -type d -exec mkdir -p -- ../$(OBJDIR)/{} \;

# do build this project and exec target
exec: all
	$(BINDIR)/$(TARGET).exe

# link files
$(BINDIR)/$(TARGET).exe: $(OBJECTS)
	@$(LINK) $(OBJECTS) $(LINK_LIBS) -o $@
	@echo "Linking complete!"

# compile files
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@$(COMPILE) $(COMPILE_INCS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

# clean
.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

# remove
.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"