require_relative '../lib/autorun'

# Exercise 2

# The next exercise is to find and destroy stationary targets. This exercise will spawn a series
# of stationary dummy tanks, your tank should be able to find and destroy them as quickly as
# possible. This is a good way to learn how to balance shot power against target range.

include RTanque::Bot::BrainHelper

RTanque.match do
  6.times { load_tank 'bots/dummy' }

  add_tank 'Targeting' do
    command.radar_heading = sensors.radar_heading + RTanque::Heading::ONE_DEGREE
  end
end
