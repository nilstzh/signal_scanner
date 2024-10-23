# Space Invaders Radar Detection

This is a Ruby app designed to detect invaders hidden within noisy radar samples using predefined ASCII patterns.

## Installation

```sh
asdf install # (optional) install ruby with asdf or any other prefered way
bundle install # install dependencies
```

## Run tests

```sh
bundle exec rspec
```

## Usage

```sh
ruby run.rb
```

## Project Structure

```sh
.
├── data/
│   ├── invaders.yml               # YAML file with invader patterns
│   └── radar_sample               # Sample radar input
├── lib/
│   ├── grid.rb                    # Handles radar grid processing
│   ├── image.rb                   # Represents an ASCII image
│   ├── invader.rb                 # Defines the invader structure
│   ├── invaders_registry.rb       # Stores and manages all known invaders
│   ├── located_invader.rb         # Represents an invader's location in the radar
│   ├── pattern_detector.rb        # Detects patterns in the radar grid
│   ├── reporter.rb                # Outputs detected invaders and locations
│   └── signal_scanner.rb          # Main logic for scanning the radar sample
├── spec/
│   └── ...                        # Tests for all above :)
└── run.rb                         # Script to run the radar detection
```
