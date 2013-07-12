.PHONY: all install uninstall

AWESOME_CONFIG_DIR = ~/.config/awesome
INSTALL_PATH = $(AWESOME_CONFIG_DIR)/TimeTracker

CLASS_TIME_TRACKER = TimeTracker.lua
CLASS_ACTIVITY = Activity.lua

all: install

install:
	mkdir -p $(INSTALL_PATH)
	install --mode=644 $(CLASS_TIME_TRACKER) $(INSTALL_PATH)
	install --mode=644 $(CLASS_ACTIVITY) $(INSTALL_PATH)

uninstall:
	rm -rf $(INSTALL_PATH)

