PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
PROGRAM = wt

.PHONY: all install uninstall clean

all:
	@echo "wt is a shell script, no build needed"

install:
	@echo "Installing $(PROGRAM) to $(BINDIR)"
	@mkdir -p $(BINDIR)
	@cp $(PROGRAM) $(BINDIR)/$(PROGRAM)
	@chmod 755 $(BINDIR)/$(PROGRAM)
	@echo "Installation complete"

uninstall:
	@echo "Removing $(PROGRAM) from $(BINDIR)"
	@rm -f $(BINDIR)/$(PROGRAM)
	@echo "Uninstallation complete"

clean:
	@echo "Nothing to clean"