/*
   20050106-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* PR tree-optimization/19283 */

static inline unsigned short
foo (unsigned int *p)
{
  return *p;
}

unsigned int u;

void
testTortureExecute (void)
{
  if ((foo (&u) & 0x8000) != 0)
    ASSERT (0);
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
  return "cases_gcc\\gcc-torture-execute-20050106-1";
}
