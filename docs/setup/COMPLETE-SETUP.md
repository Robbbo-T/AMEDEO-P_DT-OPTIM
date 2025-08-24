# AMEDEO-P DT-OPTIM™ Directory Structure Build Instructions

## **Complete Framework Directory Creation Guide**

**Document Version**: 1.0.0  
**Purpose**: Step-by-step instructions to build the complete AMEDEO-P DT-OPTIM directory structure  
**Target**: 3,920 Systems, 39,200 Configuration Items, 431,200 Lifecycle Folders

---

## **📁 Quick Setup Script**

### **Option 1: Automated Full Build Script**

Create and run `build_structure.sh`:

```bash
# Clone the repository
git clone https://github.com/robbbo-t/amedeo-p-dt-optim.git
cd amedeo-p-dt-optim

# Run the setup script
./scripts/setup.sh

# Run the build script
./build_structure.sh
```

---

## **📋 Manual Build Instructions**

### **Step 1: Create Root and Main Directories**

```bash
# Create root
mkdir -p AMEDEO-P-DT-OPTIM
cd AMEDEO-P-DT-OPTIM

# Create Layer 0: Framework
mkdir -p 00-FRAMEWORK/{core,quantum-engine,ai-ml,synthetic-core,integration}

# Create Layer 1: Organizational
mkdir -p 01-ORGANIZATIONAL/{governance,decision-frameworks,hmi,knowledge-management}

# Create Layer 2: Procedural  
mkdir -p 02-PROCEDURAL/{lifecycle-phases,workflow-automation,compliance,process-optimization}

# Create Layer 4: Intelligent Machine
mkdir -p 04-INTELLIGENT-MACHINE/{quantum-processing,predictive-analytics,optimization-engines,autonomous-systems}
```

### **Step 2: Create Domain Structure Template**

```bash
# Define function for creating domain segments
create_domain() {
    local DOMAIN=$1
    local SEGMENTS=("${@:2}")
    
    for SEGMENT in "${SEGMENTS[@]}"; do
        mkdir -p "03-TECHNICAL-AMEDEO-P/$DOMAIN/$SEGMENT"
    done
}

# Create AIR domain
create_domain "AIR" \
    "Airframes" \
    "Mechanical" \
    "Environmental" \
    "Digital_Distributed" \
    "Energy" \
    "Operating_Systems" \
    "Propulsion"

# Create SPACE domain
create_domain "SPACE" \
    "Architecture" \
    "Maneuvering" \
    "Environment" \
    "Data_Comm" \
    "Energy_Power" \
    "Operations" \
    "Propulsion"

# Continue for DEFENSE, GROUND, CROSS...
```

### **Step 3: Create System Hierarchy**

```bash
# Example for one system in AIR/Airframes
SYSTEM_PATH="03-TECHNICAL-AMEDEO-P/AIR/Airframes/System-001"
mkdir -p "$SYSTEM_PATH/CA-AF001"

# Create 10 CIs for this system
for i in {001..010}; do
    CI_PATH="$SYSTEM_PATH/CA-AF001/CI-AF001-$i"
    mkdir -p "$CI_PATH"/{01-REQUIREMENTS,02-DESIGN,03-BUILDING-PROTOTYPING,04-EXECUTABLES-PACKAGES}
    mkdir -p "$CI_PATH"/{05-VERIFICATION-VALIDATION,06-INTEGRATION-QUALIFICATION}
    mkdir -p "$CI_PATH"/{07-CERTIFICATION-SECURITY,08-PRODUCTION-SCALE}
    mkdir -p "$CI_PATH"/{09-OPS-SERVICES,10-MRO,11-SUSTAINMENT-RECYCLE-EOL}
done
```

---

## **🎯 Directory Naming Conventions**

### **System Level**
```
Pattern: System-{NNN}
Example: System-001, System-150, System-200
```

### **Constituent Assembly Level**
```
Pattern: CA-{Domain}{Segment}{SystemNum}
Example: CA-AF001 (AIR, Airframes, System 001)
```

### **Configuration Item Level**
```
Pattern: CI-{Domain}{Segment}{SystemNum}-{ItemNum}
Example: CI-AF001-001 (First CI of System AF001)
```

---

## **📊 Expected Directory Count**

```yaml
directory_metrics:
  framework_dirs: ~50
  organizational_dirs: ~20
  procedural_dirs: ~20
  intelligent_dirs: ~20
  
  technical_dirs:
    domains: 5
    segments_per_domain: 7
    systems_total: 3,920
    cas_total: 3,920
    cis_total: 39,200
    lifecycle_phases_per_ci: 11
    
  total_lifecycle_dirs: 431,200
  total_all_dirs: ~431,310
```

---

## **⚡ Quick Build Options**

### **Option A: Minimal Structure (Demo)**
```bash
# Creates structure with 1 system per segment (35 systems total)
./build_structure.sh --mode minimal
```

### **Option B: Sample Structure (Testing)**
```bash
# Creates 10% of full structure (392 systems)
./build_structure.sh --mode sample
```

### **Option C: Full Structure (Complete)**
```bash
# Creates all 3,920 systems
./build_structure.sh --mode full
```

---

## **📝 Post-Build Steps**

1. **Initialize Git Repository**
```bash
git init
git add .
git commit -m "Initial AMEDEO-P DT-OPTIM structure"
```

2. **Create Virtual Environment**
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

3. **Run Structure Validation**
```bash
./validate_structure.sh
python -m pytest tests/test_structure.py
```

4. **Generate Documentation**
```bash
python scripts/generate_docs.py
```

---

## **💡 Tips**

1. **Storage Requirements**
   - Empty structure: ~500MB
   - With sample data: ~50GB
   - Full synthetic data: ~500GB

2. **Performance Optimization**
   - Use SSD for better I/O performance
   - Consider using symbolic links for repeated structures
   - Implement lazy loading for large datasets

3. **Version Control**
   - Add `data/` to `.gitignore`
   - Use Git LFS for large binary files
   - Consider separate repos for different domains

---

**Need Help?** Check [docs/guides/TROUBLESHOOTING.md](docs/guides/TROUBLESHOOTING.md) or open an issue.