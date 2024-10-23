# frozen_string_literal: true

class Reporter
  def initialize(results)
    @results = results.sort_by { |result| -result.precision }
  end

  def print
    return print_empty_report if @results.empty?

    print_header
    print_detected_invaders
  end

  private

  def print_empty_report
    puts 'Keep calm. No invaders detected.'
  end

  def print_header
    puts '----------------------------'
    puts 'ATTENTION! AHTUNG! ADVARSEL!'
    puts 'Possible invader(s) detected.'
    puts "\n"
  end

  def print_detected_invaders
    @results.each do |result|
      print_details(result)
    end
  end

  def print_details(result)
    puts '----------------------------'
    puts "Detected Threat: #{result.name}"
    puts "Detected Image:\n#{result.image.shape.join("\n")}"
    puts "Precision: #{format('%.3f', result.precision)}"
    puts "Coordinates: #{format_coordinates(result.location)}"
    puts "\n"
  end

  def format_coordinates(location)
    "X: #{location[0]}, Y: #{location[1]}"
  end
end
