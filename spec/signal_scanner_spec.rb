# frozen_string_literal: true

require 'signal_scanner'

describe SignalScanner do
  describe '.run' do
    context 'when there are no matches' do
      subject { SignalScanner.new(empty_radar_data, 'spec/fixtures/invaders.yml') }

      let(:empty_radar_data) do
        <<~INPUT
          ----------
          ----------
          ----------
        INPUT
      end

      it 'prints empty report' do
        expect { subject.run }.to output("Keep calm. No invaders detected.\n").to_stdout
      end
    end

    context 'when there are matches' do
      let(:radar_data) do
        <<~INPUT
          ---oo-------------------------------
          --ooo---------------oo-o------oo----
          ----------------------o------oo-----
          ---------oo-o-------o--o------------
          -----------o-------ooo--------o-o---
          ---------oo-o------------------o----
          -----------------------------oo-o---
        INPUT
      end

      let(:report) do
        <<~OUTPUT
          ----------------------------
          ATTENTION! AHTUNG! ADVARSEL!
          Possible invader(s) detected.

          ----------------------------
          Detected Threat: invader_a
          Detected Image:
          -oo
          ooo
          Precision: 1.000
          Coordinates: X: 2, Y: 0

          ----------------------------
          Detected Threat: invader_b
          Detected Image:
          oo-o
          --o-
          oo-o
          Precision: 1.000
          Coordinates: X: 9, Y: 3

          ----------------------------
          Detected Threat: invader_b
          Detected Image:
          oo-o
          --o-
          o--o
          Precision: 0.917
          Coordinates: X: 20, Y: 1

          ----------------------------
          Detected Threat: invader_b
          Detected Image:
          -o-o
          --o-
          oo-o
          Precision: 0.917
          Coordinates: X: 29, Y: 4

          ----------------------------
          Detected Threat: invader_a
          Detected Image:
          -oo
          oo-
          Precision: 0.833
          Coordinates: X: 29, Y: 1

          ----------------------------
          Detected Threat: invader_a
          Detected Image:
          -o-
          ooo
          Precision: 0.833
          Coordinates: X: 19, Y: 3

        OUTPUT
      end

      subject { SignalScanner.new(radar_data, 'spec/fixtures/invaders.yml') }

      it 'prints report and returnes detected matches' do
        expect do
          results = subject.run

          expect(results.size).to eq(6)
          expect(results[0]).to have_attributes(name: 'invader_a', location: [2, 0], precision: 1.0)
          expect(results[0].image).to have_attributes(shape: ['-oo', 'ooo'])
          expect(results[1]).to have_attributes(name: 'invader_b', location: [9, 3], precision: 1.0)
          expect(results[1].image).to have_attributes(shape: ['oo-o', '--o-', 'oo-o'])
          expect(results[2]).to have_attributes(name: 'invader_b', location: [20, 1], precision: 0.917)
          expect(results[2].image).to have_attributes(shape: ['oo-o', '--o-', 'o--o'])
          expect(results[3]).to have_attributes(name: 'invader_b', location: [29, 4], precision: 0.917)
          expect(results[3].image).to have_attributes(shape: ['-o-o', '--o-', 'oo-o'])
          expect(results[4]).to have_attributes(name: 'invader_a', location: [29, 1], precision: 0.833)
          expect(results[4].image).to have_attributes(shape: ['-oo', 'oo-'])
          expect(results[5]).to have_attributes(name: 'invader_a', location: [19, 3], precision: 0.833)
          expect(results[5].image).to have_attributes(shape: ['-o-', 'ooo'])
        end.to output(report).to_stdout
      end
    end
  end
end
