# frozen_string_literal: true

require 'grid'
require 'image'

describe Grid do
  let(:radar_data) { %w[oooo oooo oooo oooo] }
  let(:pattern) { Image.new(width: 2, height: 2) }
  subject { Grid.new(radar_data, pattern) }

  it { is_expected.to have_attributes(data: radar_data, width: 4, height: 4, width_offset: 1, height_offset: 1) }

  describe '.offset' do
    let(:padded_grid) do
      [
        '------',
        '-oooo-',
        '-oooo-',
        '-oooo-',
        '-oooo-',
        '------'
      ]
    end

    it 'adds horizontal and vertical padding correctly' do
      subject.offset

      expect(subject.data).to eq(padded_grid)
      expect(subject.width).to eq(6)
      expect(subject.height).to eq(6)
    end
  end
end
