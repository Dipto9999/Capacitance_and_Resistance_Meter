/*
   931110-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

typedef struct
{
  short f:3, g:3, h:10;
} small;

struct
{
  int i;
  small s[10];
} x;

void
testTortureExecute (void)
{
  int i;
  for (i = 0; i < 10; i++)
    x.s[i].f = 0;
  return;
}

