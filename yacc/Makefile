### Which object are we building?
name ?= $(firstword $(MAKECMDGOALS))
in ?= $(shell ls | grep -i $(name). | grep -P "txt|xml")

### Other flags
GCC_FLAGS = -Wall -Wextra

### Check for user arguments
ifeq ($(name),)
name := familia
endif

ifeq ($(in),)
in := /dev/stdin
endif


## Targets

### Build Targets

$(name): $(name).tab.c $(name).yy.c 
	gcc $(GCC_FLAGS) -o $(name) $(name).tab.c $(name).yy.c

$(name).yy.c: $(name).l $(name).tab.h
	flex -o $(name).yy.c $(name).l

$(name).tab.c $(name).tab.h: $(name).y
	yacc -b $(name) -d $(name).y

run: $(name)
	./$(name) < $(in)

horario:
	yacc -b horario -d horario.y
	flex -o horario.yy.c horario.l
	gcc -g -Wall -Wextra -o horario horario.tab.c
	./horario < $(in) > horario.html

### Other targets

setup-watch:
	apt install -y inotify-tools
	touch setup-watch

watch: setup-watch
	@while inotifywait -e close_write $(name).l 2> /dev/null; do make $(name); done 2> /dev/null

.PHONY: run