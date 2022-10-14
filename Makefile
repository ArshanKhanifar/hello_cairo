SRC_DIR := src
BUILD_DIR := build

run: compile
	cairo-run \
	  --program=$(BUILD_DIR)/$(FILE)_compiled.json \
		--print_output \
	  --layout=small

compile:
	cairo-compile $(SRC_DIR)/$(FILE).cairo --output $(BUILD_DIR)/$(FILE)_compiled.json

run-puzzle: compile
	cairo-run \
	  --program=$(BUILD_DIR)/$(FILE)_compiled.json \
		--print_output \
	  --layout=small \
		--program_input=$(SRC_DIR)/$(FILE)_input.json
