/*
   20040704-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* PR 16348: Make sure that condition-first false loops DTRT.  */

void
testTortureExecute (void)
{
  for (; 0 ;)
    {
      ASSERT (0);
    label:
      return;
    }
  goto label;
}
