TARGET   = cpp-template-project
COMPILE = g++ -Wall -O2
COMPILE_INCS = `pkg-config --cflags gtkmm-3.0`
LINK = g++
LINK_LIBS = `pkg-config --libs gtkmm-3.0`

SRCDIR = src
OBJDIR = obj
BINDIR = bin

SOURCES  := $(wildcard $(SRCDIR)/*.cpp) $(wildcard $(SRCDIR)/**/*.cpp)
INCLUDES := $(wildcard $(SRCDIR)/*.h) $(wildcard $(SRCDIR)/**/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
rm        = rm -f


all: init $(BINDIR)/$(TARGET).exe
	@echo "Build $(BINDIR)/$(TARGET).exe successfully!"

init:
	@echo SOURCES:\ \ $(SOURCES)
	@echo INCLUDES:\ $(INCLUDES)
	@echo OBJECTS:\ \ $(OBJECTS)
	@cd src && find . -type d -exec mkdir -p -- ../obj/{} \;

exec: all
	$(BINDIR)/$(TARGET).exe

$(BINDIR)/$(TARGET).exe: $(OBJECTS)
	@$(LINK) $(OBJECTS) $(LINK_LIBS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@$(COMPILE) $(COMPILE_INCS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"