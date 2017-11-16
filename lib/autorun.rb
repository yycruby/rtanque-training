require 'bundler/setup'
require 'rtanque'

module RTanque
  def self.match(&block)
    if $0.end_with?('bin/rtanque')
      Builder.new(block)
    else
      Runner.new(block)
    end
  end

  class Builder
    def initialize(block)
      instance_exec(&block)
    end

    def add_tank(name, count: 1, include: [Helpers], &block)
      klass = Class.new(RTanque::Bot::Brain) {
        self.include RTanque::Bot::BrainHelper
        self.include *Array(include)

        const_set(:NAME, name)
        define_method(:tick!, &block)
      }.tap { |klass|
        puts klass.ancestors
        Object.const_set(name, klass)
      }
    end

    def load_tank(path, count: 1)
      puts "load tank: #{path}"
    end
  end

  class Runner
    def initialize(block)
      @paths = [$0]
      instance_exec(&block)

      exec "bundle exec rtanque start -- #{@paths.join(' ')}"
    end

    def add_tank(name, count: 1, **)
      # no-op
    end

    def load_tank(path, count: 1)
      @paths << "#{path}.rb"
    end
  end

  module Helpers
    def point(x, y)
      RTanque::Point.new(x, y, arena)
    end

    def heading_delta(point)
      RTanque::Heading.delta_between_points(sensors.position, sensors.heading, point)
    end
  end
end
