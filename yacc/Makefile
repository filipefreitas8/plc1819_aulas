### Which object are we building?
name ?= $(firstword $(MAKECMDGOALS))
in ?= $(shell ls | grep -i $(name). | grep -P "txt|xml")

ifeq ($(name),)
name := familia
endif

## Targets

### Build Targets

#### Executable targets
$(name):
	yacc -b $(name) -d $(name).y
	flex -o $(name).yy.c $(name).l
	gcc -g -Wall -Wextra -o $(name) $(name).tab.c
	./$(name) < $(in)

horario:
	yacc -b horario -d horario.y
	flex -o horario.yy.c horario.l
	gcc -g -Wall -Wextra -o horario horario.tab.c
	./horario < $(in) > horario.html

expbool:
	yacc -b expbool -d expbool.y
	flex -o expbool.yy.c expbool.l
	gcc -g -Wall -Wextra -o expbool expbool.tab.c
	./expbool

### Other targets

setup-watch:
	apt install -y inotify-tools
	touch setup-watch

watch: setup-watch
	@while inotifywait -e close_write $(name).l 2> /dev/null; do make $(name); done 2> /dev/null
