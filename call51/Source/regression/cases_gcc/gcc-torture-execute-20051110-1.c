/*
   20051110-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

void add_unwind_adjustsp (long);

unsigned char bytes[5];

void
add_unwind_adjustsp (long offset)
{
  int n;
  unsigned long o;

  o = (long) ((offset - 0x204) >> 2);

  n = 0;
  while (o)
    {
      bytes[n] = o & 0x7f;
      o >>= 7;
      if (o)
	bytes[n] |= 0x80;
      n++;
    }
}

void testTortureExecute(void)
{
  add_unwind_adjustsp (4132);
  if (bytes[0] != 0x88 || bytes[1] != 0x07)
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
  return "cases_gcc\\gcc-torture-execute-20051110-1";
}
