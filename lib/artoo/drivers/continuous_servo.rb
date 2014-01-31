require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # ContinuousServo behaviors for Firmata
    class ContinuousServo < Driver
      COMMANDS = [:clockwise, :counterClockwise, :stop].freeze

      attr_reader :current_angle

      # Create new ContinuousServo with angle=0
      def initialize(params={})
        super

        @current_angle = 0
      end

      # Moves to specified angle
      # @param [Integer] angle must be between 0-180
      def move(angle)
        raise "Servo angle must be an integer between 0-180" unless (angle.is_a?(Numeric) && angle >= 0 && angle <= 180)

        @current_angle = angle
        connection.servo_write(pin, angle_to_span(angle))
      end

      # Stops the driver
      def stop
        move(90)
      end

      # Turns the servo clockwise, if the driver is continuous
      def clockwise
        move(180)
      end

      # Turns the servo counter clockwise, if the driver is continuous
      def couterClockwise
        move(89)
      end

      # converts an angle to a span between 0-255
      # @param [Integer] angle
      def angle_to_span(angle)
        (angle * 255 / 180).to_i
      end
    end
  end
end
