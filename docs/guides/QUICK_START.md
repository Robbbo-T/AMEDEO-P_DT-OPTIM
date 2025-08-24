# Quick Start Guide

## AMEDEO-P DT-OPTIM Framework Setup

Welcome to the AMEDEO-P DT-OPTIM framework! This guide will help you get started quickly.

## Prerequisites

```yaml
environment:
  python: ">=3.9"
  memory: "16GB minimum"
  storage: "100GB for synthetic data"
  optional:
    - "GPU for ML acceleration"
    - "Quantum simulator (Qiskit/Cirq)"
```

## Installation

### Option 1: Automated Setup

```bash
# Run the setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# Build the complete directory structure
./build_structure.sh

# Validate the structure
./validate_structure.sh
```

### Option 2: Manual Setup

```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Build structure
./build_structure.sh
```

## Directory Structure Overview

The framework creates a comprehensive directory structure:

- **3,920 Total Systems** across 5 domains
- **39,200 Configuration Items** (10 CIs per system)
- **431,200 Lifecycle Management Points** (11 phases × CIs)

### Domains

1. **AIR** (1,400 systems) - Aviation and atmospheric flight
2. **SPACE** (700 systems) - Spacecraft and orbital systems
3. **DEFENSE** (1,050 systems) - Military and defense systems
4. **GROUND** (350 systems) - Ground vehicles and systems
5. **CROSS** (420 systems) - Cross-domain integration

### AMEDEO-P Segments

Each domain implements the AMEDEO-P methodology:
- **A** - Architecture/Airframes
- **M** - Mechanical/Maneuvering
- **E** - Environmental/Energy
- **D** - Digital/Data
- **E** - Energy/Electrical (second E)
- **O** - Operations/Operating
- **P** - Propulsion/Platform

## Build Options

### Full Structure (Complete)
```bash
./build_structure.sh
```
Creates all 3,920 systems with complete directory structure.

### Validation
```bash
./validate_structure.sh
```
Validates the created structure and reports statistics.

## Next Steps

1. Explore the created structure in `03-TECHNICAL-AMEDEO-P/`
2. Review domain-specific documentation in `docs/domains/`
3. Check framework configuration in `config/framework.yaml`
4. Run tests with `python -m pytest tests/`

## Support

- 📖 [Architecture Overview](../architecture/OVERVIEW.md)
- 🔧 [Troubleshooting](TROUBLESHOOTING.md)
- 📊 [API Reference](../api/README.md)

For questions or issues, see the main README.md or open an issue on GitHub.