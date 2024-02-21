/* Registers not being saved.
 */
#include "../fwk/include/testfwk.h"

/* In the following code BC is assigned a copy of fp, but bc is not
   saved across the call.
*/
void
fptr(void (*fp)(void))
{
  int i;
  for (i = 0; i < 50; i++)
    (*fp)();
}

void dummy(void (*fp)(void))
{
  UNUSED(fp);
}

/* This code has the same logic above, but bc is saved.
 */
void
fptr2(void (*fp)(void))
{
  int i;
  void (*fp2)(void) = fp;

  for (i = 0; i < 50; i++)
    dummy(fp2);
}

void testBug(void)
{
}

void
__runSuite(void)
{
  __prints("Running testBug\n");
  testBug();
}

const int __numCases = 1;

__code const char *
__getSuiteName(void)
{
  return "cases_sdcc_bugs\\bug-477835";
}
