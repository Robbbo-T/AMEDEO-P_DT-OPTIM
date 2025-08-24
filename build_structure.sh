#!/bin/bash
# AMEDEO-P DT-OPTIM Directory Structure Builder
# Version: 3.0.0
# Purpose: Creates complete framework directory structure

set -e  # Exit on error

# Parse command line arguments
MODE="full"
INTERACTIVE="true"
while [[ $# -gt 0 ]]; do
    case $1 in
        --mode)
            MODE="$2"
            shift 2
            ;;
        --non-interactive)
            INTERACTIVE="false"
            shift
            ;;
        *)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

# Set system counts based on mode
case $MODE in
    "minimal")
        AIR_COUNT=1; SPACE_COUNT=1; DEFENSE_COUNT=1; GROUND_COUNT=1; CROSS_COUNT=1
        TOTAL_SYSTEMS=35
        echo "🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (MINIMAL MODE)"
        echo "============================================================="
        echo "This will create 35 systems with 350 CIs (1 per segment)"
        ;;
    "sample")
        AIR_COUNT=20; SPACE_COUNT=10; DEFENSE_COUNT=15; GROUND_COUNT=5; CROSS_COUNT=6
        TOTAL_SYSTEMS=392
        echo "🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (SAMPLE MODE)"
        echo "============================================================="
        echo "This will create 392 systems with 3,920 CIs (10% of full)"
        ;;
    "full")
        AIR_COUNT=200; SPACE_COUNT=100; DEFENSE_COUNT=150; GROUND_COUNT=50; CROSS_COUNT=60
        TOTAL_SYSTEMS=3920
        echo "🚀 AMEDEO-P DT-OPTIM Directory Structure Builder (FULL MODE)"
        echo "==========================================================="
        echo "This will create 3,920 systems with 39,200 CIs"
        ;;
    *)
        echo "Invalid mode: $MODE. Use minimal, sample, or full."
        exit 1
        ;;
esac

echo "Estimated time: 1-10 minutes (depending on mode)"
echo "Required space: ~50MB-500MB for empty structure"
echo ""

if [[ "$INTERACTIVE" == "true" ]]; then
    read -p "Continue? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Define root directory
ROOT_DIR="AMEDEO-P-DT-OPTIM"
mkdir -p "$ROOT_DIR"
cd "$ROOT_DIR"

# Create main framework directories
echo "📂 Creating main framework directories..."
mkdir -p 00-FRAMEWORK/{core,quantum-engine,ai-ml,synthetic-core,integration}
mkdir -p 01-ORGANIZATIONAL/{governance,decision-frameworks,hmi,knowledge-management}
mkdir -p 02-PROCEDURAL/{lifecycle-phases,workflow-automation,compliance,process-optimization}
mkdir -p 04-INTELLIGENT-MACHINE/{quantum-processing,predictive-analytics,optimization-engines,autonomous-systems}

# Create documentation structure
echo "📚 Creating documentation structure..."
mkdir -p docs/{architecture,domains,synthetic,guides,api,schemas,tutorials,research}
mkdir -p docs/domains/{AIR,SPACE,DEFENSE,GROUND,CROSS}

# Create supporting directories
echo "🛠️ Creating supporting directories..."
mkdir -p {scripts,tests,data/synthetic,config/domains,tools/validators,examples}

# Create lifecycle phase template
create_lifecycle_phases() {
    local ci_path=$1
    mkdir -p "$ci_path"/{01-REQUIREMENTS,02-DESIGN,03-BUILDING-PROTOTYPING,04-EXECUTABLES-PACKAGES}
    mkdir -p "$ci_path"/{05-VERIFICATION-VALIDATION,06-INTEGRATION-QUALIFICATION}
    mkdir -p "$ci_path"/{07-CERTIFICATION-SECURITY,08-PRODUCTION-SCALE}
    mkdir -p "$ci_path"/{09-OPS-SERVICES,10-MRO,11-SUSTAINMENT-RECYCLE-EOL}
    
    # Add README to each phase
    for phase in "$ci_path"/*; do
        echo "# $(basename $phase)" > "$phase/README.md"
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
    
    echo "  Creating $system_count systems in $domain/$segment_name..."
    
    segment_dir="03-TECHNICAL-AMEDEO-P/$domain/$segment_name"
    mkdir -p "$segment_dir"
    
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
echo "✈️ Creating AIR domain ($AIR_TOTAL systems)..."
AIR_SEGMENTS=("Airframes" "Mechanical" "Environmental" "Digital_Distributed" "Energy" "Operating_Systems" "Propulsion")
AIR_LETTERS=("F" "M" "E" "D" "N" "O" "P")
for i in ${!AIR_SEGMENTS[@]}; do
    create_segment_systems "AIR" "${AIR_LETTERS[$i]}" "${AIR_SEGMENTS[$i]}" $AIR_COUNT "A" "${AIR_LETTERS[$i]}"
done

# Create SPACE domain
SPACE_TOTAL=$(($SPACE_COUNT * 7))
echo "🚀 Creating SPACE domain ($SPACE_TOTAL systems)..."
SPACE_SEGMENTS=("Architecture" "Maneuvering" "Environment" "Data_Comm" "Energy_Power" "Operations" "Propulsion")
SPACE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!SPACE_SEGMENTS[@]}; do
    create_segment_systems "SPACE" "${SPACE_LETTERS[$i]}" "${SPACE_SEGMENTS[$i]}" $SPACE_COUNT "S" "${SPACE_LETTERS[$i]}"
done

# Create DEFENSE domain
DEFENSE_TOTAL=$(($DEFENSE_COUNT * 7))
echo "🛡️ Creating DEFENSE domain ($DEFENSE_TOTAL systems)..."
DEFENSE_SEGMENTS=("Armor_Protection" "Munitions" "Electronic_Warfare" "Data_C4ISR" "Energy_Systems" "Operations_Command" "Platform_Mobility")
DEFENSE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!DEFENSE_SEGMENTS[@]}; do
    create_segment_systems "DEFENSE" "${DEFENSE_LETTERS[$i]}" "${DEFENSE_SEGMENTS[$i]}" $DEFENSE_COUNT "D" "${DEFENSE_LETTERS[$i]}"
done

# Create GROUND domain
GROUND_TOTAL=$(($GROUND_COUNT * 7))
echo "🚗 Creating GROUND domain ($GROUND_TOTAL systems)..."
GROUND_SEGMENTS=("Architecture_Chassis" "Mobility_Drivetrain" "Environmental" "Digital_Autonomous" "Energy_Hybrid" "Operations_Fleet" "Powertrain")
GROUND_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!GROUND_SEGMENTS[@]}; do
    create_segment_systems "GROUND" "${GROUND_LETTERS[$i]}" "${GROUND_SEGMENTS[$i]}" $GROUND_COUNT "G" "${GROUND_LETTERS[$i]}"
done

# Create CROSS domain
CROSS_TOTAL=$(($CROSS_COUNT * 7))
echo "🔄 Creating CROSS domain ($CROSS_TOTAL systems)..."
CROSS_SEGMENTS=("Adaptive_Architecture" "Multi_Role" "Extended_Environment" "Distributed_Networks" "Energy_Universal" "Orchestration" "Polymorphic_Propulsion")
CROSS_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!CROSS_SEGMENTS[@]}; do
    create_segment_systems "CROSS" "${CROSS_LETTERS[$i]}" "${CROSS_SEGMENTS[$i]}" $CROSS_COUNT "X" "${CROSS_LETTERS[$i]}"
done

# Create key framework files
echo "📝 Creating framework files..."

# Create main README
cat > README.md << 'EOF'
# AMEDEO-P DT-OPTIM™
## Quantum-Enhanced Digital Twin Framework
### Reference Architecture for Aerospace Systems

[![Framework](https://img.shields.io/badge/Framework-DT--OPTIM-purple)]()
[![Systems](https://img.shields.io/badge/Systems-3,920-green)]()
[![CIs](https://img.shields.io/badge/CIs-39,200-blue)]()
[![Version](https://img.shields.io/badge/Version-3.0.0-red)]()

**A Conceptual Reference Architecture for Next-Generation Digital Twins**

## Structure
- 5 Domains (AIR, SPACE, DEFENSE, GROUND, CROSS)
- 7 Segments per Domain (AMEDEO-P)
- 3,920 Total Systems
- 39,200 Configuration Items
- 431,200 Lifecycle Phase Folders

## Quick Start
See [docs/guides/QUICK_START.md](docs/guides/QUICK_START.md)

## License
MIT License - Educational and Research Use
EOF

# Create Python package structure
echo "🐍 Creating Python package structure..."
cat > setup.py << 'EOF'
from setuptools import setup, find_packages

setup(
    name="amedeo-p-dt-optim",
    version="3.0.0",
    packages=find_packages(),
    install_requires=[
        "numpy>=1.21.0",
        "pandas>=1.3.0",
        "pyyaml>=5.4.0",
        "pytest>=6.2.0",
    ],
    python_requires=">=3.9",
)
EOF

# Create requirements file
cat > requirements.txt << 'EOF'
numpy>=1.21.0
pandas>=1.3.0
matplotlib>=3.4.0
pyyaml>=5.4.0
pytest>=6.2.0
qiskit>=0.37.0
networkx>=2.6.0
influxdb-client>=1.30.0
EOF

# Create configuration files
echo "⚙️ Creating configuration files..."
cat > config/framework.yaml << 'EOF'
framework:
  name: AMEDEO-P DT-OPTIM
  version: 3.0.0
  type: Reference Architecture
  
domains:
  - name: AIR
    systems: 1400
    segments: 7
  - name: SPACE
    systems: 700
    segments: 7
  - name: DEFENSE
    systems: 1050
    segments: 7
  - name: GROUND
    systems: 350
    segments: 7
  - name: CROSS
    systems: 420
    segments: 7

lifecycle_phases: 11
total_systems: 3920
total_cis: 39200
EOF

# Create statistics file
echo "📊 Generating statistics..."
TOTAL_DIRS=$(find . -type d | wc -l)
TOTAL_FILES=$(find . -type f | wc -l)
ACTUAL_SYSTEMS=$(find . -name "System-*" -type d | wc -l 2>/dev/null || echo "0")
ACTUAL_CIS=$(find . -name "CI-*" -type d | wc -l 2>/dev/null || echo "0")

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
EOF

# Add domain-specific statistics
for DOMAIN in AIR SPACE DEFENSE GROUND CROSS; do
    if [ -d "03-TECHNICAL-AMEDEO-P/$DOMAIN" ]; then
        DOMAIN_SYSTEMS=$(find "03-TECHNICAL-AMEDEO-P/$DOMAIN" -name "System-*" -type d | wc -l 2>/dev/null || echo "0")
        echo "- $DOMAIN: $DOMAIN_SYSTEMS systems ($(($DOMAIN_SYSTEMS * 10)) CIs)" >> STATISTICS.md
    fi
done

echo ""
echo "✅ Directory structure build complete!"
echo "📊 Statistics:"
echo "   - Directories created: $TOTAL_DIRS"
echo "   - Files created: $TOTAL_FILES"
echo "   - Total systems: $ACTUAL_SYSTEMS"
echo "   - Total CIs: $ACTUAL_CIS"
echo "   - Build mode: $MODE"
echo ""
echo "📁 Structure created in: $(pwd)"
echo ""
echo "Next steps:"
echo "1. cd $ROOT_DIR"
echo "2. pip install -r requirements.txt"
echo "3. ./validate_structure.sh"
echo "4. See docs/guides/QUICK_START.md"