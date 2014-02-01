require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
require 'artoo/drivers/continuous_servo'

describe Artoo::Drivers::ContinuousServo do
  before do
    @device = mock('device')
    @device.stubs(:pin).returns(3)
    @servo = Artoo::Drivers::ContinuousServo.new(:parent => @device)

    @connection = mock('connection')
    @device.stubs(:connection).returns(@connection)
  end

  describe 'ContinuousServo#stop' do
    it 'stops the driver' do
      @connection.expects(:servo_write).with(3, 90)
      @servo.stop
    end
  end

  describe 'ContinuousServo#clockwise' do
    it 'turns the servo clockwise' do
      @connection.expects(:servo_write).with(3, 180)
      @servo.clockwise
    end
  end

  describe 'ContinuousServo#counter_clockwise' do
    it 'turns the servo counter clockwise' do
      @connection.expects(:servo_write).with(3, 89)
      @servo.counter_clockwise
    end
  end
end
