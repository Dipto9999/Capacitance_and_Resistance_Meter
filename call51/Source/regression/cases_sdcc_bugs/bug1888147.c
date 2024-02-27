/*
    bug 1888147
*/

#include "../fwk/include/testfwk.h"

// no need to call this, it generates compiler error:
//   Caught signal 11: SIGSEGV
int foo(int n)
{
	int i = 0;

	if (i!=0)
		return n;
	return 0;
}

void
testBug(void)
{
	ASSERT(1);
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
  return "cases_sdcc_bugs\\bug1888147";
}
