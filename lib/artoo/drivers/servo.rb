require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # Servo behaviors for Firmata
    class Servo < Driver
      COMMANDS = [:move, :min, :center, :max, :current_angle].freeze

      attr_reader :current_angle

      # Create new Servo with angle=30
      def initialize(params={})
        super

        @current_angle = 30
      end

      # Moves to specified angle
      # @param [Integer] angle must be between 30-150
      def move(angle)
        raise "Servo angle must be an integer between 30-150" unless (angle.is_a?(Numeric) && angle >= 30 && angle <= 150)

        @current_angle = angle
        connection.servo_write(pin, angle_to_span(angle))
      end

      # Moves to min position
      def min
        move(30)
      end

      # Moves to center position
      def center
        move(90)
      end

      # Moves to max position
      def max
        move(150)
      end

      # converts an angle to a span between 0-255
      # @param [Integer] angle
      def angle_to_span(angle)
        (angle * 255 / 180).to_i
      end
    end
  end
end
