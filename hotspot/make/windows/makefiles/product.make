#
# Copyright (c) 2005, 2008, Oracle and/or its affiliates. All rights reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
# or visit www.oracle.com if you need additional information or have any
# questions.
#  
#

HS_INTERNAL_NAME=jvm
HS_FNAME=$(HS_INTERNAL_NAME).dll
AOUT=$(HS_FNAME)
GENERATED=../generated

default:: _build_pch_file.obj $(AOUT) checkAndBuildSA

!include ../local.make
!include compile.make

CPP_FLAGS=$(CPP_FLAGS) $(PRODUCT_OPT_OPTION)

RELEASE=

RC_FLAGS=$(RC_FLAGS) /D "NDEBUG"

!include $(WorkSpace)/make/windows/makefiles/vm.make
!include local.make

!include $(GENERATED)/Dependencies

HS_BUILD_ID=$(HS_BUILD_VER)

# Force resources to be rebuilt every time
$(Res_Files): FORCE

# Kernel doesn't need exported vtbl symbols.
!if "$(Variant)" == "kernel"
$(AOUT): $(Res_Files) $(Obj_Files)
	$(LINK) @<<
  $(LINK_FLAGS) /out:$@ /implib:$*.lib $(Obj_Files) $(Res_Files)
<<
!else
$(AOUT): $(Res_Files) $(Obj_Files)
	sh $(WorkSpace)/make/windows/build_vm_def.sh
	$(LINK) @<<
  $(LINK_FLAGS) /out:$@ /implib:$*.lib /def:vm.def $(Obj_Files) $(Res_Files)
<<
!endif
!if "$(MT)" != ""
# The previous link command created a .manifest file that we want to
# insert into the linked artifact so we do not need to track it
# separately.  Use ";#2" for .dll and ";#1" for .exe:
	$(MT) /manifest $@.manifest /outputresource:$@;#2
!endif

!include $(WorkSpace)/make/windows/makefiles/shared.make
!include $(WorkSpace)/make/windows/makefiles/sa.make
