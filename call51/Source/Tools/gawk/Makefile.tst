# Makefile for GNU Awk test suite.
#
# Copyright (C) 1988-2001 the Free Software Foundation, Inc.
# 
# This file is part of GAWK, the GNU implementation of the
# AWK Programming Language.
# 
# GAWK is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# GAWK is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA

# ============================================================================
# MS-DOS & OS/2 Notes: READ THEM!
# ============================================================================

# As of version 2.91, efforts to make this makefile run in MS-DOS and OS/2
# have started in earnest.  The following steps need to be followed in order 
# to run this makefile:
#
# 1. The first thing that you will need to do is to convert all of the 
#    files ending in ".ok" in the test directory, all of the files ending 
#    in ".good" (or ".goo") in the test/reg directory, and mmap8k.in from
#    having a linefeed to having carriage return/linefeed at the end of each
#    line. There are various public domain UNIX to DOS converters and any 
#    should work.  Alternatively, you can use diff instead of cmp--most 
#    versions of diff don't care about how the lines end.
#
# 2. You will need an sh-compatible shell.  Please refer to the "README.pc"
#    file in the README_d directory for information about obtaining a copy.
#    You will also need various UNIX utilities.  At a minimum, you will 
#    need: rm, tr, cmp (or diff, see above), cat, wc, and sh.  
#    You should also have a UNIX-compatible date program.
#
# The makefile has only been tested with dmake 3.8 and DJGPP Make 3.74 or
# later.  After making all of these changes, typing "dmake bigtest extra"
# or "make bigtest extra" (with DJGPP Make) should run successfully.

# The Bash shell (compiled with djgpp) works very well with the
# MSC & djgpp-compiled gawks.  It is currently the recommended shell to use
# for testing, along with DJGPP make.  See README.pc for 
# more information on OS/2 and DOS shells.

# You will almost certainly need to change some of the values (MACROS) 
# defined on the next few lines.  

# This won't work unless you have "sh" and set SHELL equal to it (Make 3.74
# or later which comes with DJGPP will work with SHELL=/bin/sh if you have
# sh.exe anywhere on your PATH).
#SHELL = e:\bin\sh.exe
SHELL = /bin/sh

# Point to gawk
AWK = ../gawk.exe
# Also point to gawk but for DOS commands needing backslashes.  We need
# the forward slash version too or 'arrayparam' fails.
AWK2 = '..\gawk.exe'

# Set your cmp command here (you can use most versions of diff instead of cmp
# if you don't want to convert the .ok files to the DOS CR/LF format).
#
# The following comment is for users of OSs which support long file names
# (such as Windows 95) for all versions of gawk (both 16 & 32-bit).
# If you use a shell which doesn't support long filenames, temporary files
# created by this makefile will be truncated by your shell.  "_argarra" is an
# example of this.  If $(CMP) is a DJGPP-compiled program, then it will fail
# because it looks for the long filename (eg. _argarray).  To fix this, you
# need to set LFN=n in your shell's environment.
# NOTE: Setting LFN in the makefile most probably won't help you because LFN
# needs to be an environment variable.
#CMP = cmp
# See the comment above for why you might want to set CMP to "env LFN=n diff"
CMP = env LFN=n diff
#CMP = diff
#CMP = diff -c
#CMP = gcmp

# Set your "cp" and "mkdir" commands here.  Note: DOS's copy must take forward
# slashes.
#CP = cp
#CP = : && command -c copy
CP  = command.com /c copy

#MKDIR = mkdir
#MKDIR = gmkdir
#MKDIR = : && command -c mkdir
MKDIR  = command.com /c mkdir

# Set your unix-style date function here
#DATE = date
DATE = gdate

# ============================================================================
# You shouldn't need to modify anything below this line.
# ============================================================================

srcdir = .

bigtest:	basic unix-tests gawk-extensions

# message stuff is to make it a little easier to follow
check:	msg \
	basic-msg-start  basic           basic-msg-end \
	unix-msg-start   unix-tests      unix-msg-end \
	extend-msg-start gawk-extensions extend-msg-end

# try to keep these sorted
basic: addcomma anchgsub argarray arrayparm arrayref arynasty arynocls \
	arysubnm asgext awkpath back89 backgsub childin clobber clsflnam \
	compare convfmt datanonl defref delarprm dynlj eofsplit fldchg \
	fldchgnf fnamedat fnarray fnarydel fnaryscl fnasgnm fnparydl \
	fsbs fsrs fstabplus funsmnam funstack getline getlnbuf getnr2tb \
	getnr2tm gsubasgn gsubtest hsprint intest intprec leaddig litoct \
	longwrds math messages mmap8k nasty nasty2 negexp nfldstr nfset \
	nlfldsep nlinstr nlstrina noeffect nofmtch nonl noparms nors \
	numindex numsubstr octsub ofmt ofmtbig ofmts opasnidx opasnslf \
	paramdup paramtyp parseme pcntplus prdupval printf1 prmarscl \
	prmreuse prt1eval prtoeval psx96sub rand rebt8b1 rebt8b2 redfilnm \
	regeq reindops reparse resplit rs rsnul1nl rswhite sclforin \
	sclifin splitargv splitdef splitvar splitwht sprintfc strtod \
	subslash substr swaplns tradanch tweakfld zeroflag

unix-tests: fflush getlnhd pid pipeio1 pipeio2 poundba   strftlng

gawk-extensions: argtest badargs clos1way fieldwdth fsfwfs gensub \
	gnuops2 gnureops igncdym igncfs ignrcase lint manyfiles nondec \
	posix procinfs regx8bit reint shadow sort1 strftime

extra:	regtes  inftest inet

inet:   inetmesg inetechu inetecht inetdayu inetdayt

msg::
	@echo 'Any output from "cmp" is bad news, although some differences'
	@echo 'in floating point values are probably benign -- in particular,'
	@echo 'some systems may omit a leading zero and the floating point'
	@echo 'precision may lead to slightly different output in a few cases.'

basic-msg-start:
	@echo "======== Starting basic tests ========"

basic-msg-end:
	@echo "======== Done with basic tests ========"

unix-msg-start:
	@echo "======== Starting Unix tests ========"

unix-msg-end:
	@echo "======== Done with Unix tests ========"

extend-msg-start:
	@echo "======== Starting gawk extension tests ========"

extend-msg-end:
	@echo "======== Done with gawk extension tests ========"

# This test is a PITA because increasingly, /tmp is getting
# mounted noexec.  So, we'll test it.  Sigh.
poundba::
#	@cp $(AWK) /tmp/gawk
	@$(CP) $(AWK2) '\tmp\gawk.exe'
#	@if /tmp/gawk 'BEGIN { print "OK" }' | grep OK > /dev/null ; \
#	then \
#		$(srcdir)/poundbang.awk $(srcdir)/poundbang.awk >_`basename $@` ; \
#		$(CMP) $(srcdir)/poundbang.ok _`basename $@` && rm -f _`basename $@` && echo poundbang is ok ; \
#	else \
#		echo "*** /tmp is apparently mounted noexec, skipping poundbang test." ; \
#	fi
	@if /tmp/gawk 'BEGIN { print "OK" }' | grep OK > NUL ; \
	then \
		$(srcdir)/poundbang.awk $(srcdir)/poundbang.awk >_`basename $@` ; \
		$(CMP) $(srcdir)/poundbang.ok _`basename $@` && rm -f _`basename $@` && echo poundbang is ok ; \
	else \
		echo "*** /tmp is apparently mounted noexec, skipping poundbang test." ; \
	fi
#	@rm -f /tmp/gawk
	@rm -f /tmp/gawk.exe

swaplns::
	@echo 'If swaplns fails make sure that all of the .ok files have CR/LFs.'
	@echo 'Or, set CMP to use diff.'
	@$(AWK) -f $(srcdir)/swaplns.awk $(srcdir)/swaplns.in >_$@
	-$(CMP) $(srcdir)/swaplns.ok _$@ && rm -f _$@

messages::
	@$(AWK) -f $(srcdir)/messages.awk >out2 2>out3
	-$(CMP) $(srcdir)/out1.ok out1 && $(CMP) $(srcdir)/out2.ok out2 && $(CMP) $(srcdir)/out3.ok out3 && rm -f out1 out2 out3

argarray::
	@case $(srcdir) in \
	.)	: ;; \
	*)	cp $(srcdir)/argarray.in . ;; \
	esac
	@TEST=test echo just a test | $(AWK) -f $(srcdir)/argarray.awk ./argarray.in - >_$@
	-$(CMP) $(srcdir)/argarray.ok _$@ && rm -f _$@

fstabplus::
	@echo '1		2' | $(AWK) -f $(srcdir)/fstabplus.awk >_$@
	-$(CMP) $(srcdir)/fstabplus.ok _$@ && rm -f _$@

fsrs::
	@$(AWK) -f $(srcdir)/fsrs.awk $(srcdir)/fsrs.in >_$@
	-$(CMP) $(srcdir)/fsrs.ok _$@ && rm -f _$@

igncfs::
	@$(AWK) -f $(srcdir)/igncfs.awk $(srcdir)/igncfs.in >_$@
	-$(CMP) $(srcdir)/igncfs.ok _$@ && rm -f _$@

longwrds::
	@$(AWK) -f $(srcdir)/longwrds.awk $(srcdir)/manpage | (LC_ALL=C sort) >_$@
	-$(CMP) $(srcdir)/longwrds.ok _$@ && rm -f _$@

fieldwdth::
	@echo '123456789' | $(AWK) -v FIELDWIDTHS="2 3 4" '{ print $$2}' >_$@
	-$(CMP) $(srcdir)/fieldwdth.ok _$@ && rm -f _$@

ignrcase::
	@echo xYz | $(AWK) -v IGNORECASE=1 '{ sub(/y/, ""); print}' >_$@
	-$(CMP) $(srcdir)/ignrcase.ok _$@ && rm -f _$@

regtes::
	@echo 'Some of the output from regtest is very system specific, do not'
	@echo 'be distressed if your output differs from that distributed.'
	@echo 'Manual inspection is called for.'
#	AWK=`pwd`/$(AWK) $(srcdir)/regtest.awk
	AWK=`pwd`/$(AWK) CMP="$(CMP)" $(srcdir)/regtest

posix::
	@echo 'posix test may fail due to 1.500000e+000 not being equal to'
	@echo '1.500000e+00 for MSC gawk.'
	@echo '1:2,3 4' | $(AWK) -f $(srcdir)/posix.awk >_$@
	-$(CMP) $(srcdir)/posix.ok _$@ && rm -f _$@

manyfiles::
	@rm -rf junk
#	@mkdir junk
	@$(MKDIR) junk
	@$(AWK) 'BEGIN { for (i = 1; i <= 300; i++) print i, i}' >_$@
	@$(AWK) -f $(srcdir)/manyfiles.awk _$@ _$@
	@echo 'If manyfiles says "junk/*: No such file or directory",'
	@echo 'use the line on test/Makefile which invokes wc'
	@echo 'without quoting the "junk/*" argument.'
#	@echo "This number better be 1 ->" | tr -d '\012'
	@echo "This number better be 1 ->" | tr -d '\012\015'
	@wc -l junk/* | $(AWK) '$$1 != 2' | wc -l
#	@wc -l "junk/*" | $(AWK) '$$1 != 2' | wc -l
# The quotes above are for people with a "wc" that doesn't too long a command
# line.
	@rm -rf junk _$@

compare::
	@$(AWK) -f $(srcdir)/compare.awk 0 1 $(srcdir)/compare.in >_$@
	-$(CMP) $(srcdir)/compare.ok _$@ && rm -f _$@

arrayref::
	@$(AWK) -f $(srcdir)/arrayref.awk >_$@
	-$(CMP) $(srcdir)/arrayref.ok _$@ && rm -f _$@

rs::
	@$(AWK) -v RS="" '{ print $$1, $$2}' $(srcdir)/rs.in >_$@
	-$(CMP) $(srcdir)/rs.ok _$@ && rm -f _$@

fsbs::
	@$(AWK) -v FS='\' '{ print $$1, $$2 }' $(srcdir)/fsbs.in >_$@
	-$(CMP) $(srcdir)/fsbs.ok _$@ && rm -f _$@

inftest::
	@echo This test is very machine specific...
	@echo 'Both MSC 7.0 and 8.0 gawk generate a floating point exception.'
	@echo 'EMX gawk uses #INF rather than Inf.'
#	@$(AWK) -f $(srcdir)/inftest.awk >_$@
	@-$(AWK) -f $(srcdir)/inftest.awk >_$@
	-$(CMP) $(srcdir)/inftest.ok _$@ && rm -f _$@

getline::
	@$(AWK) -f $(srcdir)/getline.awk $(srcdir)/getline.awk $(srcdir)/getline.awk >_$@
	-$(CMP) $(srcdir)/getline.ok _$@ && rm -f _$@

rand::
	@$(AWK) -f $(srcdir)/rand.awk >_$@
	-$(CMP) $(srcdir)/rand.ok _$@ && rm -f _$@

negexp::
	@$(AWK) 'BEGIN { a = -2; print 10^a }' >_$@
	-$(CMP) $(srcdir)/negexp.ok _$@ && rm -f _$@

asgext::
	@$(AWK) -f $(srcdir)/asgext.awk $(srcdir)/asgext.in >_$@
	-$(CMP) $(srcdir)/asgext.ok _$@ && rm -f _$@

anchgsub::
	@$(AWK) -f $(srcdir)/anchgsub.awk $(srcdir)/anchgsub.in >_$@
	-$(CMP) $(srcdir)/anchgsub.ok _$@ && rm -f _$@

splitargv::
	@$(AWK) -f $(srcdir)/splitargv.awk $(srcdir)/splitargv.in >_$@
	-$(CMP) $(srcdir)/splitargv.ok _$@ && rm -f _$@

awkpath::
# MS-DOS and OS/2 use ; as a PATH delimiter
#	@AWKPATH="$(srcdir):$(srcdir)/lib" $(AWK) -f awkpath.awk >_$@
	@AWKPATH="$(srcdir);$(srcdir)/lib" $(AWK) -f awkpath.awk >_$@
	-$(CMP) $(srcdir)/awkpath.ok _$@ && rm -f _$@

nfset::
	@$(AWK) -f $(srcdir)/nfset.awk $(srcdir)/nfset.in >_$@
	-$(CMP) $(srcdir)/nfset.ok _$@ && rm -f _$@

reparse::
	@$(AWK) -f $(srcdir)/reparse.awk $(srcdir)/reparse.in >_$@
	-$(CMP) $(srcdir)/reparse.ok _$@ && rm -f _$@

argtest::
	@$(AWK) -f $(srcdir)/argtest.awk -x -y abc >_$@
	-$(CMP) $(srcdir)/argtest.ok _$@ && rm -f _$@

badargs::
# For MS-DOS & OS/2, we use " rather than ' in the usage statement.
	@-$(AWK) -f 2>&1 | grep -v patchlevel >_$@
# Next line converts " to ' for $(CMP) to work with UNIX badargs.ok
	@cat _$@ | tr '\042' '\047' > _$@.2
#	-$(CMP) $(srcdir)/badargs.ok _$@ && rm -f _$@
	-$(CMP) $(srcdir)/badargs.ok _$@.2 && rm -f _$@ _$@.2

convfmt::
	@$(AWK) -f $(srcdir)/convfmt.awk >_$@
	-$(CMP) $(srcdir)/convfmt.ok _$@ && rm -f _$@

arrayparm::
	@-AWKPATH=$(srcdir) $(AWK) -f arrayparm.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/arrayparm.ok _$@ && rm -f _$@

paramdup::
	@-AWKPATH=$(srcdir) $(AWK) -f paramdup.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/paramdup.ok _$@ && rm -f _$@

nonl::
#	@-AWKPATH=$(srcdir) $(AWK) --lint -f nonl.awk /dev/null >_$@ 2>&1
	@-AWKPATH=$(srcdir) $(AWK) --lint -f nonl.awk NUL >_$@ 2>&1
	-$(CMP) $(srcdir)/nonl.ok _$@ && rm -f _$@

defref::
	@-AWKPATH=$(srcdir) $(AWK) --lint -f defref.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/defref.ok _$@ && rm -f _$@

nofmtch::
	@-AWKPATH=$(srcdir) $(AWK) --lint -f nofmtch.awk >_$@ 2>&1
	-$(CMP) $(srcdir)/nofmtch.ok _$@ && rm -f _$@

strftime::
	: this test could fail on slow machines or on a second boundary,
	: so if it does, double check the actual results
	@echo 'It will also fail using DJGPP because DJGPP does not'
	@echo 'have a default timezone.'
#	@LC_ALL=C; export LC_ALL; LANG=C; export LANG; \
#	date | $(AWK) -v OUTPUT=_$@ -f $(srcdir)/strftime.awk
	@LC_ALL=C; export LC_ALL; LANG=C; export LANG; \
	$(DATE) | $(AWK) -v OUTPUT=_$@ -f $(srcdir)/strftime.awk
	-$(CMP) strftime.ok _$@ && rm -f _$@ strftime.ok || exit 0

litoct::
	@echo ab | $(AWK) --traditional -f $(srcdir)/litoct.awk >_$@
	-$(CMP) $(srcdir)/litoct.ok _$@ && rm -f _$@

gensub::
	@$(AWK) -f $(srcdir)/gensub.awk $(srcdir)/gensub.in >_$@
	-$(CMP) $(srcdir)/gensub.ok _$@ && rm -f _$@

resplit::
	@echo a:b:c d:e:f | $(AWK) '{ FS = ":"; $$0 = $$0; print $$2 }' > _$@
	-$(CMP) $(srcdir)/resplit.ok _$@ && rm -f _$@

rswhite::
	@$(AWK) -f $(srcdir)/rswhite.awk $(srcdir)/rswhite.in > _$@
	-$(CMP) $(srcdir)/rswhite.ok _$@ && rm -f _$@

prmarscl::
	@-AWKPATH=$(srcdir) $(AWK) -f prmarscl.awk > _$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/prmarscl.ok _$@ && rm -f _$@

sclforin::
	@-AWKPATH=$(srcdir) $(AWK) -f sclforin.awk > _$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/sclforin.ok _$@ && rm -f _$@

sclifin::
	@-AWKPATH=$(srcdir) $(AWK) -f sclifin.awk > _$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/sclifin.ok _$@ && rm -f _$@

intprec::
	@-$(AWK) -f $(srcdir)/intprec.awk > _$@ 2>&1
	-$(CMP) $(srcdir)/intprec.ok _$@ && rm -f _$@

childin::
	@echo hi | $(AWK) 'BEGIN { "cat" | getline; print; close("cat") }' > _$@
	-$(CMP) $(srcdir)/childin.ok _$@ && rm -f _$@

noeffect::
	@-AWKPATH=$(srcdir) $(AWK) --lint -f noeffect.awk > _$@ 2>&1
	-$(CMP) $(srcdir)/noeffect.ok _$@ && rm -f _$@

numsubstr::
	@-AWKPATH=$(srcdir) $(AWK) -f numsubstr.awk $(srcdir)/numsubstr.in >_$@
	-$(CMP) $(srcdir)/numsubstr.ok _$@ && rm -f _$@

gnureops::
	@$(AWK) -f $(srcdir)/gnureops.awk >_$@
	-$(CMP) $(srcdir)/gnureops.ok _$@ && rm -f _$@

pcntplus::
	@$(AWK) -f $(srcdir)/pcntplus.awk >_$@
	-$(CMP) $(srcdir)/pcntplus.ok _$@ && rm -f _$@

prmreuse::
	@$(AWK) -f $(srcdir)/prmreuse.awk >_$@
	-$(CMP) $(srcdir)/prmreuse.ok _$@ && rm -f _$@

math::
	@$(AWK) -f $(srcdir)/math.awk >_$@
	-$(CMP) $(srcdir)/math.ok _$@ && rm -f _$@

fflush::
	@$(srcdir)/fflush.sh >_$@
	-$(CMP) $(srcdir)/fflush.ok _$@ && rm -f _$@

fldchg::
	@$(AWK) -f $(srcdir)/fldchg.awk $(srcdir)/fldchg.in >_$@
	-$(CMP) $(srcdir)/fldchg.ok _$@ && rm -f _$@

fldchgnf::
	@$(AWK) -f $(srcdir)/fldchgnf.awk $(srcdir)/fldchgnf.in >_$@
	-$(CMP) $(srcdir)/fldchgnf.ok _$@ && rm -f _$@

reindops::
	@$(AWK) -f $(srcdir)/reindops.awk $(srcdir)/reindops.in >_$@
	-$(CMP) $(srcdir)/reindops.ok _$@ && rm -f _$@

sprintfc::
	@$(AWK) -f $(srcdir)/sprintfc.awk $(srcdir)/sprintfc.in >_$@
	-$(CMP) $(srcdir)/sprintfc.ok _$@ && rm -f _$@

getlnhd::
# In 3.0.3, COMSPEC=$(SHELL) was used for MSC and MINGW32 which do
# not honor SHELL.
#	COMSPEC=$(SHELL) $(AWK) -f $(srcdir)/getlnhd.awk >_$@
	@$(AWK) -f $(srcdir)/getlnhd.awk >_$@
	-$(CMP) $(srcdir)/getlnhd.ok _$@ && rm -f _$@

backgsub::
	@$(AWK) -f $(srcdir)/backgsub.awk $(srcdir)/backgsub.in >_$@
	-$(CMP) $(srcdir)/backgsub.ok _$@ && rm -f _$@

tweakfld::
	@$(AWK) -f $(srcdir)/tweakfld.awk $(srcdir)/tweakfld.in >_$@
	@rm -f errors.cleanup
	-$(CMP) $(srcdir)/tweakfld.ok _$@ && rm -f _$@

clsflnam::
	@$(AWK) -f $(srcdir)/clsflnam.awk $(srcdir)/clsflnam.in >_$@ 2>&1
	-$(CMP) $(srcdir)/clsflnam.ok _$@ && rm -f _$@

mmap8k::
	@echo 'If mmap8k fails make sure that mmap8k.in has CR/LFs.'
	@$(AWK) '{ print }' $(srcdir)/mmap8k.in >_$@
	-$(CMP) $(srcdir)/mmap8k.in _$@ && rm -f _$@

fnarray::
	@-AWKPATH=$(srcdir) $(AWK) -f fnarray.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/fnarray.ok _$@ && rm -f _$@

dynlj::
	@$(AWK) -f $(srcdir)/dynlj.awk >_$@
	-$(CMP) $(srcdir)/dynlj.ok _$@ && rm -f _$@

substr::
	@$(AWK) -f $(srcdir)/substr.awk >_$@
	-$(CMP) $(srcdir)/substr.ok _$@ && rm -f _$@

eofsplit::
	@$(AWK) -f $(srcdir)/eofsplit.awk >_$@
	-$(CMP) $(srcdir)/eofsplit.ok _$@ && rm -f _$@

prt1eval::
	@$(AWK) -f $(srcdir)/prt1eval.awk >_$@
	-$(CMP) $(srcdir)/prt1eval.ok _$@ && rm -f _$@

gsubasgn::
	@-AWKPATH=$(srcdir) $(AWK) -f gsubasgn.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/gsubasgn.ok _$@ && rm -f _$@

prtoeval::
	@$(AWK) -f $(srcdir)/prtoeval.awk >_$@
	-$(CMP) $(srcdir)/prtoeval.ok _$@ && rm -f _$@

gsubtest::
	@$(AWK) -f $(srcdir)/gsubtest.awk >_$@
	-$(CMP) $(srcdir)/gsubtest.ok _$@ && rm -f _$@

splitwht::
	@$(AWK) -f $(srcdir)/splitwht.awk >_$@
	-$(CMP) $(srcdir)/splitwht.ok _$@ && rm -f _$@

back89::
	@$(AWK) '/a\8b/' $(srcdir)/back89.in >_$@
	-$(CMP) $(srcdir)/back89.ok _$@ && rm -f _$@

tradanch::
	@$(AWK) --traditional -f $(srcdir)/tradanch.awk $(srcdir)/tradanch.in >_$@
	-$(CMP) $(srcdir)/tradanch.ok _$@ && rm -f _$@

nlfldsep::
	@$(AWK) -f $(srcdir)/nlfldsep.awk $(srcdir)/nlfldsep.in > _$@
	-$(CMP) $(srcdir)/nlfldsep.ok _$@ && rm -f _$@

splitvar::
	@$(AWK) -f $(srcdir)/splitvar.awk $(srcdir)/splitvar.in >_$@
	-$(CMP) $(srcdir)/splitvar.ok _$@ && rm -f _$@

intest::
	@$(AWK) -f $(srcdir)/intest.awk >_$@
	-$(CMP) $(srcdir)/intest.ok _$@ && rm -f _$@

# AIX /bin/sh exec's the last command in a list, therefore issue a ":"
# command so that pid.sh is fork'ed as a child before being exec'ed.
pid::
	@echo 'Expect pid to fail in DOS.'
	@AWKPATH=$(srcdir) AWK=$(AWK) $(SHELL) $(srcdir)/pid.sh $$$$ > _`basename $@` ; :
	-$(CMP) $(srcdir)/pid.ok _`basename $@` && rm -f _`basename $@` _`basename $@`.in

strftlng::
	@echo 'Edit test/Makefile if you use MSC6, since strftlng will fail.'
	@TZ=UTC; export TZ; $(AWK) -f $(srcdir)/strftlng.awk >_$@
#	@if $(CMP) -s $(srcdir)/strftlng.ok _$@ ; then : ; else \
#	TZ=UTC0; export TZ; $(AWK) -f $(srcdir)/strftlng.awk >_$@ ; \
#	fi
	@if $(CMP) -s $(srcdir)/strftlng.ok _$@ ; then : ; else \
	env TZ=UTC0; $(AWK) -f $(srcdir)/strftlng.awk >_$@ ; \
	fi
	-$(CMP) $(srcdir)/strftlng.ok _$@ && rm -f _$@

nfldstr::
	@echo | $(AWK) '$$1 == 0 { print "bug" }' > _$@
	-$(CMP) $(srcdir)/nfldstr.ok _$@ && rm -f _$@

nors::
#	@echo A B C D E | tr -d '\12' | $(AWK) '{ print $$NF }' - $(srcdir)/nors.in > _$@
	@echo A B C D E | tr -d '\15\12' | $(AWK) '{ print $$NF }' - $(srcdir)/nors.in > _$@
	-$(CMP) $(srcdir)/nors.ok _$@ && rm -f _$@

fnarydel::
	@$(AWK) -f $(srcdir)/fnarydel.awk >_$@
	-$(CMP) $(srcdir)/fnarydel.ok _$@ && rm -f _$@

reint::
	@$(AWK) --re-interval -f $(srcdir)/reint.awk $(srcdir)/reint.in >_$@
	-$(CMP) $(srcdir)/reint.ok _$@ && rm -f _$@

noparms::
	@-AWKPATH=$(srcdir) $(AWK) -f noparms.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/noparms.ok _$@ && rm -f _$@

pipeio1::
	@$(AWK) -f $(srcdir)/pipeio1.awk >_$@
	@rm -f test1 test2
	-$(CMP) $(srcdir)/pipeio1.ok _$@ && rm -f _$@

pipeio2::
# This would fail were it not for the "cat" line due to DOS's ECHO command.
	@echo 'pipeio may fail due to the way that your tr & echo work in DOS'
	@$(AWK) -v SRCDIR=$(srcdir) -f $(srcdir)/pipeio2.awk >_$@
	@cat _$@ | $(AWK) '{ sub("ECHO is.*","",$$0); print $$0 } ' > _$@.2
#	-$(CMP) $(srcdir)/pipeio2.ok _$@ && rm -f _$@
	-diff -w $(srcdir)/pipeio2.ok _$@.2 && rm -f _$@ _$@.2

funstack::
	@echo 'Expect funstack to fail with MSC DOS versions.'
#	@$(AWK) -f $(srcdir)/funstack.awk $(srcdir)/funstack.in >_$@
	@-$(AWK) -f $(srcdir)/funstack.awk $(srcdir)/funstack.in >_$@
	-$(CMP) $(srcdir)/funstack.ok _$@ && rm -f _$@

clobber::
	@$(AWK) -f $(srcdir)/clobber.awk >_$@
	-$(CMP) $(srcdir)/clobber.ok seq && $(CMP) $(srcdir)/clobber.ok _$@ && rm -f _$@
	@rm -f seq

delarprm::
	@$(AWK) -f $(srcdir)/delarprm.awk >_$@
	-$(CMP) $(srcdir)/delarprm.ok _$@ && rm -f _$@

prdupval::
	@$(AWK) -f $(srcdir)/prdupval.awk $(srcdir)/prdupval.in >_$@
	-$(CMP) $(srcdir)/prdupval.ok _$@ && rm -f _$@

nondec::
#	@if grep BITOP ../config.h | grep define > /dev/null; \
#	then \
#		$(AWK) -f $(srcdir)/nondec.awk >_$@; \
#	else \
#		cp $(srcdir)/nondec.ok _$@; \
#	fi
	@if grep BITOP ../config.h | grep define > /dev/null; \
	then \
		$(AWK) -f $(srcdir)/nondec.awk >_$@; \
	else \
		$(CP) $(srcdir)\\nondec.ok _$@; \
	fi
	-$(CMP) $(srcdir)/nondec.ok _$@ && rm -f _$@

nasty::
	@$(AWK) -f $(srcdir)/nasty.awk >_$@
	-$(CMP) $(srcdir)/nasty.ok _$@ && rm -f _$@

nasty2::
	@$(AWK) -f $(srcdir)/nasty2.awk >_$@
	-$(CMP) $(srcdir)/nasty2.ok _$@ && rm -f _$@

zeroflag::
	@$(AWK) -f $(srcdir)/zeroflag.awk >_$@
	-$(CMP) $(srcdir)/zeroflag.ok _$@ && rm -f _$@

getnr2tm::
	@$(AWK) -f $(srcdir)/getnr2tm.awk $(srcdir)/getnr2tm.in >_$@
	-$(CMP) $(srcdir)/getnr2tm.ok _$@ && rm -f _$@

getnr2tb::
	@$(AWK) -f $(srcdir)/getnr2tb.awk $(srcdir)/getnr2tb.in >_$@
	-$(CMP) $(srcdir)/getnr2tb.ok _$@ && rm -f _$@

printf1::
	@$(AWK) -f $(srcdir)/printf1.awk >_$@
	-$(CMP) $(srcdir)/printf1.ok _$@ && rm -f _$@

funsmnam::
	@-AWKPATH=$(srcdir) $(AWK) -f funsmnam.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/funsmnam.ok _$@ && rm -f _$@

fnamedat::
	@-AWKPATH=$(srcdir) $(AWK) -f fnamedat.awk < $(srcdir)/fnamedat.in >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/fnamedat.ok _$@ && rm -f _$@

numindex::
	@-AWKPATH=$(srcdir) $(AWK) -f numindex.awk < $(srcdir)/numindex.in >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/numindex.ok _$@ && rm -f _$@

subslash::
	@-AWKPATH=$(srcdir) $(AWK) -f subslash.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/subslash.ok _$@ && rm -f _$@

opasnslf::
	@-AWKPATH=$(srcdir) $(AWK) -f opasnslf.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/opasnslf.ok _$@ && rm -f _$@

opasnidx::
	@-AWKPATH=$(srcdir) $(AWK) -f opasnidx.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/opasnidx.ok _$@ && rm -f _$@

arynocls::
	@-AWKPATH=$(srcdir) $(AWK) -v INPUT=$(srcdir)/arynocls.in -f arynocls.awk >_$@
	-$(CMP) $(srcdir)/arynocls.ok _$@ && rm -f _$@

igncdym::
	@-AWKPATH=$(srcdir) $(AWK) -f igncdym.awk $(srcdir)/igncdym.in >_$@
	-$(CMP) $(srcdir)/igncdym.ok _$@ && rm -f _$@

getlnbuf::
	@echo getlnbuf runs out of memory with MSC gawk.
	@-AWKPATH=$(srcdir) $(AWK) -f getlnbuf.awk $(srcdir)/getlnbuf.in > _$@
	@-AWKPATH=$(srcdir) $(AWK) -f gtlnbufv.awk $(srcdir)/getlnbuf.in > _2$@
	-$(CMP) $(srcdir)/getlnbuf.ok _$@ && $(CMP) $(srcdir)/getlnbuf.ok _2$@ && rm -f _$@ _2$@

arysubnm::
	@-AWKPATH=$(srcdir) $(AWK) -f arysubnm.awk >_$@
	-$(CMP) $(srcdir)/arysubnm.ok _$@ && rm -f _$@

fnparydl::
	@-AWKPATH=$(srcdir) $(AWK) -f fnparydl.awk >_$@
	-$(CMP) $(srcdir)/fnparydl.ok _$@ && rm -f _$@

nlstrina::
	@-AWKPATH=$(srcdir) $(AWK) -f nlstrina.awk >_$@
	-$(CMP) $(srcdir)/nlstrina.ok _$@ && rm -f _$@

octsub::
	@-AWKPATH=$(srcdir) $(AWK) -f octsub.awk >_$@
	-$(CMP) $(srcdir)/octsub.ok _$@ && rm -f _$@

nlinstr::
	@$(AWK) -f $(srcdir)/nlinstr.awk $(srcdir)/nlinstr.in >_$@
	-$(CMP) $(srcdir)/nlinstr.ok _$@ && rm -f _$@

ofmt::
	@$(AWK) -f $(srcdir)/ofmt.awk $(srcdir)/ofmt.in >_$@
	-$(CMP) $(srcdir)/ofmt.ok _$@ && rm -f _$@

hsprint::
	@echo 'hsprint test may fail due to 1.27e+01 not being equal to'
	@echo '1.27e+001 (and similarly for other numbers) for MSC gawk.'
	@$(AWK) -f $(srcdir)/hsprint.awk >_$@
	-$(CMP) $(srcdir)/hsprint.ok _$@ && rm -f _$@

fsfwfs::
	@$(AWK) -f $(srcdir)/fsfwfs.awk $(srcdir)/fsfwfs.in >_$@
	-$(CMP) $(srcdir)/fsfwfs.ok _$@ && rm -f _$@

ofmts::
	@$(AWK) -f $(srcdir)/ofmts.awk $(srcdir)/ofmts.in >_$@
	-$(CMP) $(srcdir)/ofmts.ok _$@ && rm -f _$@

parseme::
	@-AWKPATH=$(srcdir) $(AWK) -f parseme.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/parseme.ok _$@ && rm -f _$@

splitdef::
	@$(AWK) -f $(srcdir)/splitdef.awk >_$@
	-$(CMP) $(srcdir)/splitdef.ok _$@ && rm -f _$@

fnaryscl::
	@-AWKPATH=$(srcdir) $(AWK) -f fnaryscl.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/fnaryscl.ok _$@ && rm -f _$@

fnasgnm::
	@-AWKPATH=$(srcdir) $(AWK) -f fnasgnm.awk < $(srcdir)/fnasgnm.in >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/fnasgnm.ok _$@ && rm -f _$@

lint::
	@-AWKPATH=$(srcdir) $(AWK) -f lint.awk > _$@ 2>&1
	-$(CMP) $(srcdir)/lint.ok _$@ && rm -f _$@

procinfs::
	@-$(AWK) -f $(srcdir)/procinfs.awk > _$@
	-$(CMP) $(srcdir)/procinfs.ok _$@ && rm -f _$@

sort1::
	@-$(AWK) -f $(srcdir)/sort1.awk > _$@
	-$(CMP) $(srcdir)/sort1.ok _$@ && rm -f _$@

ofmtbig::
	@$(AWK) -f $(srcdir)/ofmtbig.awk $(srcdir)/ofmtbig.in >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/ofmtbig.ok _$@ && rm -f _$@

inetmesg::
	@echo These tests only work if your system supports the services
	@echo "'discard'" at port 9 and "'daytimed" at port 13. Check your
	@echo file /etc/services and do "'netstat -a'".

inetechu::
	@echo inetechu fails with MSC and DJGPP because "|&" is not supported.
	@echo This test is for establishing UDP connections
#	@$(AWK) 'BEGIN {print "" |& "/inet/udp/0/127.0.0.1/9"}'
	@-$(AWK) 'BEGIN {print "" |& "/inet/udp/0/127.0.0.1/9"}'

inetecht::
	@echo inetecht fails with MSC and DJGPP because "|&" is not supported.
	@echo This test is for establishing TCP connections
#	@$(AWK) 'BEGIN {print "" |& "/inet/tcp/0/127.0.0.1/9"}'
	@-$(AWK) 'BEGIN {print "" |& "/inet/tcp/0/127.0.0.1/9"}'

inetdayu::
	@echo inetdayu fails with MSC and DJGPP because "|&" is not supported.
	@echo This test is for bidirectional UDP transmission
#	@$(AWK) 'BEGIN { print "" |& "/inet/udp/0/127.0.0.1/13"; \
#	"/inet/udp/0/127.0.0.1/13" |& getline; print $0}'
	@-$(AWK) 'BEGIN { print "" |& "/inet/udp/0/127.0.0.1/13"; \
	"/inet/udp/0/127.0.0.1/13" |& getline; print $0}'

inetdayt::
	@echo inetdayt fails with MSC and DJGPP because "|&" is not supported.
	@echo This test is for bidirectional TCP transmission
#	@$(AWK) 'BEGIN { print "" |& "/inet/tcp/0/127.0.0.1/13"; \
#	"/inet/tcp/0/127.0.0.1/13" |& getline; print $0}'
	@-$(AWK) 'BEGIN { print "" |& "/inet/tcp/0/127.0.0.1/13"; \
	"/inet/tcp/0/127.0.0.1/13" |& getline; print $0}'

paramtyp::
	@$(AWK) -f $(srcdir)/paramtyp.awk >_$@
	-$(CMP) $(srcdir)/paramtyp.ok _$@ && rm -f _$@

rsnul1nl::
	@$(AWK) -f $(srcdir)/rsnul1nl.awk $(srcdir)/rsnul1nl.in >_$@
	-$(CMP) $(srcdir)/rsnul1nl.ok _$@ && rm -f _$@

datanonl::
	@$(AWK) -f $(srcdir)/datanonl.awk $(srcdir)/datanonl.in >_$@
	-$(CMP) $(srcdir)/datanonl.ok _$@ && rm -f _$@

regeq::
	@$(AWK) -f $(srcdir)/regeq.awk $(srcdir)/regeq.in >_$@
	-$(CMP) $(srcdir)/regeq.ok _$@ && rm -f _$@

redfilnm::
	@$(AWK) -f $(srcdir)/redfilnm.awk srcdir=$(srcdir) $(srcdir)/redfilnm.in >_$@
	-$(CMP) $(srcdir)/redfilnm.ok _$@ && rm -f _$@

strtod::
	@$(AWK) -f $(srcdir)/strtod.awk $(srcdir)/strtod.in >_$@
	-$(CMP) $(srcdir)/strtod.ok _$@ && rm -f _$@

leaddig::
	@$(AWK) -v x=2E  -f $(srcdir)/leaddig.awk >_$@
	-$(CMP) $(srcdir)/leaddig.ok _$@ && rm -f _$@

clos1way::
	@echo clos1way fails with MSC and DJGPP because "|&" is not supported.
#	@$(AWK) -f $(srcdir)/clos1way.awk >_$@
	@-$(AWK) -f $(srcdir)/clos1way.awk >_$@
	-$(CMP) $(srcdir)/clos1way.ok _$@ && rm -f _$@

arynasty::
	@$(AWK) -f $(srcdir)/arynasty.awk >_$@
	-$(CMP) $(srcdir)/arynasty.ok _$@ && rm -f _$@

shadow::
	@-AWKPATH=$(srcdir) $(AWK) --lint -f shadow.awk >_$@ 2>&1 || exit 0
	-$(CMP) $(srcdir)/shadow.ok _$@ && rm -f _$@

regx8bit::
	@$(AWK) -f $(srcdir)/regx8bit.awk >_$@
	-$(CMP) $(srcdir)/regx8bit.ok _$@ && rm -f _$@

psx96sub::
	@$(AWK) -f $(srcdir)/psx96sub.awk >_$@
	-$(CMP) $(srcdir)/psx96sub.ok _$@ && rm -f _$@

addcomma::
	@echo 'If addcomma fails, set try setting LFN=n in your environment'
	@echo "before running make.  If that still doesn't work, read the"
	@echo 'the comment in this makefile about setting CMP for information'
	@echo 'about what may be happenning.'
	@$(AWK) -f $(srcdir)/addcomma.awk $(srcdir)/addcomma.in >_$@
	-$(CMP) $(srcdir)/addcomma.ok _$@ && rm -f _$@

gnuops2::
	@$(AWK) -f $(srcdir)/gnuops2.awk >_$@
	-$(CMP) $(srcdir)/gnuops2.ok _$@ && rm -f _$@

rebt8b1::
	@$(AWK) -f $(srcdir)/rebt8b1.awk >_$@
	-$(CMP) $(srcdir)/rebt8b1.ok _$@ && rm -f _$@

rebt8b2::
	@$(AWK) -f $(srcdir)/rebt8b2.awk >_$@
	-$(CMP) $(srcdir)/rebt8b2.ok _$@ && rm -f _$@

clean:
	rm -fr _* core junk out1 out2 out3 strftime.ok test1 test2 seq *~

# This target for my convenience to look at all the results
diffout:
	for i in _* ; \
	do  \
		echo ============== $$i ============= ; \
		diff -c $${i#_}.ok  $$i ; \
	done | more

# Tell versions [3.59,3.63) of GNU make to not export all variables.
# Otherwise a system limit (for SysV at least) may be exceeded.
.NOEXPORT:
