require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # Servo behaviors for Firmata
    class Servo < Driver
      COMMANDS = [:move, :min, :center, :max, :current_angle].freeze

      attr_reader :current_angle, :angle_range

      # Create new Servo with angle=0
      def initialize(params={})
        super

        @current_angle = 0
        @angle_range = params[:range].nil? ? Range.new(30,150) : Range.new(params[:range][:min],params[:range][:max])
      end

      # Moves to specified angle
      # @param [Integer] angle must be between 0-180
      def move(angle)
        raise "Servo angle must be an integer between 0-180" unless (angle.is_a?(Numeric) && angle >= 0 && angle <= 180)

        safety_angle = safe_angle(angle)
        @current_angle = safety_angle
        connection.servo_write(pin, angle_to_span(safety_angle))
      end

      # Moves to min position
      def min
        move(0)
      end

      # Moves to center position
      def center
        move(90)
      end

      # Moves to max position
      def max
        move(180)
      end

      # converts an angle to a span between 0-255
      # @param [Integer] angle
      def angle_to_span(angle)
        (angle * 255 / 180).to_i
      end

      private
      
      # contains angle to safe values
      # @param [Integer] angle
      def safe_angle(angle)
        if angle < @angle_range.min
          @angle_range.min
        elsif angle > @angle_range.max
          @angle_range.max
        else
          angle
        end
      end
    end
  end
end
