require './lib/signal_scanner'

input = File.read('data/radar_sample')

scanner = SignalScanner.new(input)
scanner.run
