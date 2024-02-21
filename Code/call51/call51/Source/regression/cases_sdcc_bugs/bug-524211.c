/* Problem with casts and warnings.
 */
#include "../fwk/include/testfwk.h"

#if 0
/* Disabled as this only shows a warning */

typedef unsigned short UINT16;
typedef unsigned char UINT8;

typedef struct _Class Class;

typedef struct _String
{
  const UINT8 sz[1];
} String;

struct _Class
{
  String *szName;
};

const Class Bar = {
  "java.lang.Object",
};

void foo(void)
{
}
#endif

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
  return "cases_sdcc_bugs\\bug-524211";
}
