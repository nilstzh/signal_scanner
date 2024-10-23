# frozen_string_literal: true

require_relative 'invader'

class LocatedInvader < Invader
  attr_reader :location, :precision

  def initialize(name, pattern, location, precision)
    super(name, pattern)
    @location = location
    @precision = precision
  end
end
