# frozen_string_literal: true

require 'invaders_registry'
require 'invader'

describe InvadersRegistry do
  let(:invaders_registry) { InvadersRegistry.new('spec/fixtures/invaders.yml') }

  describe '.all' do
    subject { invaders_registry.all }

    it 'returns list of all invaders' do
      expect(subject.count).to eq(2)
      expect(subject).to all(be_an(Invader))
    end
  end

  describe '.find_by_name' do
    context 'when name exists' do
      subject { invaders_registry.find_by_name('invader_a') }

      it 'returns Invader' do
        expect(subject).to be_an(Invader)
      end
    end

    context 'when name exists' do
      subject { invaders_registry.find_by_name('not_a_name') }

      it 'returns nil' do
        expect(subject).to be(nil)
      end
    end
  end
end
