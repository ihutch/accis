SHELL=/bin/bash
AR=ar
#########################################################################
ifeq ("$(FORTRAN)","")
# Configure compiler. Mostly one long continued bash script.
# Preference order mpif90, ftn, gfortran, f77
 FORTRAN:=\
$(shell \
 if which mpif90 >/dev/null 2>&1; then echo -n "mpif90";else\
  if which ftn >/dev/null 2>&1 ; then echo -n "ftn";else\
    if which gfortran >/dev/null 2>&1; then echo -n "gfortran";else\
     if which f77 >/dev/null 2>&1 ; then echo -n "f77";else\
	echo "Unable to decide compiler. Specify via FORTRAN=..." >&2; exit 1;\
     fi;\
    fi;\
  fi;\
 fi;\
)
endif
export FORTRAN
#########################################################################
# Define the directories, variables, defaults that ACCIS uses
ifeq ("$(ACCISPARENT)","") 
  ACCISPARENT:= $(HOME)/src
endif
ACCISHOME:=$(realpath $(ACCISPARENT))/accis
ACCISX=$(ACCISHOME)/libaccisX.a
LIBPATH= -L$(ACCISHOME) -L.
LIBRARIES = -laccisX -lX11
LIBDEPS = $(ACCISHOME)/libaccisX.a
COMPILE-SWITCHES = -Wall -O2
# -g -fbounds-check
#########################################################################
# Always check that the accis library is available and make it,
# unless we are in the ACCISHOME directory doing things explicitly.
ACCISCHECK:=\
$(shell if [ "${CURDIR}" != "$(ACCISHOME)" ];\
 then	echo -n >&2 "Checking accis library ... ";\
 if [ -f "${ACCISX}" ] ; then echo>&2 "Library ${ACCISX} exists."; else\
   if [ -d "${ACCISPARENT}" ] ; then echo>&2 -n "parent directory exists. ";\
     else mkdir ${ACCISPARENT} ; fi;\
   if [ -d "${ACCISHOME}" ] ; then echo>&2 "accis directory exists. ";\
     else if cd ${ACCISPARENT}; then\
	git clone https://github.com/ihutch/accis.git; cd - >/dev/null; fi;fi;\
   if cd ${ACCISHOME}; then pwd >&2; make >&2; cd - >/dev/null; fi;\
   if [ -f "${ACCISX}" ] ; then echo>&2 "Made ${ACCISX}";\
     else echo>&2 "Error making ${ACCISX}"; fi;\
 fi;\
else echo >&2 "${CURDIR}" is the ACCISHOME: "$(ACCISHOME)". No tests. ; fi;\
)
#########################################################################
# To satisfy dependencies by building accis in the standard place, copy
# the file ACCIS.mk to your make directory; insert (before the first target)
#       include ACCIS.mk
# in the definitions of your makefile; and add the dependencies 
#       $(LIBDEPS), and  $(LIBPATH) $(LIBRARIES) to executables.
# These will cause the accis library to be cloned from github and compiled.
# If accis should be made in some non-standard $(ACCISHOME) location then
# the makefile can specify the parent directory by containing
#       ACCISPARENT:=$(realpath <ParentDirectory>)
#	export ACCISPARENT
# just before the   include ACCIS.mk   line. 
#########################################################################
