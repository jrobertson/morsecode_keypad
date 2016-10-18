#!/usr/bin/env ruby

# file: morsecode_keypad.rb

require 'rpi_pinin'


class MorsecodeKeypad

  DASH = '1'
  DOT = '2'
  SEPARATOR = '4'

  def initialize(dash: 4, dot: 17, separator: 27, sendx: 22, notifier: nil)

    @pins = {dash: dash, dot: dot, separator: separator, sendx: sendx}
    
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
  
  # test() returns the user-defined button to GPIO pin mappings given the 
  # user selects the buttons in sequence (dash, dot, separator, sendx)
  # e.g. => {:dash=>4, :dot=>22, :separator=>27, :sendx=>17}

  
  def test()
    
    pins = %i(dash dot separator sendx)
    buttons = {}
    i = 0

    Thread.new do 
      @dash_pin.watch_high do |v| 
        
        buttons[pins[i]] = @pins[:dash]
        puts pins[i].to_s + ": GPIO " +  buttons[pins[i]].to_s 
        i += 1
        
        puts buttons.inspect if i > 3
        Thread.stop
        
      end
    end
    
    Thread.new do 
      @dot_pin.watch_high do |v| 
        
        buttons[pins[i]] = @pins[:dot]
        puts pins[i].to_s + ": GPIO " +  buttons[pins[i]].to_s
        i += 1
        
        puts buttons.inspect if i > 3
        Thread.stop
        
      end
    end    
    
    Thread.new do 
      @separator_pin.watch_high do |v| 
        
        buttons[pins[i]] = @pins[:separator]
        puts pins[i].to_s + ": GPIO " +  buttons[pins[i]].to_s
        i += 1
        
        puts buttons.inspect if i > 3
        Thread.stop
        
      end
    end      
    
    Thread.new do 
      @send_pin.watch_high do |v| 
        
        buttons[pins[i]] = @pins[:sendx]
        puts pins[i].to_s + ": GPIO " +  buttons[pins[i]].to_s
        i += 1
        
        puts buttons.inspect if i > 3
        Thread.stop
        
      end
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
    @mc.sub!(/[^4]+444$/,'') if @mc =~ /444$/   # undo command?
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
