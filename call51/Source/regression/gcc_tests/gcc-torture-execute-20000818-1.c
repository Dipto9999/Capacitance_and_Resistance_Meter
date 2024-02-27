/*
   20000818-1.c from the execute part of the gcc torture tests.
 */

#include "../fwk/include/testfwk.h"

#ifdef __C51
#pragma std_c99
#pragma disable_warning 85
#endif

/* Copyright (C) 2000  Free Software Foundation.

   by Manfred Hollstein <manfredh@redhat.com>  */

void *temporary_obstack;

static int input (void);
static int ISALNUM (int ch);
static void obstack_1grow (void **ptr, int ch);

int yylex (void);

void
testTortureExecute (void)
{
  int ch = yylex ();

  return;
}

int yylex (void)
{
  int ch;

#ifndef WORK_AROUND
  for (;;)
    {
      ch = input ();
      if (ISALNUM (ch))
        obstack_1grow (&temporary_obstack, ch);
      else if (ch != '_')
        break;
    }
#else
  do
    {
      ch = input ();
      if (ISALNUM (ch))
        obstack_1grow (&temporary_obstack, ch);
    } while (ch == '_');
#endif

  return ch;
}

static int input (void)
{
  return 0;
}

static int ISALNUM (int ch)
{
  return ((ch >= 'A' && ch <= 'Z')
	  || (ch >= 'a' && ch <= 'z')
	  || (ch >= '0' && ch <= '0'));
}

static void obstack_1grow (void **ptr, int ch)
{
}

