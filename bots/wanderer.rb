class Wanderer < RTanque::Bot::Brain
  include RTanque::Bot::BrainHelper

  NAME = 'Wanderer'

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
