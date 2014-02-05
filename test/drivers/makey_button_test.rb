require File.expand_path(File.dirname(__FILE__) + "/../test_helper")
require 'artoo/drivers/makey_button'

describe Artoo::Drivers::MakeyButton do
  before do
    @device = mock('device')
    @pin = 0
    @device.stubs(:pin).returns(@pin)
    @makey = Artoo::Drivers::MakeyButton.new(:parent => @device)
    @connection = mock('connection')
    @device.stubs(:connection).returns(@connection)
  end

  describe 'MakeyButton#is_pressed?' do
    it 'should return true when pressed' do
      @makey.instance_variable_set(:@pressed_val, 1)
      @makey.is_pressed?.must_equal true
    end

    it 'should return false when not pressed' do
      @makey.instance_variable_set(:@pressed_val, 0)
      @makey.is_pressed?.must_equal false
    end
  end

  describe 'MakeyButton#average_data' do
    it 'returns 0 if no data' do
      @makey.instance_variable_set(:@data, [])
      @makey.send(:average_data).must_equal 0
    end

    it 'returns average if data present' do
      @makey.instance_variable_set(:@data, [1,2,3])
      @makey.send(:average_data).must_equal 2.0
    end
  end

  describe 'MakeyButton#update' do
    it 'publishes a push when pushed' do
      @makey.stubs(:average_data).returns(0.6)
      @makey.stubs(:is_pressed?).returns(false)
      @device.expects(:event_topic_name).with('update')
      @device.expects(:event_topic_name).with('push')
      @makey.send(:update)
    end

    it 'publishes a release when released' do
      @makey.stubs(:average_data).returns(0.4)
      @makey.stubs(:is_pressed?).returns(true)
      @device.expects(:event_topic_name).with('update')
      @device.expects(:event_topic_name).with('release')
      @makey.send(:update)
    end
  end
end
