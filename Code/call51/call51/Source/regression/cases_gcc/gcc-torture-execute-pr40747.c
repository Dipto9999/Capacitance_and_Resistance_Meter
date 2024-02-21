/*
   pr40747.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* PR middle-end/40747 */

int
foo (int i)
{
  return (i < 4 && i >= 0) ? i : 4;
}

void
testTortureExecute (void)
{
  if (foo (-1) != 4) ASSERT (0);
  if (foo (0) != 0) ASSERT (0);
  if (foo (1) != 1) ASSERT (0);
  if (foo (2) != 2) ASSERT (0);
  if (foo (3) != 3) ASSERT (0);
  if (foo (4) != 4) ASSERT (0);
  if (foo (5) != 4) ASSERT (0);
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
  return "cases_gcc\\gcc-torture-execute-pr40747";
}
