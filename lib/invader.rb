# frozen_string_literal: true

require_relative 'image'

class Invader
  attr_reader :name, :image

  def initialize(name, pattern)
    @name = name
    @image = Image.new(pattern)
  end
end
