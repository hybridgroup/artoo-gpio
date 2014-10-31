require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
require 'artoo/drivers/relay'

describe Artoo::Drivers::Relay do
  before do
    @device = mock('device')
    @pin = 7
    @device.stubs(:pin).returns(@pin)
    @relay = Artoo::Drivers::Relay.new(:parent => @device)
    @connection = mock('connection')
    @device.stubs(:connection).returns(@connection)
  end

  describe 'state switching' do
    describe '#on' do
      it 'must turn the relay on' do
        @connection.expects(:digital_write).with(@pin, :high)
        @relay.on
      end
    end

    describe '#off' do
      it 'must turn the relay off' do
        @connection.expects(:digital_write).with(@pin, :low)
        @relay.off
      end
    end
  end

  describe 'state checking' do

    before do
      @relay.stubs(:change_state)
    end

    describe '#on?' do
      it 'must return true if relay is on' do
        @relay.on
        @relay.on?.must_equal true
      end

      it 'must return false if relay is off' do
        @relay.off
        @relay.on?.must_equal false
      end
    end

    describe '#off?' do
      it 'must return true if relay is off' do
        @relay.off
        @relay.off?.must_equal true
      end

      it 'must return false if relay is on' do
        @relay.on
        @relay.off?.must_equal false
      end
    end
  end

  describe '#toggle' do
    it 'must toggle the state of the relay' do
      @relay.stubs(:pin_state_on_board).returns(false)
      @connection.stubs(:set_pin_mode)
      @connection.stubs(:digital_write)
      @relay.off?.must_equal true
      @relay.toggle
      @relay.on?.must_equal true
      @relay.toggle
      @relay.off?.must_equal true
    end
  end

  describe '#commands' do
    it 'must contain all the necessary commands' do
      @relay.commands.must_include :on
      @relay.commands.must_include :off
      @relay.commands.must_include :toggle
      @relay.commands.must_include :on?
      @relay.commands.must_include :off?
      @relay.commands.must_include :invert
    end
  end
end
