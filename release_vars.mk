NAME =
LIBNAME = lib$(NAME)

CALL_DIR := $(shell pwd)
SRC_DIR := $(ROOT)/sources
INC_DIR := $(ROOT)/includes
OBJ_DIR := $(ROOT)
LIB_DIR := $(ROOT)/libs
LIBS_L := $(LIB_DIR)
LIBS_I := $(LIB_DIR)
OUT_DIR_LIB := $(LIBS_L)
OUT_DIR_H := $(LIBS_I)

OBJS := $(patsubst %,$(OBJ_DIR)/%.o,$(TARGETS))

CC := gcc
CFLAGS_MORE =
ifndef CFLAGS
	CFLAGS := -Wall -Wextra -Werror -I $(INC_DIR)
endif
CFLAGS += $(CFLAGS_MORE)
