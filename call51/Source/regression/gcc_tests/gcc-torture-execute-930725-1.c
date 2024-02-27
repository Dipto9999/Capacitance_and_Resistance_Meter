/*
   930725-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

#include <string.h>

int v;

const char *
g ()
{
  return "";
}

const char *
f ()
{
  return (v == 0 ? g () : "abc");
}

void
testTortureExecute (void)
{
  v = 1;
  if (!strcmp (f (), "abc"))
    return;
  ASSERT (0);
}

