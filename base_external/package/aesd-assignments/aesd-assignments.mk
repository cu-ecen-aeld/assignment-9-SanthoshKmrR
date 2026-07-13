##############################################################
#
# AESD-ASSIGNMENTS
#
# Builds and installs the AESD socket server (aesdsocket) and the
# aesdchar character driver from the assignment-8 repository, and
# relies on the rootfs overlay init scripts (S98aesdchar / S99aesdsocket)
# to load the driver and start the application automatically at boot.
#
##############################################################

# Reference the *ssh* repository URL so the automated build/test system can
# use ssh keys. Update AESD_ASSIGNMENTS_VERSION to the commit you want built
# (must be pushed to the remote below).
AESD_ASSIGNMENTS_VERSION = ff7a4f4e7913d7461300060108ee9b9fefe9894f
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-SanthoshKmrR.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Build the aesdchar character driver as an out-of-tree kernel module.
# The kernel-module infrastructure cross-compiles the module against the
# configured kernel, installs it under /lib/modules/<kver>/ and runs depmod
# so that "modprobe aesdchar" works at runtime.
AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver

# Build the userspace socket server application.
# Run "clean" first: a stale (x86-64) aesdsocket binary committed to the source
# tree would otherwise share the checkout mtime of aesdsocket.c and make would
# skip the recompile, installing a host-arch binary instead of the target one.
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

# Install the aesdsocket application into /usr/bin. The aesdchar kernel
# module is installed automatically by the kernel-module infrastructure.
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
endef

$(eval $(kernel-module))
$(eval $(generic-package))
