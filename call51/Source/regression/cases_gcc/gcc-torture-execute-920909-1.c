/*
   920909-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

int f(int a){switch(a){case 0x402:return a+1;case 0x403:return a+2;case 0x404:return a+3;case 0x405:return a+4;case 0x406:return 1;case 0x407:return 4;}return 0;}
void
testTortureExecute (void){if(f(1))ASSERT(0);return;}


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
  return "cases_gcc\\gcc-torture-execute-920909-1";
}
