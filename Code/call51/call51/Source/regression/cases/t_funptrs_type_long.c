/** Function pointer tests.

    type: BOOL, char, int, long
 */
#include "../fwk/include/testfwk.h"

#ifdef C51
#pragma std_c5199
#endif

#include <stdbool.h>

#ifndef BOOL
#define BOOL	bool
#endif

#define TYPE_long

/* Must use a typedef as there is no way of adding the code modifier
   on the z80.
*/
typedef void (*NOARGFUNPTR)(void);
typedef void (*ONEARGFUNPTR)(long) REENTRANT;
typedef long int (*FOURARGFUNPTR)(char, char, long int, long int) REENTRANT;
typedef long (*TYPEFUNPTR)(long, long) REENTRANT;

int count;
FOURARGFUNPTR fafp;
TYPEFUNPTR tfp;

void
incCount(void)
{
  count++;
}

void
incBy(long a) REENTRANT
{
  count += a;
}

long int f6(char a, char b, long int c, long int d) REENTRANT
{
  switch (a)
    {
    case 0: return a;
    case 1: return b;
    case 2: return c;
    case 3: return d;
    }
  return 0;
}


void
callViaPtr(NOARGFUNPTR fptr)
{
  (*fptr)();
}

void
callViaPtr2(ONEARGFUNPTR fptr, long arg)
{
  (*fptr)(arg);
}

void
callViaPtr3(void (*fptr)(void))
{
  (*fptr)();
}

void
callViaPtrAnsi(NOARGFUNPTR fptr)
{
  fptr();
}

void
callViaPtr2Ansi(ONEARGFUNPTR fptr, long arg)
{
  fptr(arg);
}

void
callViaPtr3Ansi(void (*fptr)(void))
{
  fptr();
}

long f_ret(long arg1, long arg2) REENTRANT
{
  long local;
  local = !arg1;
  return (local & arg2);
}



void
testFunPtr(void)
{
  fafp = f6;

  ASSERT(count == 0);
  callViaPtr(incCount);
  ASSERT(count == 1);
  callViaPtr2(incBy, 7);
  ASSERT(count == 8 || count == 2);

  ASSERT((*fafp)(0, 0x55, 0x12345678, 0x9abcdef0) == 0);
  ASSERT((*fafp)(1, 0x55, 0x12345678, 0x9abcdef0) == 0x55);
  ASSERT((*fafp)(2, 0x55, 0x12345678, 0x9abcdef0) == 0x12345678);
  ASSERT((*fafp)(3, 0x55, 0x12345678, 0x9abcdef0) == 0x9abcdef0);
}

void
testFunPtrAnsi(void)
{
  fafp = f6;

  count = 0;
  callViaPtrAnsi(incCount);
  ASSERT(count == 1);
  callViaPtr2Ansi(incBy, 7);
  ASSERT(count == 8 || count == 2);

  ASSERT(fafp(0, 0x55, 0x12345678, 0x9abcdef0) == 0);
  ASSERT(fafp(1, 0x55, 0x12345678, 0x9abcdef0) == 0x55);
  ASSERT(fafp(2, 0x55, 0x12345678, 0x9abcdef0) == 0x12345678);
  ASSERT(fafp(3, 0x55, 0x12345678, 0x9abcdef0) == 0x9abcdef0);
}

void
testFunPtrReturn(void)
{
  tfp = f_ret;

  ASSERT(tfp(0, 0) == 0);
  ASSERT(tfp(0, 1) == 1);
  ASSERT(tfp(1, 0) == 0);
  ASSERT(tfp(1, 1) == 0);
}


void
__runSuite(void)
{
  __prints("Running testFunPtr\n");
  testFunPtr();
  __prints("Running testFunPtrAnsi\n");
  testFunPtrAnsi();
  __prints("Running testFunPtrReturn\n");
  testFunPtrReturn();
}

const int __numCases = 3;

__code const char *
__getSuiteName(void)
{
  return "cases\\t_funptrs_type_long";
}
