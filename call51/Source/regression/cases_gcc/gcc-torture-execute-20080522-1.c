/*
   20080522-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* This testcase is to make sure we have i in referenced vars and that we
   properly compute aliasing for the loads and stores.  */

static int i;
static int *p = &i;

int
foo(int *q)
{
  *p = 1;
  *q = 2;
  return *p;
}

int
bar(int *q)
{
  *q = 2;
  *p = 1;
  return *q;
}

void
testTortureExecute (void)
{
  int j = 0;

  if (foo(&i) != 2)
    ASSERT (0);
  if (bar(&i) != 1)
    ASSERT (0);
  if (foo(&j) != 1)
    ASSERT (0);
  if (j != 2)
    ASSERT (0);
  if (bar(&j) != 2)
    ASSERT (0);
  if (j != 2)
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
  return "cases_gcc\\gcc-torture-execute-20080522-1";
}
