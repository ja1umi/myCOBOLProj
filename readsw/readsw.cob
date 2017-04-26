      *> Author: JA1UMI
      *> Date started: April 23, 2017
      *> Date updated: April 24, 2017
      *>
      *> Reads the status of GPIO pin (GPIO number 18) and 
      *> turns the GPIO pin for the corresponding LED
      *> (which is connected to GPIO number 17)
      *> depending on the status by using pigpio library, 
      *> which is installed by default (since Raspbian jessie?).
      *>
      *> How to build this program:
      *>   gcc -c fn_getch.c
      *>   cobc -x readsw.cob fn_getch.o -lpthread -lrt -lpigpio
      *>
       identification division.
       program-id. readsw.

       data division.
       working-storage section.

      *> pigpio/raspberry pi-specific constants
       01 GPIO_17          constant as 17.
       01 GPIO_18          constant as 18.
       01 PI_OUTPUT        constant as 1.
       01 PI_INPUT         constant as 0.
       01 PI_PUD_OFF       constant as 0.
       01 PI_PUD_DOWN      constant as 1.
       01 PI_PUD_UP        constant as 2.
       01 PI_ON            constant as 1.
       01 PI_OFF           constant as 0.
       01 PI_TIME_RELATIVE constant as 0.

      *> ncurses-specific constants
       01 CR               constant as x"0D".
       01 NCURSES_ERR      constant as -1.
      *>  set timeout to 100 milli seconds.
       01 TIMEOUT_MILLIS   constant as 100.

      *> variables used for general housekeeping
       01 led-pin        pic 99   value GPIO_17.
       01 sw-pin         pic 99   value GPIO_18.
       01 stat           usage binary-long signed.
       01 secs           pic 99   value 1.
       01 micros         pic  9   value 0.
       01 result         usage binary-long signed.
       01 inkey          usage binary-long signed value NCURSES_ERR.
       01 edited-result  pic -Z9.
       01 dummy          pic X.

       procedure division.
      *> An integer value (return code by calling pigpio functions
      *> (e.g. gpioVersion() and gpioInitialise() function) can be
      *> returned via the RETURNING clause.
       call 'gpioVersion'     returning result
       move result to edited-result
       display "Found pigpio version #" edited-result " installed." CR
         at line 2   *> this is necessary for ncuerses initialisation.
       end-display
       display CR

      *> Initialises the library. This is must before using the
      *> other library functnions with some exceptions
      *> such as gpioVersion(). 
       call 'gpioInitialise'  returning result
      *> the pigpio version number (>=0) is returned
      *> if "everything is 'Bon'".
       move result to edited-result

       if result is greater than or equal to zero then
         display "pigpio initialisation succeeded." CR

      *> Sets the GPIO mode for the specified Broadcom-numbered
      *> GPIO pin. 
      *> GPIO mode is typically 0 (PI_INPUT) for input or
      *> 1 (PI_OUTPUT) for output.
         call 'gpioSetMode' using by value led-pin by value PI_OUTPUT
      *> Initialises the pin as an input with pull-up enabled
         call 'gpioSetMode' using by value sw-pin  by value PI_INPUT
         call 'gpioSetPullUpDown' using
                                  by value sw-pin by value PI_PUD_UP
         end-call
      *> Exits from the loop if a key was pressed.
         perform until inkey is not equal to NCURSES_ERR

           call 'gpioRead'    using by value sw-pin returning stat

      *>   Remember that the sw-pin is pulled-up.
           if stat is equal to PI_OFF then
      *>     Sets the GPIO level for the specified Broadcom-numbered
      *>     GPIO pin.
      *>     Level is 0 (PI_OFF) for logical low-level or
      *>     1 (PI_ON) for logical high-level.
      *>
      *>     Turns on LED.
             call 'gpioWrite'   using by value led-pin by value PI_ON
             display "Input pin is LOW" CR
           else
      *>     Turns off LED.
             call 'gpioWrite'   using by value led-pin by value PI_OFF
             display "Input pin is HIGH" CR
           end-if
      *>   Check if a key was pressed.
      *>   It is noted that fn_getch() is a wrapper function
      *>   for getch(). (getch itself is provided by ncurses.)
           call 'fn_getch' using
             by value TIMEOUT_MILLIS returning inkey
           end-call
         end-perform

      *> Terminates the library. Calling this function is necessary
      *> to release memory and to terminate any running threads
      *> before program exit.
         call 'gpioTerminate'

       else

      *> -1 (PI_INIT_FAILED) is returned if initialisation failed.
      *> It is noted that the GPIO interface requires root
      *> privilege for access. Remeber to 'sudo readsw'
      *> for running this program.
         display "pigpio initialisation failed." CR
       end-if 
       display "with return code: " edited-result CR
       display "Press ENTER to quit."

      *> contents of the sceen will be lost without this.
       accept dummy
       goback.
       end program readsw. 
