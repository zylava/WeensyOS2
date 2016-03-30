#include "schedos-app.h"
#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

#ifndef PRINTCHAR
#define PRINTCHAR	('1' | 0x0C00)
#endif

// UNCOMMENT THE NEXT LINE TO USE EXERCISE 8 CODE INSTEAD OF EXERCISE 6
// #define __EXERCISE_8__


void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		#ifndef __EXERCISE_8__
			//exercise 6 code
			sys_atomic_char(PRINTCHAR);
		#else
			//exercise 8 code
			while(atomic_swap(&lock, 1) != 0)
				continue;
			*cursorpos++ = PRINTCHAR;
			atomic_swap (&lock, 0);

		#endif
		//sys_yield();
	}

	sys_exit(0);
}
