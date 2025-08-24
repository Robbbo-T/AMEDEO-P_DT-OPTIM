# **Quick Start Guide**

## **AMEDEO-P DT-OPTIM Framework Setup**

Welcome to the AMEDEO-P DT-OPTIM framework! This guide will help you get started quickly with the complete reference architecture for aerospace digital twin systems.

---

## **Prerequisites**

```yaml
environment:
  python: ">=3.9"
  memory: "16GB minimum"
  storage: "100GB for synthetic data"
  os: "Linux/macOS/Windows with WSL2"
  
optional:
  - "GPU for ML acceleration"
  - "Quantum simulator (Qiskit/Cirq)"
  - "Docker for containerized deployment"
```

---

## **Installation**

### **Option 1: Automated Setup (Recommended)**

```bash
# Clone the repository
git clone https://github.com/robbbo-t/amedeo-p-dt-optim.git
cd amedeo-p-dt-optim

# Run automated setup script
chmod +x scripts/setup.sh
./scripts/setup.sh

# Build the complete directory structure
./build_structure.sh --mode full

# Validate the structure
./scripts/validate_structure.sh
```

### **Option 2: Manual Setup**

```bash
# Clone the repository
git clone https://github.com/robbbo-t/amedeo-p-dt-optim.git
cd amedeo-p-dt-optim

# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Initialize framework
python init_framework.py --mode reference

# Build structure manually
./build_structure.sh --mode sample  # or 'minimal' for testing
```

---

## **Directory Structure Overview**

The framework creates a comprehensive directory structure representing:

- **5 Operational Domains**
- **3,920 Total Systems** 
- **39,200 Configuration Items** (10 CIs per system)
- **431,200 Lifecycle Management Points** (11 phases × CIs)

### **Domains Distribution**

| Domain | Systems | CIs | Focus Area |
|--------|---------|-----|------------|
| **AIR** | 1,400 | 14,000 | Aviation and atmospheric flight |
| **SPACE** | 700 | 7,000 | Spacecraft and orbital systems |
| **DEFENSE** | 1,050 | 10,500 | Military and defense systems |
| **GROUND** | 350 | 3,500 | Ground vehicles and infrastructure |
| **CROSS** | 420 | 4,200 | Cross-domain integration |

### **AMEDEO-P Segments**

Each domain implements the 7 AMEDEO-P technical segments:

| Segment | Generic | AIR Example | SPACE Example |
|---------|---------|-------------|---------------|
| **A** | Architecture | Airframes | Spacecraft Architecture |
| **M** | Mechanical | Mechanical Systems | Maneuvering/Attitude |
| **E** | Environmental | Environmental Control | Life Support |
| **D** | Digital | Digital/Avionics | Data/Communications |
| **E** | Energy | Electrical Systems | Power Generation |
| **O** | Operations | Operating Systems | Mission Operations |
| **P** | Propulsion | Engines | Propulsion Systems |

---

## **Build Options**

### **Build Modes**

```bash
# Full Structure (3,920 systems - Production)
./build_structure.sh --mode full

# Sample Structure (392 systems - Development)
./build_structure.sh --mode sample

# Minimal Structure (35 systems - Testing)
./build_structure.sh --mode minimal

# Non-interactive mode (skip confirmations)
./build_structure.sh --mode sample --non-interactive

# Verbose output
./build_structure.sh --mode full --verbose
```

### **Validation**

```bash
# Validate the created structure
./scripts/validate_structure.sh

# Check statistics
cat STATISTICS.md

# Run integrity tests
python -m pytest tests/test_structure.py
```

---

## **Generate First Synthetic Dataset**

Once the structure is built, generate synthetic data:

```bash
# Generate AIR domain synthetic data
python 00-FRAMEWORK/synthetic-core/generate.py \
  --domain AIR \
  --segment A \
  --systems 10 \
  --duration 1000h \
  --output data/synthetic/air/

# Generate SPACE domain telemetry
python 00-FRAMEWORK/synthetic-core/generate.py \
  --domain SPACE \
  --segment P \
  --systems 5 \
  --scenario orbital \
  --output data/synthetic/space/

# Generate anomaly scenarios
python 00-FRAMEWORK/synthetic-core/generate_anomalies.py \
  --domain DEFENSE \
  --anomaly-rate 0.01 \
  --types "sensor_drift,component_failure"
```

---

## **Quick Verification**

```bash
# Check if everything is set up correctly
python scripts/verify_installation.py

# Expected output:
# ✅ Python version: 3.9+
# ✅ Virtual environment: Active
# ✅ Dependencies: Installed
# ✅ Directory structure: Valid
# ✅ Configuration: Loaded
# ✅ Synthetic generators: Available
```

---

## **Next Steps**

1. **Explore the Structure**
   ```bash
   # View the created domains
   ls -la 03-TECHNICAL-AMEDEO-P/
   
   # Examine a sample CI
   tree 03-TECHNICAL-AMEDEO-P/AIR/Airframes/System-001/CA-AF001/CI-AF001-001/
   ```

2. **Review Configuration**
   ```bash
   # Check framework configuration
   cat config/framework.yaml
   
   # Review domain-specific configs
   ls -la config/domains/
   ```

3. **Run Examples**
   ```bash
   # Run example notebooks
   jupyter notebook examples/notebooks/
   
   # Execute sample scripts
   python examples/generate_telemetry.py
   ```

4. **Read Documentation**
   - [Architecture Overview](../architecture/OVERVIEW.md)
   - [Domain Specifications](../domains/README.md)
   - [API Reference](../api/README.md)
   - [Synthetic Data Guide](../synthetic/GENERATORS.md)

5. **Run Tests**
   ```bash
   # Run all tests
   python -m pytest tests/
   
   # Run specific test suites
   python -m pytest tests/test_generators.py
   python -m pytest tests/test_structure.py
   ```

6. **Start Development**
   ```bash
   # Launch development server
   python scripts/dev_server.py
   
   # Open dashboard
   # Browser: http://localhost:8080
   ```

---

## **Common Tasks**

### **Adding a New System**

```bash
python scripts/add_system.py \
  --domain AIR \
  --segment A \
  --name "Advanced-Fighter-System"
```

### **Generating Reports**

```bash
python scripts/generate_report.py \
  --type structure \
  --output reports/structure_report.html
```

### **Cleaning Generated Data**

```bash
# Clean synthetic data only
rm -rf data/synthetic/*

# Clean everything except structure
./scripts/clean.sh --keep-structure

# Full clean (removes everything)
./scripts/clean.sh --full
```

---

## **Troubleshooting**

### **Common Issues**

| Issue | Solution |
|-------|----------|
| **Permission denied** | Run `chmod +x scripts/*.sh` |
| **Module not found** | Activate venv: `source venv/bin/activate` |
| **Out of memory** | Use `--mode minimal` for testing |
| **Build fails** | Check disk space, use `df -h` |

### **Getting Help**

- 📖 **Documentation**: [Complete Setup Guide](../setup/COMPLETE-SETUP.md)
- ❓ **FAQ**: [Frequently Asked Questions](../FAQ.md)
- 🐛 **Issues**: [GitHub Issues](https://github.com/robbbo-t/amedeo-p-dt-optim/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/robbbo-t/amedeo-p-dt-optim/discussions)
- 📧 **Contact**: robbbo.t@dt-optim-framework.io

---

## **Performance Tips**

1. **Use SSD storage** for better I/O performance
2. **Allocate sufficient RAM** (32GB recommended for full structure)
3. **Enable parallel processing** with `--parallel` flag
4. **Use minimal mode** for development and testing
5. **Consider Docker** for isolated environments

---

## **What's Next?**

After completing the quick start:

1. **Deep Dive**: Read the [Architecture Overview](../architecture/OVERVIEW.md)
2. **Learn**: Follow the [Tutorials](../tutorials/README.md)
3. **Contribute**: See [Contributing Guide](../../CONTRIBUTING.md)
4. **Customize**: Modify for your use case
5. **Share**: Join the community discussions

---

**Congratulations!** 🎉 You've successfully set up the AMEDEO-P DT-OPTIM framework. You're now ready to explore the future of aerospace digital twin technology!

---

*Last Updated: 2025-08-24 | Version: 3.0.0 | [Edit this page](https://github.com/robbbo-t/amedeo-p-dt-optim/edit/main/docs/guides/QUICK_START.md)*