/*
   920730-1.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

/* 920730-1.c */
#include <limits.h>
int f1()
{
	int b=INT_MIN;
	return b>=INT_MIN;
}

int f2()
{
	int b=INT_MIN+1;
	return b>= (unsigned)(INT_MAX+2);
}

int f3()
{
	int b=INT_MAX;
	return b>=INT_MAX;
}

int f4()
{
	int b=-1;
	return b>=UINT_MAX;
}

void
testTortureExecute (void)
{
	if((f1()&f2()&f3()&f4())!=1)
		ASSERT(0);
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
  return "cases_gcc\\gcc-torture-execute-920730-1";
}
