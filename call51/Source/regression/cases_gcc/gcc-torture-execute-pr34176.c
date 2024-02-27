/*
   pr34176.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#pragma disable_warning 85
#endif

#include <string.h>

typedef unsigned int index_ty;
typedef index_ty *index_list_ty;

struct mult_index
{
  index_ty index;
  unsigned int count;
};

struct mult_index_list
{
  struct mult_index *item;
  size_t nitems;
  size_t nitems_max;

  struct mult_index *item2;
  size_t nitems2_max;
};

int
hash_find_entry (size_t *result)
{
    *result = 2;
    return 0;
}

extern void abort (void);
struct mult_index *
foo (size_t n)
{
  static count = 0;
  if (count++ > 0)
    ASSERT (0);
  return 0;
}

void
testTortureExecute (void)
{
    size_t nitems = 0;

    for (;;)
    {
        size_t list;

        hash_find_entry (&list);
        {
            size_t len2 = list;
            struct mult_index *destptr;
            struct mult_index *dest;
            size_t new_max  = nitems + len2;

            if (new_max != len2)
                break;
            dest = foo (new_max);

            destptr = dest;
            while (len2--)
                destptr++;

            nitems = destptr - dest;
        }
    }

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
  return "cases_gcc\\gcc-torture-execute-pr34176";
}
