require_relative '../lib/autorun'

# Exercise 1

# The first exercise is simple, get your tank to driving around the arena. You should be able to
# implement `tick!` so that the tank picks a random point and drives toward it. Picking a random
# heading every few seconds is easy enough, but it's trickier to detect when the tank has hit a
# wall or arrived at a specific point in the arena.

include RTanque::Bot::BrainHelper

RTanque.match do
  # This dummy is just to keep the match from ending when there is only one tank remaining.
  load_tank 'bots/dummy'

  add_tank 'Movement' do
    command.heading = @target_heading ||= RTanque::Heading.rand
    command.speed = MAX_BOT_SPEED
  end
end
