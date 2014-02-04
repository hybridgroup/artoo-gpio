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
end
