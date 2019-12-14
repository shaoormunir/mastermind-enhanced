# Basic Makefile to pull in kernel's KBuild to build an out-of-tree
# kernel module

KDIR ?= /lib/modules/$(shell uname -r)/build
MODNAME = mastermind2

all: modules $(MODNAME)-test

$(MODNAME)-test: $(MODNAME)-test.c
	gcc --std=c99 -Wall -O2 -pthread -o $@ $^ -lm 

%.o: %.c
	gcc --std=c99 -Wall -O2 -c -o $@ $<

modules:
	$(MAKE) -C $(KDIR) M=$$PWD $@

clean:
	$(MAKE) -C $(KDIR) M=$$PWD $@
	-rm $(MODNAME)-test