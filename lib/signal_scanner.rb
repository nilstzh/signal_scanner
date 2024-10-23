# frozen_string_literal: true

require_relative 'invaders_registry'
require_relative 'located_invader'
require_relative 'pattern_detector'
require_relative 'reporter'

class SignalScanner
  def initialize(radar_data, registry_file = 'data/invaders.yml')
    @radar_data = radar_data.strip.split("\n")
    @registry_file = registry_file
  end

  def run
    invader_detections = detect_invaders
    print_report(invader_detections)
  end

  private

  def detect_invaders
    invaders.flat_map do |invader|
      detected_patterns = pattern_detector.run(invader.image)

      detected_patterns.map do |detection|
        LocatedInvader.new(
          invader.name,
          detection[:image],
          detection[:location],
          detection[:precision]
        )
      end
    end
  end

  def invaders
    InvadersRegistry.new(@registry_file).all
  end

  def pattern_detector
    PatternDetector.new(@radar_data)
  end

  def print_report(results)
    Reporter.new(results).print
  end
end
