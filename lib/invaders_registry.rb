# frozen_string_literal: true

require 'yaml'
require_relative 'invader'

class InvadersRegistry
  def initialize(filepath)
    @filepath = filepath
  end

  def all
    invaders
  end

  def find_by_name(name)
    invaders.find { |invader| invader.name == name }
  end

  private

  def invaders
    @invaders ||= File.read(@filepath)
                      .then { |data| YAML.load(data) }
                      .then { |data| data.map { |name, pattern| Invader.new(name, pattern.split("\n")) } }
  end
end
