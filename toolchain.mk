# Copyright (c) 2013 The F9 Microkernel Project. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Toolchain configuration
CROSS_COMPILE ?= arm-none-eabi-
HOST_CROSS_COMPILE ?=

CC = $(CROSS_COMPILE)gcc
CPP = $(CROSS_COMPILE)cpp
LD = $(CROSS_COMPILE)ld
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

CFLAGS_WARN = -Wall
CFLAGS_DEBUG = -g3
CFLAGS_INCLUDE = $(foreach i,$(includes),-I$(i) )
CFLAGS_DEFINE = \
	-D __PLATFORM__=$(CHIP) \
	-D __BOARD__=$(BOARD) \
	-D'INC_PLAT(x)=<platform/__PLATFORM__/x>' \
	-DDEBUG
CPPFLAGS = \
	$(CFLAGS_DEFINE) $(CFLAGS_INCLUDE) $(EXTRA_CFLAGS)
CFLAGS = \
	-O0 -std=gnu99 -isystem \
	-nostdlib -ffreestanding \
	$(CPPFLAGS) $(CFLAGS_CPU) $(CFLAGS_DEBUG) $(CFLAGS_WARN) $(CFLAGS_y)

LIBGCC = $(shell $(CC) -print-libgcc-file-name)
