      *> Author: JA1UMI
      *> Date started: April  4, 2017
      *> Date updated: April 13, 2017
      *>
      *> Blinks the LED (which is connected to GPIO number 17)
      *> for one second at 1 second interval 10 times
      *> by using pigpio library, which is installed by
      *> default (since Raspbian jessie?).
      *>
      *> How to build this program:
      *>   cobc -x blinkLED.cob -lpthread -lrt -lpigpio
      *>
       identification division.
       program-id. blinkLED.

       data division.
       working-storage section.

      *> pigpio/raspberry pi-specific constants
       01 GPIO_17          constant as 17.
       01 PI_OUTPUT        constant as 1.
       01 PI_ON            constant as 1.
       01 PI_OFF           constant as 0.
       01 PI_TIME_RELATIVE constant as 0.

      *> variables used for general housekeeping
       01 led-pin        pic 99   value GPIO_17.
       01 secs           pic 99   value 1.
       01 micros         pic  9   value 0.
       01 result         usage binary-long signed.
       01 edited-result  pic -Z9.

       procedure division.
      *> An integer value (return code by calling pigpio functions
      *> (e.g. gpioVersion() and gpioInitialise() function) can be
      *> returned via the RETURNING clause.
       call 'gpioVersion'     returning result
       move result to edited-result
       display "Found pigpio version #" edited-result " installed."

      *> Initialises the library. This is must before using the
      *> other library functnions with some exceptions
      *> such as gpioVersion(). 
       call 'gpioInitialise'  returning result
      *> the pigpio version number (>=0) is returned
      *> if "everything is 'Bon'".
       move result to edited-result

       if result is greater than or equal to zero then
         display "pigpio initialisation succeeded."

      *> Sets the GPIO mode for the specified Broadcom-numbered
      *> GPIO pin. 
      *> GPIO mode is typically 0 (PI_INPUT) for input or
      *> 1 (PI_OUTPUT) for output.
         call 'gpioSetMode' using by value led-pin by value PI_OUTPUT

         perform 10 times
      *>   Sets the GPIO level for the specified Broadcom-numbered
      *>   GPIO pin.
      *>   Level is 0 (PI_OFF) for logical low-level or
      *>   1 (PI_ON) for logical high-level.
      *>
      *>   Turns on LED, in this case.
           call 'gpioWrite'   using by value led-pin by value PI_ON

      *>   Waits for specified number of seconds by caling
      *>   gpioSleep() function provided by pigpio library.

      *>   Waits for 1 second and 0 microsecs, in this case.
           call 'gpioSleep'   using
                              by value PI_TIME_RELATIVE
                              by value secs
                              by value micros
           end-call

      *>   Turns off LED and waits for 1 seconds and 0 microsecs.
           call 'gpioWrite'   using by value led-pin by value PI_OFF

      *>   Waits for 1 second.
      *>   OpenCOBOL also has a built-in sleep subroutine
           call 'C$SLEEP'     using secs
         end-perform

      *> Terminates the library. Calling this function is necessary
      *> to release memory and to terminate any running threads
      *> before program exit.
         call 'gpioTerminate'

       else

      *> -1 (PI_INIT_FAILED) is returned if initialisation failed.
      *> It is noted that the GPIO interface requires root
      *> privilege for access. Remeber to 'sudo blinkLED'
      *> for running this program.
         display "pigpio initialisation failed."
       end-if 
       display "with return code: " edited-result

       goback.
       end program blinkLED. 
