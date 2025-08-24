# Scripts Directory

This directory contains utility scripts for building and managing the AMEDEO-P DT-OPTIM framework structure.

## Scripts

- `quick_build.sh` - Interactive build mode selector
- `setup.sh` - Environment setup and dependencies
- Additional utilities for framework management

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
```

See individual script files for detailed usage instructions.