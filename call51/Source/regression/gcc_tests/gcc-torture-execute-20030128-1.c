/*
   20030128-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

unsigned char x = 50;
volatile short y = -5;

void
testTortureExecute (void)
{
  x /= y;
  if (x != (unsigned char) -10)
    ASSERT (0);
  return;
}

