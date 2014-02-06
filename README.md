# Artoo Drivers For GPIO Devices

This repository contains the Artoo (http://artoo.io/) standard drivers for analog, digital, PWM, and servo devices.

Artoo is a open source micro-framework for robotics using Ruby.

For more information abut Artoo, check out our repo at https://github.com/hybridgroup/artoo

[![Code Climate](https://codeclimate.com/github/hybridgroup/artoo-gpio.png)](https://codeclimate.com/github/hybridgroup/artoo-gpio) [![Build Status](https://travis-ci.org/hybridgroup/artoo-gpio.png?branch=master)](https://travis-ci.org/hybridgroup/artoo-gpio)

## Installing

```
gem install artoo-gpio
```

## Using

Normally, this gem is automatically included as part of using an Artoo adaptor that can connect to your hardware. For example, artoo-arduino and artoo-digispark both make use of the drivers in this gem. 

Here is the "led" driver being used in an Arduino:

```ruby
require 'artoo'

connection :arduino, :adaptor => :firmata, :port => '127.0.0.1:8023'
device :led, :driver => :led, :pin => 13

work do
  every 1.second do
    led.toggle
  end
end
```

Here is the same "led" driver being used by a Digispark.

```ruby
require 'artoo'

connection :digispark, :adaptor => :littlewire, :vendor => 0x1781, :product => 0x0c9f
device :led, :driver => :led, :pin => 1

work do
  every 1.second do
    led.toggle
  end
end
```

## Devices supported

The following GPIO hardware devices have Artoo driver support:
- Analog sensor
- Button
- Continuous Servo
- LED
- MakeyButton (high-resistance switch influenced by the MakeyMakey ([http://makeymakey.com](http://makeymakey.com)))
- Maxbotix ultrasonic range finder
- Motor (DC)
- Servo

## Contributing

* All patches must be provided under the Apache 2.0 License
* Please use the -s option in git to "sign off" that the commit is your work and you are providing it under the Apache 2.0 License
* Submit a Github Pull Request to the appropriate branch and ideally discuss the changes with us in IRC.
* We will look at the patch, test it out, and give you feedback.
* Avoid doing minor whitespace changes, renamings, etc. along with merged content. These will be done by the maintainers from time to time but they can complicate merges and should be done seperately.
* Take care to maintain the existing coding style.
* Add unit tests for any new or changed functionality.
* All pull requests should be "fast forward"
  * If there are commits after yours use “git rebase -i <new_head_branch>”
  * If you have local changes you may need to use “git stash”
  * For git help see [progit](http://git-scm.com/book) which is an awesome (and free) book on git


(c) 2012-2014 The Hybrid Group
