#!/usr/bin/env ruby

# file: morsecode_keypad.rb

require 'rpi_pinin'


class MorsecodeKeypad

  DASH = '1'
  DOT = '2'
  SEPARATOR = '4'

  def initialize(dash: 4, dot: 17, separator: 27, sendx: 22, notifier: nil)

    @notifier = notifier
    @dash_pin, @dot_pin, @separator_pin, @send_pin = \
      [dash, dot, separator, sendx].map {|pin| RPiPinIn.new(pin, pull: :up)}
    @mc = ''
    
  end

  def start()

    Thread.new do
      @dash_pin.watch_high do |v|

        puts "dash: " +  Time.now.to_s if @notifier.nil?
        on_dash()

      end
    end

    Thread.new do
      @dot_pin.watch_high do |v|

        puts "dot: " +  Time.now.to_s if @notifier.nil?
        on_dot()

      end
    end

    Thread.new do
      @separator_pin.watch_high do |v|

        puts "separator: " +  Time.now.to_s if @notifier.nil?
        on_separator()

      end
    end

    @send_pin.watch_high do |v|

      puts "send: " +  Time.now.to_s if @notifier.nil?
      on_send()

    end


  end

  private

  def on_dash()
    @mc << DASH
  end

  def on_dot()
    @mc << DOT
  end

  def on_separator()
    @mc << SEPARATOR
  end

  def on_send()

    if @notifier then
      @notifier.update @mc 
    else
      puts @mc
    end

    @mc = ''

  end

end

