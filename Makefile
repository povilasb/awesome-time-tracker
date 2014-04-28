INSTALL_PATH ?= ~/.config/awesome

SRC_DIR = src
BUILD_DIR = build


all: build
.PHONY: all


build:
	make -C lib/qmonix-client
	mkdir -p $(BUILD_DIR)
	cp -r lib/qmonix-client/build/* $(BUILD_DIR)
	cp -r $(SRC_DIR)/* $(BUILD_DIR)
.PHONY: build


clean:
	rm -rf $(BUILD_DIR)
.PHONY: clean


install:
	cp -r $(BUILD_DIR)/* $(INSTALL_PATH)/
.PHONY: install
