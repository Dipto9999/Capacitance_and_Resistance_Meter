/*
    bug 2084206
*/

#include <stdarg.h>
#include "../fwk/include/testfwk.h"

typedef struct {
	void (*f) (void);
	char c;
	char* p;
} data_t;

typedef void* voidp_t;
typedef void (*funp_t)(void);

volatile data_t mydata;

long varargs(char i, ...)
{
	va_list arg;
	long ret = -1;

	va_start (arg, i);
	switch (i)
	{
		case 1: ret = (long)va_arg(arg, voidp_t); break;
		case 2: ret = (long)va_arg(arg, funp_t);  break;
	}
	va_end (arg);
	return ret;
}

void testBug(void)
{
	void* ptr = testBug;
	mydata.f = testBug;
	ASSERT (varargs(1, mydata.f) == (long)ptr);
	ASSERT (varargs(1, mydata.f) == (long)(void*)testBug);
	ASSERT (varargs(2, (funp_t)mydata.f) == (long)mydata.f);
	ASSERT (varargs(2, (void (*)(void))mydata.f) == (long)mydata.f);
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
  return "cases_sdcc_bugs\\bug2084206";
}
