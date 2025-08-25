# Scripts Directory

This directory contains utility scripts for building and managing the AMEDEO-P DT-OPTIM framework structure.

## Scripts

- `quick_build.sh` - Interactive build mode selector
- `setup.sh` - Environment setup and dependencies
 - `build_ampel_airframes.sh` - Build full AMPEL AIR/Airframes structure (200 systems)
 - `generate_ampel_index.py` - Generate AMPEL registry index (JSON/YAML/CSV)

## Main Build Scripts (Root Directory)

- `build_structure.sh` - Main directory structure builder (located in root)
- `validate_structure.sh` - Structure validation and verification (located in root)

## Usage

### Quick Start
```bash
# Interactive mode selection
./scripts/quick_build.sh

# Direct build commands
./build_structure.sh --mode minimal
./build_structure.sh --mode sample  
./build_structure.sh --mode full

# Setup environment
./scripts/setup.sh

# Validate structure
./validate_structure.sh

# Build AMPEL AIR/Airframes (200 systems)
./scripts/build_ampel_airframes.sh

# Generate AMPEL index artifacts
python scripts/generate_ampel_index.py

# Quick AMPEL validation
find 03-TECHNICAL-AMEDEO-P/AIR/Airframes -maxdepth 1 -type d -name "System-*" | wc -l
find 03-TECHNICAL-AMEDEO-P/AIR/Airframes -type d -name "CI-*" | wc -l
find 03-TECHNICAL-AMEDEO-P/AIR/Airframes -type d -name "01-REQUIREMENTS" | wc -l
```

See individual script files for detailed usage instructions.