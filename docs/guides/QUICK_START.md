# Quick Start Guide

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

```bash
# Clone the repository
git clone https://github.com/robbbo-t/amedeo-p-dt-optim.git
cd amedeo-p-dt-optim

# Run setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# Initialize framework
python init_framework.py --mode reference
```

## Generate Directory Structure

```bash
# Run the build script to create full structure
./build_structure.sh

# Or for testing, create minimal structure
# Edit the script to use minimal mode for faster builds
```

## Validate Structure

```bash
# Verify the created structure
./validate_structure.sh
```

## Generate First Synthetic Dataset

```bash
# Generate AIR domain synthetic data
python 00-FRAMEWORK/synthetic-core/generate.py \
  --domain AIR \
  --segment A \
  --systems 10 \
  --duration 1000h \
  --output data/synthetic/air/
```

## Next Steps

1. Explore the generated directory structure
2. Review the configuration files in `config/`
3. Check the documentation in `docs/`
4. Run validation tests
5. Begin customizing for your specific use case

## Support

- See [Complete Setup Guide](../setup/COMPLETE-SETUP.md) for detailed instructions
- Check [FAQ](../FAQ.md) for common issues
- Review [examples/](../../examples/) for usage patterns