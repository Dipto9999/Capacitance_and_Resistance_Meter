/*
   20060930-2.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

#include <string.h>

/* PR middle-end/29272 */

struct S { struct S *s; } s;
struct T { struct T *t; } t;

static inline void
foo (void *s)
{
  struct T *p = s;
  memcpy (&p->t, &t.t, sizeof (t.t));
}

void *
bar (void *p, struct S *q)
{
  q->s = &s;
  foo (p);
  return q->s;
}

void
testTortureExecute (void)
{
  t.t = &t;
  if (bar (&s, &s) != (void *) &t)
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
  return "cases_gcc\\gcc-torture-execute-20060930-2";
}
