/*
   20000519-2.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

long x = -1L;

void
testTortureExecute (void)
{
  long b = (x != -1L);

  if (b)
    ASSERT (0);

  return;
}

