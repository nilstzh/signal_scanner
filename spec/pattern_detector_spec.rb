# frozen_string_literal: true

require 'pattern_detector'
require 'image'

describe PatternDetector do
  let(:pattern) { Image.new(%w[oo oo]) }

  describe '.run' do
    subject { pattern_detector.run(pattern) }

    context 'when there are no matches' do
      let(:radar_data) { ['------', '------'] }
      let(:pattern_detector) { PatternDetector.new(radar_data) }

      it { is_expected.to be_empty }
    end

    context 'precise matches' do
      context 'when there is a single match' do
        let(:radar_data) { ['--oo--', '--oo--'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) { [{ location: [2, 0], image: %w[oo oo], precision: 1.0 }] }

        it 'returns a single result' do
          expect(subject.size).to eq(1)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple matches' do
        let(:radar_data) { ['oo--oo', 'oo--oo'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [0, 0], image: %w[oo oo], precision: 1.0 },
            { location: [4, 0], image: %w[oo oo], precision: 1.0 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple overlapping matches' do
        let(:radar_data) { ['-ooo-', '-ooo-'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [1, 0], image: %w[oo oo], precision: 1.0 },
            { location: [2, 0], image: %w[oo oo], precision: 1.0 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end
    end

    context 'approximate matches' do
      context 'when there is a single match' do
        let(:radar_data) { ['--oo--', '--o---'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) { [{ location: [2, 0], image: %w[oo o-], precision: 0.75 }] }

        it 'returns a single result' do
          expect(subject.size).to eq(1)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple matches' do
        let(:radar_data) { ['oo---o', 'o---oo'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [0, 0], image: %w[oo o-], precision: 0.75 },
            { location: [4, 0], image: %w[-o oo], precision: 0.75 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple overlapping matches' do
        let(:radar_data) { ['-ooo-', '-o-o-'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [1, 0], image: %w[oo o-], precision: 0.75 },
            { location: [2, 0], image: %w[oo -o], precision: 0.75 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end
    end

    context 'mixed matches' do
      context 'when there are multiple matches' do
        let(:radar_data) { ['oo---o', 'oo--oo'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [0, 0], image: %w[oo oo], precision: 1 },
            { location: [4, 0], image: %w[-o oo], precision: 0.75 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple overlapping matches' do
        let(:radar_data) { ['-ooo-', '-oo--'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { location: [1, 0], image: %w[oo oo], precision: 1.0 },
            { location: [2, 0], image: %w[oo o-], precision: 0.75 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end
    end

    context 'edge matches' do
      let(:pattern) { Image.new(%w[o-o -o-]) }

      context 'when there is a single match' do
        let(:radar_data) { ['-o----', 'o-----'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) { [{ image: ['--o', '-o-'], location: [-1, 0], precision: 0.833 }] }

        it 'returns a single result' do
          expect(subject.size).to eq(1)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple matches' do
        let(:radar_data) { ['-o--o-', 'o----o'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { image: ['--o', '-o-'], location: [-1, 0], precision: 0.833 },
            { image: ['o--', '-o-'], location: [4, 0], precision: 0.833 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(2)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end

      context 'when there are multiple overlapping matches' do
        let(:radar_data) { ['--o--', '-o-o-'] }
        let(:pattern_detector) { PatternDetector.new(radar_data) }
        let(:matches) do
          [
            { image: ['--o', '-o-'], location: [0, 0], precision: 0.833 },
            { image: ['o--', '-o-'], location: [2, 0], precision: 0.833 },
            { image: ['o-o', '---'], location: [1, 1], precision: 0.833 }
          ]
        end

        it 'returns all results' do
          expect(subject.size).to eq(3)
        end

        it 'includes all matches' do
          matches.each do |match|
            expect(subject).to include(match)
          end
        end
      end
    end
  end
end
