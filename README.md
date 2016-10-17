# Introducing the Morsecode_keypad gem

    require 'morsecode_keypad'

    mk = MorsecodeKeypad.new(dash: 4, dot: 17, separator: 27, sendx: 22, notifier: nil)
    mk.start

The above code outputs an interpretation of morse code using 4 buttons (dash, dot, separator, and send) on a keypad.

Output:

<pre>
dot: 2016-10-17 17:19:01 +0000
dot: 2016-10-17 17:19:01 +0000
dot: 2016-10-17 17:19:02 +0000
dot: 2016-10-17 17:19:02 +0000
separator: 2016-10-17 17:19:02 +0000
dot: 2016-10-17 17:19:04 +0000
separator: 2016-10-17 17:19:05 +0000
dot: 2016-10-17 17:19:05 +0000
dash: 2016-10-17 17:19:05 +0000
dot: 2016-10-17 17:19:06 +0000
dot: 2016-10-17 17:19:07 +0000
separator: 2016-10-17 17:19:07 +0000
dot: 2016-10-17 17:19:08 +0000
dash: 2016-10-17 17:19:09 +0000
dot: 2016-10-17 17:19:09 +0000
dot: 2016-10-17 17:19:09 +0000
separator: 2016-10-17 17:19:10 +0000
dash: 2016-10-17 17:19:10 +0000
dash: 2016-10-17 17:19:11 +0000
dash: 2016-10-17 17:19:11 +0000
send: 2016-10-17 17:19:12 +0000
222241242122421224111
</pre>

## Transforming morse code into a string

    require 'morsecode'
    require 'morsecode_keypad'

    class Notifier

      def update(mc)
        puts MorseCode.new(mc).to_s
      end
    end

    mk = MorsecodeKeypad.new(dash: 4, dot: 17, separator: 27, sendx: 22, \
      notifier: Notifier.new)
    mk.start

## Test

### Input

Pressed the following buttons:

<pre>
dot dot dot dot separator
dot separator
dot dash dot dot separator
dot dash dot dot separator
dash dash dash
send
</pre>

### Observed

<pre>hello</pre>


## Resources

* morsecode_keypad https://rubygems.org/gems/morsecode_keypad
* Morse code https://en.wikipedia.org/wiki/Morse_code


morsecode rpi raspberrypi
