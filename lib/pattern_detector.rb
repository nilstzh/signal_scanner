# frozen_string_literal: true

require_relative 'grid'

class PatternDetector
  PRECISION_THRESHOLD = 0.75

  def initialize(radar_data)
    @radar_data = radar_data
  end

  def run(pattern)
    grid = Grid.new(@radar_data, pattern)
    grid.offset

    detections = []

    (0..(grid.height - pattern.height)).each do |y|
      (0..(grid.width - pattern.width)).each do |x|
        result = match_pattern_at(x, y, pattern, grid)
        next unless result

        image, precision = result
        detections << {
          location: [x - grid.width_offset, y - grid.height_offset],
          image:,
          precision: precision.round(3)
        }
      end
    end

    detections
  end

  private

  def match_pattern_at(start_x, start_y, pattern, grid)
    precision = 1.0
    matched_grid = []

    pattern.shape.each_with_index do |pattern_row, row_offset|
      grid_row = grid.data[start_y + row_offset]
      grid_fragment = grid_row[start_x, pattern.width]

      mismatches = count_mismatches(pattern_row, grid_fragment)
      precision -= mismatches.to_f / (pattern.width * pattern.height)

      return nil if precision < PRECISION_THRESHOLD

      matched_grid << grid_fragment
    end

    [matched_grid, precision]
  end

  def count_mismatches(pattern_row, grid_fragment)
    pattern_row.chars.zip(grid_fragment.chars).count { |pattern_char, grid_char| pattern_char != grid_char }
  end
end
