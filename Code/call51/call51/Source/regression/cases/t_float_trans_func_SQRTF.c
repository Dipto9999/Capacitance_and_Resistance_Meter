/* Test of transcendent float functions.
   Original from Jesus Calvino-Fraga

   func: SQRTF, LOGF, POWF, TANF
*/
#include "../fwk/include/testfwk.h"
#include <math.h>

#if defined (__STDC_IEC_559__) || defined (C51)
#define SQRTF 1
#endif

void
testTrans(void)
{
#ifdef SQRTF
    ASSERT(fabsf (sqrtf (5.0)     -   2.23606801) < 0.00001);
#endif
#ifdef LOGF
    ASSERT(fabsf (logf (124.0)    -   4.82028150) < 0.00001);
    ASSERT(fabsf (log10f (124.0)  -   2.09342169) < 0.00001);
#endif
#ifdef POWF
  /*  too big for small model */
# ifndef C51_MODEL_SMALL
    ASSERT(fabsf (powf (1.5, 2.0) -   2.24999976) < 0.00001);
# endif
#endif
#ifdef TANF
    ASSERT(fabsf (tanf (1.6)      - -34.23250579) < 0.00001);
#endif
}

void
__runSuite(void)
{
  __prints("Running testTrans\n");
  testTrans();
}

const int __numCases = 1;

__code const char *
__getSuiteName(void)
{
  return "cases\\t_float_trans_func_SQRTF";
}
