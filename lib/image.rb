# frozen_string_literal: true

class Image
  attr_reader :shape, :height, :width

  def initialize(pattern)
    @shape = pattern
    @height = pattern.length
    @width = pattern.first.length
  end
end
