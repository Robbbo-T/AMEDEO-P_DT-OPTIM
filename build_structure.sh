```bash
#!/bin/bash
# AMEDEO-P DT-OPTIM Directory Structure Builder
# Version: 3.0.0
# Purpose: Creates complete framework directory structure

set -e  # Exit on error

# Default values
MODE="full"
INTERACTIVE="true"
VERBOSE="false"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --mode)
            MODE="$2"
            shift 2
            ;;
        --non-interactive|-n)
            INTERACTIVE="false"
            shift
            ;;
        --verbose|-v)
            VERBOSE="true"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --mode MODE           Build mode: minimal, sample, or full (default: full)"
            echo "  --non-interactive,-n  Skip confirmation prompt"
            echo "  --verbose,-v          Show detailed progress"
            echo "  --help,-h            Show this help message"
            echo ""
            echo "Modes:"
            echo "  minimal - Creates 35 systems (1 per segment) for testing"
            echo "  sample  - Creates 392 systems (10% of full) for development"
            echo "  full    - Creates 3,920 systems (complete structure)"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Set system counts based on mode
case $MODE in
    "minimal")
        AIR_COUNT=1
        SPACE_COUNT=1
        DEFENSE_COUNT=1
        GROUND_COUNT=1
        CROSS_COUNT=1
        echo -e "${BLUE}🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (MINIMAL MODE)${NC}"
        echo "============================================================="
        echo "This will create 35 systems with 350 CIs (1 per segment)"
        ;;
    "sample")
        AIR_COUNT=20
        SPACE_COUNT=10
        DEFENSE_COUNT=15
        GROUND_COUNT=5
        CROSS_COUNT=6
        echo -e "${BLUE}🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (SAMPLE MODE)${NC}"
        echo "============================================================="
        echo "This will create 392 systems with 3,920 CIs (10% of full)"
        ;;
    "full")
        AIR_COUNT=200
        SPACE_COUNT=100
        DEFENSE_COUNT=150
        GROUND_COUNT=50
        CROSS_COUNT=60
        echo -e "${BLUE}🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (FULL MODE)${NC}"
        echo "==========================================================="
        echo "This will create 3,920 systems with 39,200 CIs"
        ;;
    *)
        echo -e "${RED}Invalid mode: $MODE. Use minimal, sample, or full.${NC}"
        exit 1
        ;;
esac

# Calculate totals
TOTAL_SYSTEMS=$((($AIR_COUNT + $SPACE_COUNT + $DEFENSE_COUNT + $GROUND_COUNT + $CROSS_COUNT) * 7))
TOTAL_CIS=$(($TOTAL_SYSTEMS * 10))
TOTAL_LIFECYCLE=$(($TOTAL_CIS * 11))

echo ""
echo "Configuration:"
echo "  Systems to create: $TOTAL_SYSTEMS"
echo "  Configuration Items: $TOTAL_CIS"
echo "  Lifecycle Folders: $TOTAL_LIFECYCLE"
echo "  Estimated time: 1-10 minutes (depending on mode)"
echo "  Required space: ~50MB-500MB for empty structure"
echo ""

# Confirmation prompt
if [[ "$INTERACTIVE" == "true" ]]; then
    read -p "Continue? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Build cancelled."
        exit 0
    fi
fi

# Define root directory
ROOT_DIR="AMEDEO-P-DT-OPTIM"
if [ -d "$ROOT_DIR" ]; then
    echo -e "${YELLOW}Warning: Directory $ROOT_DIR already exists.${NC}"
    if [[ "$INTERACTIVE" == "true" ]]; then
        read -p "Overwrite? (y/n): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Build cancelled."
            exit 0
        fi
    fi
    rm -rf "$ROOT_DIR"
fi

mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

# Progress tracking
CURRENT_STEP=0
TOTAL_STEPS=10

show_progress() {
    CURRENT_STEP=$((CURRENT_STEP + 1))
    local percentage=$((CURRENT_STEP * 100 / TOTAL_STEPS))
    echo -e "${GREEN}[${percentage}%]${NC} $1"
}

# Create main framework directories
show_progress "Creating main framework directories..."
mkdir -p 00-FRAMEWORK/{core,quantum-engine,ai-ml,synthetic-core,integration}
mkdir -p 01-ORGANIZATIONAL/{governance,decision-frameworks,hmi,knowledge-management}
mkdir -p 02-PROCEDURAL/{lifecycle-phases,workflow-automation,compliance,process-optimization}
mkdir -p 04-INTELLIGENT-MACHINE/{quantum-processing,predictive-analytics,optimization-engines,autonomous-systems}

# Create documentation structure
show_progress "Creating documentation structure..."
mkdir -p docs/{architecture,domains,synthetic,guides,api,schemas,tutorials,research}
mkdir -p docs/domains/{AIR,SPACE,DEFENSE,GROUND,CROSS}

# Create supporting directories
show_progress "Creating supporting directories..."
mkdir -p {scripts,tests,data/synthetic,config/domains,tools/validators,examples}

# Create lifecycle phase template function
create_lifecycle_phases() {
    local ci_path=$1
    mkdir -p "$ci_path"/{01-REQUIREMENTS,02-DESIGN,03-BUILDING-PROTOTYPING,04-EXECUTABLES-PACKAGES}
    mkdir -p "$ci_path"/{05-VERIFICATION-VALIDATION,06-INTEGRATION-QUALIFICATION}
    mkdir -p "$ci_path"/{07-CERTIFICATION-SECURITY,08-PRODUCTION-SCALE}
    mkdir -p "$ci_path"/{09-OPS-SERVICES,10-MRO,11-SUSTAINMENT-RECYCLE-EOL}
    
    # Add README to each phase
    for phase in "$ci_path"/*; do
        if [ -d "$phase" ]; then
            echo "# $(basename $phase)" > "$phase/README.md"
            echo "Phase: $(basename $phase)" >> "$phase/README.md"
            echo "CI: $(basename $(dirname $phase))" >> "$phase/README.md"
            echo "Generated: $(date)" >> "$phase/README.md"
        fi
    done
}

# Function to create systems for a domain segment
create_segment_systems() {
    local domain=$1
    local segment=$2
    local segment_name=$3
    local system_count=$4
    local domain_letter=$5
    local segment_letter=$6
    
    if [[ "$VERBOSE" == "true" ]]; then
        echo "  Creating $system_count systems in $domain/$segment_name..."
    fi
    
    segment_dir="03-TECHNICAL-AMEDEO-P/$domain/$segment_name"
    mkdir -p "$segment_dir"
    
    # Create segment README
    cat > "$segment_dir/README.md" << EOF
# $domain - $segment_name

Domain: $domain
Segment: $segment_name
Systems: $system_count
Configuration Items: $(($system_count * 10))
Generated: $(date)
EOF
    
    for ((sys=1; sys<=system_count; sys++)); do
        sys_num=$(printf "%03d" $sys)
        system_dir="$segment_dir/System-$sys_num"
        mkdir -p "$system_dir"
        
        # Create Constituent Assembly
        ca_dir="$system_dir/CA-${domain_letter}${segment_letter}${sys_num}"
        mkdir -p "$ca_dir"
        
        # Create 10 Configuration Items per system
        for ((ci=1; ci<=10; ci++)); do
            ci_num=$(printf "%03d" $ci)
            ci_dir="$ca_dir/CI-${domain_letter}${segment_letter}${sys_num}-${ci_num}"
            create_lifecycle_phases "$ci_dir"
        done
    done
}

# Create AIR domain
AIR_TOTAL=$(($AIR_COUNT * 7))
show_progress "Creating AIR domain ($AIR_TOTAL systems)..."
AIR_SEGMENTS=("Airframes" "Mechanical" "Environmental" "Digital_Distributed" "Energy" "Operating_Systems" "Propulsion")
AIR_LETTERS=("F" "M" "E" "D" "N" "O" "P")
for i in ${!AIR_SEGMENTS[@]}; do
    create_segment_systems "AIR" "${AIR_LETTERS[$i]}" "${AIR_SEGMENTS[$i]}" $AIR_COUNT "A" "${AIR_LETTERS[$i]}"
done

# Create SPACE domain
SPACE_TOTAL=$(($SPACE_COUNT * 7))
show_progress "Creating SPACE domain ($SPACE_TOTAL systems)..."
SPACE_SEGMENTS=("Architecture" "Maneuvering" "Environment" "Data_Comm" "Energy_Power" "Operations" "Propulsion")
SPACE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!SPACE_SEGMENTS[@]}; do
    create_segment_systems "SPACE" "${SPACE_LETTERS[$i]}" "${SPACE_SEGMENTS[$i]}" $SPACE_COUNT "S" "${SPACE_LETTERS[$i]}"
done

# Create DEFENSE domain
DEFENSE_TOTAL=$(($DEFENSE_COUNT * 7))
show_progress "Creating DEFENSE domain ($DEFENSE_TOTAL systems)..."
DEFENSE_SEGMENTS=("Armor_Protection" "Munitions" "Electronic_Warfare" "Data_C4ISR" "Energy_Systems" "Operations_Command" "Platform_Mobility")
DEFENSE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!DEFENSE_SEGMENTS[@]}; do
    create_segment_systems "DEFENSE" "${DEFENSE_LETTERS[$i]}" "${DEFENSE_SEGMENTS[$i]}" $DEFENSE_COUNT "D" "${DEFENSE_LETTERS[$i]}"
done

# Create GROUND domain
GROUND_TOTAL=$(($GROUND_COUNT * 7))
show_progress "Creating GROUND domain ($GROUND_TOTAL systems)..."
GROUND_SEGMENTS=("Architecture_Chassis" "Mobility_Drivetrain" "Environmental" "Digital_Autonomous" "Energy_Hybrid" "Operations_Fleet" "Powertrain")
GROUND_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!GROUND_SEGMENTS[@]}; do
    create_segment_systems "GROUND" "${GROUND_LETTERS[$i]}" "${GROUND_SEGMENTS[$i]}" $GROUND_COUNT "G" "${GROUND_LETTERS[$i]}"
done

# Create CROSS domain
CROSS_TOTAL=$(($CROSS_COUNT * 7))
show_progress "Creating CROSS domain ($CROSS_TOTAL systems)..."
CROSS_SEGMENTS=("Adaptive_Architecture" "Multi_Role" "Extended_Environment" "Distributed_Networks" "Energy_Universal" "Orchestration" "Polymorphic_Propulsion")
CROSS_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!CROSS_SEGMENTS[@]}; do
    create_segment_systems "CROSS" "${CROSS_LETTERS[$i]}" "${CROSS_SEGMENTS[$i]}" $CROSS_COUNT "X" "${CROSS_LETTERS[$i]}"
done

# Create key framework files
show_progress "Creating framework files..."

# Create main README
cat > README.md << 'EOF'
# AMEDEO-P DT-OPTIM™
## Quantum-Enhanced Digital Twin Framework
### Reference Architecture for Aerospace Systems

[![Framework](https://img.shields.io/badge/Framework-DT--OPTIM-purple)]()
[![Systems](https://img.shields.io/badge/Systems-Variable-green)]()
[![CIs](https://img.shields.io/badge/CIs-Variable-blue)]()
[![Version](https://img.shields.io/badge/Version-3.0.0-red)]()

**A Conceptual Reference Architecture for Next-Generation Digital Twins**

## Structure
- 5 Domains (AIR, SPACE, DEFENSE, GROUND, CROSS)
- 7 Segments per Domain (AMEDEO-P)
- Configurable System Count
- 10 Configuration Items per System
- 11 Lifecycle Phases per CI

## Quick Start
```bash
# Install dependencies
pip install -r requirements.txt

# Validate structure
./scripts/validate_structure.sh

# Run tests
python -m pytest tests/
```

## Documentation
- [Architecture Overview](docs/architecture/OVERVIEW.md)
- [Quick Start Guide](docs/guides/QUICK_START.md)
- [API Reference](docs/api/README.md)

## License
MIT License - Educational and Research Use
EOF

# Create Python package structure
cat > setup.py << 'EOF'
from setuptools import setup, find_packages

setup(
    name="amedeo-p-dt-optim",
    version="3.0.0",
    description="AMEDEO-P DT-OPTIM Framework - Reference Architecture for Aerospace Digital Twins",
    author="AMEDEO-P Team",
    packages=find_packages(),
    install_requires=[
        "numpy>=1.21.0",
        "pandas>=1.3.0",
        "pyyaml>=5.4.0",
        "pytest>=6.2.0",
        "matplotlib>=3.4.0",
    ],
    extras_require={
        "quantum": ["qiskit>=0.37.0"],
        "ml": ["scikit-learn>=1.0.0", "tensorflow>=2.9.0"],
        "viz": ["plotly>=5.0.0", "dash>=2.0.0"],
    },
    python_requires=">=3.9",
)
EOF

# Create requirements file
cat > requirements.txt << 'EOF'
# Core dependencies
numpy>=1.21.0
pandas>=1.3.0
matplotlib>=3.4.0
pyyaml>=5.4.0

# Testing
pytest>=6.2.0
pytest-cov>=3.0.0

# Optional: Quantum simulation
# qiskit>=0.37.0

# Optional: Data management
# influxdb-client>=1.30.0
# networkx>=2.6.0
EOF

# Create configuration file
mkdir -p config
cat > config/framework.yaml << EOF
framework:
  name: AMEDEO-P DT-OPTIM
  version: 3.0.0
  type: Reference Architecture
  build_mode: $MODE
  build_date: $(date -Iseconds)
  
domains:
  - name: AIR
    systems: $AIR_TOTAL
    segments: 7
    cis_per_system: 10
  - name: SPACE
    systems: $SPACE_TOTAL
    segments: 7
    cis_per_system: 10
  - name: DEFENSE
    systems: $DEFENSE_TOTAL
    segments: 7
    cis_per_system: 10
  - name: GROUND
    systems: $GROUND_TOTAL
    segments: 7
    cis_per_system: 10
  - name: CROSS
    systems: $CROSS_TOTAL
    segments: 7
    cis_per_system: 10

lifecycle_phases: 11
total_systems: $TOTAL_SYSTEMS
total_cis: $TOTAL_CIS
total_lifecycle_folders: $TOTAL_LIFECYCLE
EOF

# Create validation script
show_progress "Creating validation script..."
cat > scripts/validate_structure.sh << 'EOFSCRIPT'
#!/bin/bash
# Structure validation script

echo "Validating AMEDEO-P DT-OPTIM Structure..."
echo ""

# Check domains
ERRORS=0
for DOMAIN in AIR SPACE DEFENSE GROUND CROSS; do
    if [ -d "03-TECHNICAL-AMEDEO-P/$DOMAIN" ]; then
        SYSTEMS=$(find "03-TECHNICAL-AMEDEO-P/$DOMAIN" -name "System-*" -type d | wc -l)
        echo "✅ $DOMAIN domain exists ($SYSTEMS systems)"
    else
        echo "❌ $DOMAIN domain missing"
        ERRORS=$((ERRORS + 1))
    fi
done

# Count totals
TOTAL_SYSTEMS=$(find . -name "System-*" -type d 2>/dev/null | wc -l)
TOTAL_CIS=$(find . -name "CI-*" -type d 2>/dev/null | wc -l)

echo ""
echo "Total Systems: $TOTAL_SYSTEMS"
echo "Total Configuration Items: $TOTAL_CIS"

# Sample CI lifecycle check
SAMPLE_CI=$(find . -name "CI-*" -type d 2>/dev/null | head -1)
if [ -n "$SAMPLE_CI" ]; then
    echo ""
    echo "Checking lifecycle phases in sample CI..."
    PHASES_OK=true
    for PHASE in 01-REQUIREMENTS 02-DESIGN 03-BUILDING-PROTOTYPING; do
        if [ -d "$SAMPLE_CI/$PHASE" ]; then
            echo "✅ $PHASE exists"
        else
            echo "❌ $PHASE missing"
            PHASES_OK=false
            ERRORS=$((ERRORS + 1))
        fi
    done
fi

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ Validation passed!"
    exit 0
else
    echo "❌ Validation failed with $ERRORS errors"
    exit 1
fi
EOFSCRIPT

chmod +x scripts/validate_structure.sh

# Generate statistics
show_progress "Generating statistics..."
TOTAL_DIRS=$(find . -type d 2>/dev/null | wc -l)
TOTAL_FILES=$(find . -type f 2>/dev/null | wc -l)
ACTUAL_SYSTEMS=$(find . -name "System-*" -type d 2>/dev/null | wc -l)
ACTUAL_CIS=$(find . -name "CI-*" -type d 2>/dev/null | wc -l)

cat > STATISTICS.md << EOF
# AMEDEO-P DT-OPTIM Directory Statistics

Generated: $(date)
Build Mode: $MODE

## Structure Metrics
- Total Directories: $TOTAL_DIRS
- Total Files: $TOTAL_FILES
- Systems Created: $ACTUAL_SYSTEMS
- Configuration Items: $ACTUAL_CIS
- Lifecycle Folders: $(($ACTUAL_CIS * 11))

## Domain Distribution (Mode: $MODE)
- AIR: $AIR_TOTAL systems ($(($AIR_TOTAL * 10)) CIs)
- SPACE: $SPACE_TOTAL systems ($(($SPACE_TOTAL * 10)) CIs)
- DEFENSE: $DEFENSE_TOTAL systems ($(($DEFENSE_TOTAL * 10)) CIs)
- GROUND: $GROUND_TOTAL systems ($(($GROUND_TOTAL * 10)) CIs)
- CROSS: $CROSS_TOTAL systems ($(($CROSS_TOTAL * 10)) CIs)

## Build Configuration
- Build Date: $(date)
- Build Mode: $MODE
- Build Time: ${SECONDS}s
- Disk Usage: $(du -sh . 2>/dev/null | cut -f1)
EOF

# Final summary
echo ""
echo -e "${GREEN}✅ Directory structure build complete!${NC}"
echo ""
echo "📊 Statistics:"
echo "   - Mode: $MODE"
echo "   - Directories created: $TOTAL_DIRS"
echo "   - Files created: $TOTAL_FILES"
echo "   - Total systems: $ACTUAL_SYSTEMS"
echo "   - Total CIs: $ACTUAL_CIS"
echo "   - Build time: ${SECONDS}s"
echo ""
echo "📁 Structure created in: $(pwd)"
echo ""
echo "Next steps:"
echo "1. cd $ROOT_DIR"
echo "2. pip install -r requirements.txt"
echo "3. ./scripts/validate_structure.sh"
echo "4. python -m pytest tests/"
echo "5. See docs/guides/QUICK_START.md"
```
