require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # The Relay driver behaviors
    class Relay < Driver

      COMMANDS = [:on, :off, :toggle,
                  :on?, :off?, :invert, :status].freeze

      def initialize(params = {})
        @is_on = false
        aditional_params = params[:aditional_params] || {}
        @is_inverted = aditional_params[:invert] || false
        super
      end

      # @return [Boolean] True if on
      def on?
        @is_on
      end

      # @return [Boolean] True if off
      def off?
        (not on?)
      end

      # Sets relay to on
      def on
        change_state(pin, state(:high))
        @is_on = true
        true
      end

      # Sets relay to off
      def off
        change_state(pin, state(:low))
        @is_on = false
        true
      end

      # Toggle status
      # @example on > off, off > on
      def toggle
        on? ? off : on
      end
      
      # @return relay's state
      def status
        read_state(pin)
      end

      private
      def change_state(pin, level)
        connection.digital_write(pin, level)
      end
      
      def read_state(pin)
        connection.digital_read(pin)
      end
      
      def state(value)
        if @is_inverted
          [:low, :high].reject{|e| e == value}.first
        else
          value
        end
      end
      
    end
  end
end
