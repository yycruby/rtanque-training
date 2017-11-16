require_relative '../lib/autorun'

# Exercise 3

# This time the dummy tanks are moving around, so your tank will need to follow behind them or
# track them from a distance and land shots.

include RTanque::Bot::BrainHelper

RTanque.match do
  6.times { load_tank 'bots/wanderer' }

  add_tank 'Targeting' do
    command.radar_heading = sensors.radar_heading + RTanque::Heading::ONE_DEGREE
  end
end
