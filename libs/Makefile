ifndef ROOT
	ROOT = ..
	include $(ROOT)/Makefile
endif


.PHONY : build-dependencies
build-dependencies : $(DEPENDENCIES)
	@echo "$(DEPENDENCIES)"

define BUILD_LIB
	$(MAKE) -C $(LIB_DIR)/$@/ 
	cp $@/$@.a $(LIBS_L)
	cp $@/includes/$@.h $(LIBS_I)
endef

libft :
	git clone \
		--single-branch \
		-b release https://github.com/SullenQuinoaPlant/Libft.git \
		--depth 1 \
		$(LIB_DIR)/$@/
	$(BUILD_LIB)


libmyfloatingpoint :
	git clone \
		--single-branch \
		-b release https://github.com/SullenQuinoaPlant/my_floatingpoint.git \
		--depth 1 \
		$(LIB_DIR)/$@/
	$(BUILD_LIB)


.PHONY : clean-lib*
clean-lib% :
	-rm $(LIB_DIR)/lib$*
	-rm $(LIBS_I)/lib$*.h
	-rm $(LIBS_L)/lib$*.a
