require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # AnalogSensors driver behaviors
    class AnalogSensor < Driver
      COMMANDS = [:analog_read, :lower, :upper, :previous_read].freeze

      attr_reader :lower, :upper, :previous_read

      def analog_read(pin)
        connection.analog_read(pin)
      end

      def start_driver
        @previous_read = 0
        @upper = additional_params[:upper].nil? ? 1023 : additional_params[:upper]
        @lower = additional_params[:lower].nil? ? 0 : additional_params[:lower]

        every(interval) do
          new_value = connection.analog_read(pin)
          update(new_value) unless new_value.nil?
        end if !interval.nil? and interval > 0

        super
      end

      private
      # Publishes events according to the button feedback
      def update(new_val)
        @previous_read = new_val

        if new_val >= @upper
          publish(event_topic_name("update"), "upper", new_val)
          publish(event_topic_name("upper"), new_val)
        elsif new_val <= @lower
          publish(event_topic_name("update"), "lower", new_val)
          publish(event_topic_name("lower"), new_val)
        end
      end
    end
  end
end
