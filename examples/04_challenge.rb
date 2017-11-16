require_relative '../lib/autorun'

# Exercise 4

# Finally a real challenge, pit your tank against the Seek & Destroy example tank that executes a
# simple target acquisition algorithm.

RTanque.match do
  load_tank 'bots/seek_and_destroy'

  class Challenger < RTanque::Bot::Brain
    include RTanque::Bot::BrainHelper

    NAME = 'Challenger'

    def tick!
      set_random_heading if sensors.ticks % 90 == 0 || sensors.ticks == 1

      command.speed = rand(0.5..3.0)
      command.heading = @heading
      command.turret_heading = @heading
      command.radar_heading = @heading
    end

    def set_random_heading
      @heading = RTanque::Heading.rand
    end
  end
end
