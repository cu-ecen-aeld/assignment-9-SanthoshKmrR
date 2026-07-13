
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = 33213e6b29c7fd6dec48f3d040840e5826a93543
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-SanthoshKmrR.git
LDD_SITE_METHOD = git
#LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = misc-modules scull

# define LDD_MODULE_INSTALL_TARGET_CMDS
# 	$(INSTALL) -d 0755
# 	$(INSTALL) -d 0755
# endef

$(eval $(kernel-module))
$(eval $(generic-package))
