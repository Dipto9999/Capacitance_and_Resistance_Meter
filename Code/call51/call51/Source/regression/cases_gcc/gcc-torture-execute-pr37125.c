/*
   pr37125.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

static inline unsigned int
mod_rhs(int rhs)
{
  if (rhs == 0) return 1;
  return rhs;
}

void func_44 (unsigned int p_45);
void func_44 (unsigned int p_45)
{
  if (!((p_45 * -9) % mod_rhs (-9))) {
      ASSERT (0);
  }
}

void
testTortureExecute (void)
{
  func_44 (2);
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
  return "cases_gcc\\gcc-torture-execute-pr37125";
}
