# frozen_string_literal: true

class Grid
  attr_reader :data, :height, :width, :height_offset, :width_offset

  def initialize(radar_data, pattern)
    @data = radar_data
    @height = radar_data.length
    @width = radar_data.first.length
    @width_offset = pattern.width / 2
    @height_offset = pattern.height / 2
  end

  def offset
    horizontal_padding = generate_horizontal_padding
    padded_grid = add_horizontal_padding(horizontal_padding)

    update_grid_dimensions(padded_grid)

    vertical_padding = generate_vertical_padding
    padded_grid = add_vertical_padding(vertical_padding, padded_grid)

    update_grid_dimensions(padded_grid)
  end

  private

  def generate_horizontal_padding
    Array.new(@width_offset, '-').join('')
  end

  def add_horizontal_padding(horizontal_padding)
    @data.map { |line| horizontal_padding + line + horizontal_padding }
  end

  def generate_vertical_padding
    line = Array.new(@width, '-').join('')

    Array.new(@height_offset, line)
  end

  def add_vertical_padding(vertical_padding, grid)
    vertical_padding + grid + vertical_padding
  end

  def update_grid_dimensions(padded_grid)
    @data = padded_grid
    @width = @data.first.length
    @height = @data.length
  end
end
