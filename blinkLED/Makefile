LDFLAGS=-lpthread -lrt -lpigpio
.phony: all

all: blinkLED

blinkLED: blinkLED.cob
	cobc -x blinkLED.cob $(LDFLAGS)

.phony: clean
clean:
	rm -f blinkLED