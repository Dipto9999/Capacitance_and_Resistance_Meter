/** Tests c51 internal macros.
 */
#include "../fwk/include/testfwk.h"

/* test for bug #2805536: Assembly code comment cause Internal Error
   https://sourceforge.net/tracker/?func=detail&atid=100599&aid=2805536&group_id=599 */
static void
bug_2805536(void)
{
#ifndef PORT_HOST
__asm
; != <-- this should not causes a compiler internal error
__endasm;
#endif
}

static void 
test_macro(void)
{
  bug_2805536();
}
