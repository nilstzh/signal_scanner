# frozen_string_literal: true

require 'image'
require 'located_invader'
require 'reporter'

describe Reporter do
  describe '.print' do
    context 'when there are no invaders detected' do
      let(:empty_results) { [] }

      it 'prints the empty report message' do
        reporter = Reporter.new(empty_results)
        expect { reporter.print }.to output("Keep calm. No invaders detected.\n").to_stdout
      end
    end

    context 'when there is a single invader' do
      let(:single_result) do
        [LocatedInvader.new('Invader X', ['--o--', '-oo--', '-----'], [3, 5], 0.95)]
      end

      it 'prints the report for the single invader' do
        reporter = Reporter.new(single_result)
        expected_output = <<~OUTPUT
          ----------------------------
          ATTENTION! AHTUNG! ADVARSEL!
          Possible invader(s) detected.

          ----------------------------
          Detected Threat: Invader X
          Detected Image:
          --o--
          -oo--
          -----
          Precision: 0.950
          Coordinates: X: 3, Y: 5

        OUTPUT

        expect { reporter.print }.to output(expected_output).to_stdout
      end
    end

    context 'when there are multiple invaders' do
      let(:multiple_results) do
        [
          LocatedInvader.new('Invader Y', ['---', '-oo', '-o-'], [5, 8], 0.80),
          LocatedInvader.new('Invader X', ['--o--', '-oo--', '-----'], [3, 5], 0.95)
        ]
      end

      it 'prints the report for multiple invaders, sorted by precision' do
        reporter = Reporter.new(multiple_results)
        expected_output = <<~OUTPUT
          ----------------------------
          ATTENTION! AHTUNG! ADVARSEL!
          Possible invader(s) detected.

          ----------------------------
          Detected Threat: Invader X
          Detected Image:
          --o--
          -oo--
          -----
          Precision: 0.950
          Coordinates: X: 3, Y: 5

          ----------------------------
          Detected Threat: Invader Y
          Detected Image:
          ---
          -oo
          -o-
          Precision: 0.800
          Coordinates: X: 5, Y: 8

        OUTPUT

        expect { reporter.print }.to output(expected_output).to_stdout
      end
    end
  end
end
