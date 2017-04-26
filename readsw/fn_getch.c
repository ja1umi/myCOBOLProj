#include <ncurses.h>

int fn_getch(int millis)
{
	int ch;

	savetty();
	cbreak();
	timeout(millis);	// waits for keypress for specified time in milli-seconds.
	noecho();
	ch = getch();
	resetty();

	return ch;
}

