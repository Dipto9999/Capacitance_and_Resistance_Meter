/*
   20081112-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

#include <limits.h>

static void foo (int a)
{
  int b = (a - 1) + INT_MIN;

  if (b != INT_MIN)
    ASSERT (0);
}

void
testTortureExecute (void)
{
  foo (1);
  return;
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
  return "cases_gcc\\gcc-torture-execute-20081112-1";
}
