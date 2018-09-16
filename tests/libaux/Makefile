ifndef ROOT
 ROOT := ..
 include $(ROOT)/Makefile
endif

TEST_SRCS := $(wildcard $(TEST_DIR)/*.test.c)
TEST_OBJS := $(TEST_SRCS:.c=.o)
EXECUTION_STAMPS := $(TEST_OBJS:.o=.execution.stamp)

CFLAGS_TEST = -fno-builtin -g
CFLAGS_TEST += $(CFLAGS_MORE) #$(CFLAGS) were annoying the hell out of me

TEST_DEPENDENCIES = libcmocka


.PHONY : tests_all
tests_all :\
build_test_dependencies\
clean_tests\
build_tests\
run_tests

############
#BUILD TESTS

.PHONY : build_test_dependencies
build_test_dependencies : $(TEST_DEPENDENCIES)

.PHONY : libcmocka
libcmocka : $(LIB_DIR)/libcmocka
	$(MAKE) -C $(TEST_DIR)/cmocka

.PHONY : build_tests
build_tests\
:\
set_test_flags\
def\
$(TEST_OBJS)

.PHONY : set_test_flags
set_test_flags :
	$(eval CFLAGS += $(CFLAGS_TEST))


$(TEST_DIR)/%.test.o\
:\
$(TEST_DIR)/%.test.c\
$(LIBS_L)/$(LIBNAME).a
	$(CC) $(CFLAGS_TEST)\
		-I $(LIBS_I) -I $(SRC_DIR)\
		$<\
		-L $(LIBS_L)\
		-lcmocka_shared\
		-l$(NAME) -lmyfloatingpoint -lft\
		-o $@\
		-Wl,-rpath=$$(readlink -e $(LIBS_L))\


############
#RUN TESTS :

.PHONY : tests
tests : list_tests run_tests

.PHONY : run_tests
run_tests : $(EXECUTION_STAMPS)

%.execution.stamp : %.o
	-./$*.o "$(TEST_DIR)" \
	&& touch $@


###############
#MISCELLANEOUS:

.PHONY : clean_tests
clean_tests :
	-rm $(TEST_DIR)/*.o
	-rm $(TEST_DIR)/*.stamp

.PHONY : list-tests
list_tests :
	@echo "source dir is : $(SRC_DIR)"
	@echo "list of test sources:"
	@echo $(TEST_SRCS)
	@echo "list of test objects:"
	@echo $(TEST_OBJS)
