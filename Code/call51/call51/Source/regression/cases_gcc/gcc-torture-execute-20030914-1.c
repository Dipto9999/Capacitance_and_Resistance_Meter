/*
   20030914-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

// TODO: Enable when C51 supports long double!
#if 0
/* On IRIX 6, PB is passed partially in registers and partially on the
   stack, with an odd number of words in the register part.  Check that
   the long double stack argument (PC) is still accessed properly.  */

struct s { int val[16]; };

long double f (int pa, struct s pb, long double pc)
{
  int i;

  for (i = 0; i < 16; i++)
    pc += pb.val[i];
  return pc;
}
#endif

void
testTortureExecute (void)
{
#if 0
  struct s x;
  int i;

  for (i = 0; i < 16; i++)
    x.val[i] = i + 1;
  if (f (1, x, 10000.0L) != 10136.0L)
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
  return "cases_gcc\\gcc-torture-execute-20030914-1";
}
