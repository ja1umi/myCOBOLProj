      *> Author: JA1UMI
      *> Date started: May 6, 2017
      *> Date updated: May 8, 2017
      *>
      *> Reads current temperature from the Sparkfun TMP102 
      *> digital temperature sensor conneted to the Raspberry Pi
      *> via I2C.
      *>
      *> How to build this program:
      *>   cobc -x tmp102.cob -lpthread -lrt -lpigpio
      *>
       identification division.
       program-id. tmp102.

       data division.
       working-storage section.

      *> pigpio/raspberry pi-specific constants
       01 SMBUS            constant as 1.
       01 I2CFLAGS         constant as 0.

      *> TMP102-specific constants
       01 ADDR_TMP102      constant as h"48".
       01 REG_TEMP         constant as 0.
      *>  set timeout to 100 milli seconds.
       01 SECS             constant as 2.

      *> variables used for general housekeeping
       01 hdlTMP102      usage binary-long signed.
       01 raw-reading    usage binary-long signed.
       01 hi-byte        usage binary-long signed.
       01 lo-byte        usage binary-long signed.
       01 result         usage binary-long signed.
       01 edited-reading pic -ZZZ9.999.
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
         call 'i2cOpen' using
           by value SMBUS by value ADDR_TMP102 by value I2CFLAGS
           returning hdlTMP102
         end-call

         perform 10 times
           call 'i2cReadWordData' using
             by value hdlTMP102 by value REG_TEMP
             returning raw-reading
           end-call
      
      *>   Byte #1 of Temperature register (register #0) holds upper
      *>   8 bits of the temperature data (T11 to T4) and 
      *>   Byte #2 of Temperature register holds lower 4 bits 
      *>   of the temperature data (T3 to T0).
      *>
      *>    b7  b6  b5  b4  b3  b2  b1  b0
      *>   +---+---+---+---+---+---+---+---+
      *>   |T11|T10|T9 |T8 |T7 |T6 |T5 |T4 |  Byte #1
      *>   +---+---+---+---+---+---+---+---+ 
      *>
      *>    b7  b6  b5  b4  b3  b2  b1  b0
      *>   +---+---+---+---+---+---+---+---+
      *>   |T3 |T2 |T1 |T0 | 0 | 0 | 0 | 0 |  Byte #2
      *>   +---+---+---+---+---+---+---+---+ 
      *>
      *>   Byte #1 is in the least significant (lower) byte of
      *>   variable raw-reading.
      *>   Byte #2 is in the most siginificant (higher) byte of
      *>   variable raw-reading.
      *>
      *>        raw-reading
      *>   |<--     word    -->|
      *>    MS Byte   LS Byte
      *>   +---------+---------+
      *>   | Byte #2 | Byte #1 |
      *>   +---------+---------+
      *>    higher    lower
      *>
           compute hi-byte = function integer-part(raw-reading / h"100")
           compute lo-byte = function rem(raw-reading, h"100")
           compute lo-byte = lo-byte * 16
           compute hi-byte = function integer-part(hi-byte / 16)
           compute edited-reading = (lo-byte + hi-byte) / 16
           display "temperature = " edited-reading " degree C"

      *>   avoid too frequent measurements       
           call "C$SLEEP" using SECS
         end-perform
         call 'i2cClose' using by value hdlTMP102
         call 'gpioTerminate'

       else

      *> -1 (PI_INIT_FAILED) is returned if initialisation failed.
      *> It is noted that the GPIO interface requires root
      *> privilege for access. Remeber to 'sudo readsw'
      *> for running this program.
         display "pigpio initialisation failed."
       end-if 
       display "with return code: " edited-result

       goback.
       end program tmp102. 
