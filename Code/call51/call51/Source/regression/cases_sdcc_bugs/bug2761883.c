/*
   bug2761883.c
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51_STACK_AUTO
#define __xdata
#endif

volatile char __xdata xx1;
volatile int __xdata xx2;

extern void func1 (char __xdata p1, int __xdata p2);

void
testBug (void)
{
  func1 (14, 16);     // this would pass p2 in data memory
  ASSERT (xx1 == 14);
  ASSERT (xx2 == 16);
}

void
func1 (char __xdata p1, int __xdata p2)
{
  xx1 = p1;
  xx2 = p2;           // while this tried to get it from xdata
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
  return "cases_sdcc_bugs\\bug2761883";
}
