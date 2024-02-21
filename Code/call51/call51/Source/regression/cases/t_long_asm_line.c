/* Long line assembler test
 */
#include "../fwk/include/testfwk.h"

volatile unsigned char U0GCR;
volatile unsigned char CLKCON;

enum __nesc_unnamed4261 {
  CC2430_CLKCON_OSC32K = 7,
  CC2430_CLKCON_OSC = 6,
  CC2430_CLKCON_TICKSPD = 3,
  CC2430_CLKCON_CLKSPD = 0,
  CC2430_CLKCON_TICKSPD_MASK = 0x38
};

void
testLongAsmLine(void)
{
  U0GCR = 230400 == 2400 ? 6 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 4800 ? 7 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 9600 ? 8 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 14400 ? 8 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 19200 ? 9 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 28800 ? 9 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 38400 ? 10 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 57600 ? 10 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 76800 ? 11 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 115200 ? 11 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 153600 ? 12 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 230400 ? 12 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 230400 == 307200 ? 13 + ((CLKCON & (1 << CC2430_CLKCON_OSC)) >> CC2430_CLKCON_OSC) : 0;
}


void
__runSuite(void)
{
  __prints("Running testLongAsmLine\n");
  testLongAsmLine();
}

const int __numCases = 1;

__code const char *
__getSuiteName(void)
{
  return "cases\\t_long_asm_line";
}
