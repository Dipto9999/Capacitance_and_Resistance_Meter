/*
   20020503-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

#ifndef __C51_mcs51
/* PR 6534 */
/* GCSE unified the two i<0 tests, but if-conversion to ui=abs(i) 
   insertted the code at the wrong place corrupting the i<0 test.  */

static char *
inttostr (long i, char buf[128])
{
  unsigned long ui = i;
  char *p = buf + 127;
  *p = '\0';
  if (i < 0)
    ui = -ui;
  do
    *--p = '0' + ui % 10;
  while ((ui /= 10) != 0);
  if (i < 0)
    *--p = '-';
  return p;
}
#endif

void
testTortureExecute (void)
{
#ifndef __C51_mcs51
  char buf[128], *p;

  p = inttostr (-1, buf);
  if (*p != '-')
    ASSERT (0);
  return;
#endif
}

void
__runSuite(void)
{
  __prints("Running testTortureExecute\n");
  testTortureExecute();
}

const int __numCases = 1;

__code const char *
__getSuiteName(void)
{
  return "cases_gcc\\gcc-torture-execute-20020503-1";
}
