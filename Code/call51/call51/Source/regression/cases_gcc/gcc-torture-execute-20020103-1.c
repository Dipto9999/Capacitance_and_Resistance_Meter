/*
   20020103-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* On h8300 port, the following used to be broken with -mh or -ms.  */

unsigned long
foo (unsigned long a)
{
  return a ^ 0x0000ffff;
}

unsigned long
bar (unsigned long a)
{
  return a ^ 0xffff0000;
}

void
testTortureExecute (void)
{
  if (foo (0) != 0x0000ffff)
    ASSERT (0);

  if (bar (0) != 0xffff0000)
    ASSERT (0);
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
  return "cases_gcc\\gcc-torture-execute-20020103-1";
}
