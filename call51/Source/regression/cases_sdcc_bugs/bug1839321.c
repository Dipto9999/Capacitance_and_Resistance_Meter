/*
    bug 1839321
*/

#include "../fwk/include/testfwk.h"

__xdata char Global = 2;

__code struct Value {
  char __xdata * Name[2];
} Value_1 = {{&Global, 0}},
  Value_2 = {{&Global, 0}};

char i = 1;

// note: this function expects its first parameter to be passed in
//        2 bytes on **stack** (not registers)
char
bar(char __xdata* __code* ptr, ...)
{
  return **ptr;
}

void
foo (void)
{
}


void
testBug(void)
{
  ASSERT (bar (i ? Value_1.Name : Value_2.Name) == 2);
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
  return "cases_sdcc_bugs\\bug1839321";
}
