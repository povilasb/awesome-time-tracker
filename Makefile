AWESOME_CONFIG_DIR = ~/.config/awesome
INSTALL_PATH = $(AWESOME_CONFIG_DIR)

SRC_DIR = src
CLASS_TIME_TRACKER = $(SRC_DIR)/time_tracker.lua


all: install
.PHONY: all


install:
	install --mode=644 $(CLASS_TIME_TRACKER) $(INSTALL_PATH)
.PHONY: install


uninstall:
	rm -rf $(INSTALL_PATH)
.PHONY: uninstall
