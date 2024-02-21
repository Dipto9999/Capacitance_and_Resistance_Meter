/*
   20061101-2.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* PR rtl-optimization/28970 */
/* Origin: Peter Bergner <bergner@vnet.ibm.com> */

int tar (long i)
{
  if (i != 36863)
    ASSERT (0);

  return -1;
}

void bug(int q, long bcount)
{
  int j = 0;
  int outgo = 0;

  while(j != -1)
    {
      outgo++;
      if (outgo > q-1)
        outgo = q-1;
      j = tar (outgo*bcount);
    }
}

void testTortureExecute(void)
{
  bug(5, 36863);
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
  return "cases_gcc\\gcc-torture-execute-20061101-2";
}
