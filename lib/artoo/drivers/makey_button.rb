require 'artoo/drivers/driver'

module Artoo
  module Drivers
    # MakeyButton driver behaviors
    class MakeyButton < Driver
      COMMANDS = [:is_pressed?].freeze

      DOWN = 1
      UP = 0

      attr_accessor :data

      def initialize(params={})
        super

        @data = []
      end

      # @return [Boolean] True if pressed
      def is_pressed?
        (@pressed_val == 1) ? true : false
      end

      def start_driver
        @pressed_val = 0

        every(100) do
          new_value = connection.digital_read(pin)
          puts new_value
          @data << new_value
          @data.shift
          update(new_value) if !new_value.nil? && new_value != is_pressed?
        end

        super
      end

      private
      # Publishes events according to the button feedback
      def update
        if average_data <= 0.5 and not is_pressed?
          @pressed_val = 1
          publish(event_topic_name("update"), "push", new_val)
          publish(event_topic_name("push"), new_val)
        elsif average_data > 0.5 and is_pressed?
          @pressed_val = 0
          publish(event_topic_name("update"), "release", new_val)
          publish(event_topic_name("release"), new_val)
        end
      end
      
      #Averages data received
      def average_data
        return 0 unless @data.any?
        @data.inject(:+) / @data.size.to_f
      end
    end
  end
end
