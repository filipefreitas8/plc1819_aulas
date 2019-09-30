### Which object are we building?
name ?= $(firstword $(MAKECMDGOALS))
in ?= $(shell ls | grep -i $(name). | grep -P "txt|xml")

ifeq ($(name),)
name := abrev
endif

## Targets

### Build Targets

#### Executable targets
$(name):
	flex --o $(name).yy.c $(name).l
	gcc -Wall -Wextra -o $(name) $(name).yy.c
	./$(name) < $(in)

### Other targets

setup-watch:
	apt install -y inotify-tools
	touch setup-watch

watch: setup-watch
	@while inotifywait -e close_write $(name).l 2> /dev/null; do make $(name); done 2> /dev/null

.PHONY: $(name)
