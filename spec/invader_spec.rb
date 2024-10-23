# frozen_string_literal: true

require 'invader'

describe Invader do
  let(:name) { 'Test Name' }
  let(:pattern) { ['-oo-', 'o--o', '----'] }

  subject { Invader.new(name, pattern) }

  it 'has name' do
    expect(subject.name).to eq(name)
  end

  it 'has image' do
    expect(subject.image).to be_a(Image)
    expect(subject.image).to have_attributes(shape: pattern, width: 4, height: 3)
  end
end
