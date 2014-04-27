.PHONY: all install uninstall

AWESOME_CONFIG_DIR = ~/.config/awesome
INSTALL_PATH = $(AWESOME_CONFIG_DIR)/TimeTracker

SRC_DIR = src
CLASS_TIME_TRACKER = $(SRC_DIR)/TimeTracker.lua

all: install

install:
	mkdir -p $(INSTALL_PATH)
	install --mode=644 $(CLASS_TIME_TRACKER) $(INSTALL_PATH)

uninstall:
	rm -rf $(INSTALL_PATH)
