require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # ContinuousServo behaviors for Firmata
    class ContinuousServo < Driver
      COMMANDS = [:clockwise, :counterClockwise, :stop].freeze

      # Create new ContinuousServo
      def initialize(params={})
        super
      end
      
      # Stops the driver
      def stop
        connection.servo_write(pin, 90)
      end

      # Turns the servo clockwise
      def clockwise
        connection.servo_write(pin, 180)
      end

      # Turns the servo counter clockwise
      def counterClockwise
        connection.servo_write(pin, 89)
      end
    end
  end
end
