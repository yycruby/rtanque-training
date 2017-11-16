# YYC Ruby RTanque

This repo is to help you learn how to program an RTanque brain. We'll start with a few exercises
to familiarize you with the various tools and techniques that exist, after you can test your
brain against a series of increasingly challenging bots to hone your strategy.


## Getting Started

First clone the repository:

```
$ git clone https://github.com/yycruby/rtanque-training
$ cd rtanque-training
$ bundle install
```

*A note about Ruby versions*

The fork of RTanque we are using has been updated to work with current versions of Ruby, but
there is a bug somewhere in Gosu that breaks `bundler/setup` in Ruby 2.4.2. You can still run
RTanque with the executable it provides, but if you want to use the helpers for the exercises
you will need to install **Ruby 2.3.5**.

If you are on a Mac you can install dependencies with homebrew:

```
$ brew install sdl2 sdl_image sdl_mixer sdl_ttf
```

You can also use the getting started docs for Gosu:
https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux

Lastly, if all else fails, you can try using the `Vagrantfile`.


## Autorun helper

This repo includes a small Ruby library you can `require` in a Ruby script that makes it easier
to experiment with various tank designs with a simple `RTanque.match` method and helpers for
loading and building tanks.

```ruby
require_relative '../lib/autorun'

RTanque.match do
  # You can define modules to mix into any tanks
  module MyHelpers
    def shoot!
      command.fire(1.0)
    end
  end

  # Load other tanks from the bots directory
  load_tank 'bots/dummy'
  load_tank 'bots/seek_and_destroy'

  # Define a simple tank brain and tick! method
  add_tank 'TankA', include: [MyHelpers] do
    command.turret_heading = sensors.heading + 5.0
    command.heading = sensors.heading + 1.5
    command.speed = 0.5
    shoot!
  end

  # Define a tank brain as a class
  class TankB < RTanque::Bot::Brain
    include RTanque::Bot::BrainHelper
    NAME = "TankB"

    def tick!
      command.turret_heading = sensors.heading + 5.0
      command.heading = sensors.heading + 1.5
      command.speed = 3.0
    end
  end
end
```

This file can then be run as a regular Ruby script `ruby my_tank.rb`

*A note on the `add_tank` method*

The `add_tank` method dynamically generates a tank brain subclass and `tick!` method that
executes the passed block. This is handy for spinning up simple experiments, but doesn't scale
very well. More complex tank behaviour is better modeled as a class.

Unfortunately constants from the included `RTanque::Bot::BrainHelper` do not properly reference.
There are two workarounds for this, you can `include RTanque::Bot::BrainHelper` at the top of
your Ruby script; or you can access them through the class, for `MAX_BOT_SPEED` you would use
`self.class::MAX_BOT_SPEED`.


## Training Exercises

You can use these exercises to build up an understanding of tank brain programming or you can
jump right into the deep end and start programming a tank.

### Exercise 1

The first exercise is simple, get your tank to driving around the arena. You should be able to
implement `tick!` so that the tank picks a random point and drives toward it. Picking a random
heading every few seconds is easy enough, but it's trickier to detect when the tank has hit a wall
or arrived at a specific point in the arena.

### Exercise 2

The next exercise is to find and destroy stationary targets. This exercise will spawn a series
of stationary dummy tanks, your tank should be able to find and destroy them as quickly as
possible. This is a good way to learn how to balance shot power against target range.

### Exercise 3

This time the dummy tanks are moving around, so your tank will need to follow behind them or
track them from a distance and land shots.

### Exercise 4

Finally a real challenge, pit your tank against the Seek & Destroy example tank that executes a
simple target acquisition algorithm.


## Competing with others

Once you're comfortable writing a tank brain, you can upload it to GitHub as a gist, either with
the command line tool or by visiting https://gist.github.com. Then paste the link into the
`#rtanque` channel in Slack.
