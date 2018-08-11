.PHONY : def
def : targets
	$(MAKE) all


############
#VARIABLES :

ifndef ROOT
 ROOT := .
endif

include $(ROOT)/make_vars.mk


#######
#CORE :

include $(ROOT)/core.mk


########################
#TARGETS & DEPENDENCIES:

include $(SRC_DIR)/Makefile

#######
#LIBS :

include $(LIB_DIR)/Makefile

########
#TESTS :
	
include $(UTEST_DIR)/Makefile



##########
#RELEASE :

RELEASE_DIR = release_$(NAME)

.PHONY : release
release :
	if [ -d $(RELEASE_DIR) ];\
	then rm -rf $(RELEASE_DIR)/;\
	fi
	git clone \
		--single-branch \
		-b release \
		$(GIT_REPO) \
		$(RELEASE_DIR)
	cd $(RELEASE_DIR) && git rm -rf *
	cp auteur $(RELEASE_DIR)/
	cp -r $(SRC_DIR)/* $(RELEASE_DIR)/
#the following must override the existing Makefile
	cp core.mk $(RELEASE_DIR)/Makefile
	cp make_vars_release.mk $(RELEASE_DIR)/make_vars.mk
	cp $(patsubst %,$(LIBS_I)/%.h,$(DEPENDENCIES)) \
		$(RELEASE_DIR)/
	cd $(RELEASE_DIR) && \
		git add * && \
		git commit -m make_release && \
		git push origin release
	

################
#MISCELLANEOUS :

.PHONY : gcp
gcp :
	git commit -a -m i; git push;

.PHONY : grm
grm :
	git reset --hard && make CFLAGS_MORE=-g
