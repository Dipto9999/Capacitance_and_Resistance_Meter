/*
   20001024-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#pragma disable_warning 85
#endif

#include <string.h>

struct a;

extern int baz (struct a *restrict x);

struct a {
  long v;
  long w;
};

struct b {
  struct a c;
  struct a d;
};

int bar (int x, const struct b *restrict y, struct b *restrict z)
{
  if (y->c.v || y->c.w != 250000 || y->d.v || y->d.w != 250000)
    ASSERT (0);
}

void foo(void)
{
  struct b x;
  x.c.v = 0;
  x.c.w = 250000;
// Not supported by C51 yet!
//  x.d = x.c;
  memcpy(&x.d, &x.c, sizeof(struct a));
  bar(0, &x, ((void *)0));
}

void
testTortureExecute (void)
{
  foo();
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
  return "cases_gcc\\gcc-torture-execute-20001024-1";
}
