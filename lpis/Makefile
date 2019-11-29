### Which object are we building?
name = lpis
in ?= /dev/stdin
out ?= /dev/stdout


### Other flags
GCC_FLAGS = -Wall -Wextra

ifneq ($(in), /dev/stdin)
out = $(shell echo $(in) | cut -f 1 -d '.').vm
endif

## Targets

### Build Targets

$(name): $(name).tab.c $(name).yy.c
	gcc $(GCC_FLAGS) -o $(name) $(name).tab.c $(name).yy.c

$(name).yy.c: $(name).l $(name).tab.h
	flex -o $(name).yy.c $(name).l

$(name).tab.c $(name).tab.h: $(name).y
	yacc -b $(name) -d $(name).y

%.vm: %.lpis $(name)
	./$(name) < $< > $@

run: $(name)
	./$(name) < $(in)

vm: $(name) $(out)
	cd vms && ./vms -g ../$(out) || true

setup-watch:
	apt install -y inotify-tools
	touch setup-watch

watch: setup-watch
	@while inotifywait -e close_write $(name).y 2> /dev/null; do make $(name); done 2> /dev/null

.PHONY: run vm
