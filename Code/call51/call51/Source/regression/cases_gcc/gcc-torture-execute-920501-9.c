/*
   920501-9.c from the execute part of the gcc torture suite.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#endif

#include <stdio.h>

// Todo: Enable when C51 supports long long constants!
#if 0
long long proc1(){return 1LL;}
long long proc2(){return 0x12345678LL;}
long long proc3(){return 0xaabbccdd12345678LL;}
long long proc4(){return -1LL;}
long long proc5(){return 0xaabbccddLL;}

print_longlong(x,buf)
     long long x;
     char *buf;
{
  unsigned long l;
  l= (x >> 32) & 0xffffffff;
  if (l != 0)
    sprintf(buf,"%lx%08.lx",l,((unsigned long)x & 0xffffffff));
  else
    sprintf(buf,"%lx",((unsigned long)x & 0xffffffff));
}
#endif

void
testTortureExecute (void){
#if 0
char buf[100];
print_longlong(proc1(),buf);if(strcmp("1",buf))abort();
print_longlong(proc2(),buf);if(strcmp("12345678",buf))abort();
print_longlong(proc3(),buf);if(strcmp("aabbccdd12345678",buf))abort();
print_longlong(proc4(),buf);if(strcmp("ffffffffffffffff",buf))abort();
print_longlong(proc5(),buf);if(strcmp("aabbccdd",buf))abort();
#endif
return;}


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
  return "cases_gcc\\gcc-torture-execute-920501-9";
}
