#!/bin/bash
# AMEDEO-P DT-OPTIM Directory Structure Builder
# Version: 3.0.0
# Purpose: Creates complete framework directory structure

set -e  # Exit on error

echo "🚀 AMEDEO-P DT-OPTIM Directory Structure Builder"
echo "================================================="

# Set default counts if not provided via environment
AIR_COUNT=${AIR_COUNT:-200}
SPACE_COUNT=${SPACE_COUNT:-100}
DEFENSE_COUNT=${DEFENSE_COUNT:-150}
GROUND_COUNT=${GROUND_COUNT:-50}
CROSS_COUNT=${CROSS_COUNT:-60}

# Calculate actual totals
ACTUAL_TOTAL_SYSTEMS=$((($AIR_COUNT + $SPACE_COUNT + $DEFENSE_COUNT + $GROUND_COUNT + $CROSS_COUNT) * 7))
ACTUAL_TOTAL_CIS=$(($ACTUAL_TOTAL_SYSTEMS * 10))

echo "Systems to create: $ACTUAL_TOTAL_SYSTEMS"
echo "Configuration Items: $ACTUAL_TOTAL_CIS"
echo "Lifecycle Folders: $(($ACTUAL_TOTAL_CIS * 11))"
echo "Estimated time: 1-10 minutes depending on scale"
echo "Required space: ~100-500MB for structure"
echo ""
read -p "Continue? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Create lifecycle phase template
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

# Set default counts if not provided via environment
AIR_COUNT=${AIR_COUNT:-200}
SPACE_COUNT=${SPACE_COUNT:-100}
DEFENSE_COUNT=${DEFENSE_COUNT:-150}
GROUND_COUNT=${GROUND_COUNT:-50}
CROSS_COUNT=${CROSS_COUNT:-60}

# Create AIR domain
echo "✈️ Creating AIR domain ($((AIR_COUNT * 7)) systems)..."
AIR_SEGMENTS=("Airframes" "Mechanical" "Environmental" "Digital_Distributed" "Energy" "Operating_Systems" "Propulsion")
AIR_LETTERS=("F" "M" "E" "D" "N" "O" "P")
for i in ${!AIR_SEGMENTS[@]}; do
    create_segment_systems "AIR" "${AIR_LETTERS[$i]}" "${AIR_SEGMENTS[$i]}" $AIR_COUNT "A" "${AIR_LETTERS[$i]}"
done

# Create SPACE domain
echo "🚀 Creating SPACE domain ($((SPACE_COUNT * 7)) systems)..."
SPACE_SEGMENTS=("Architecture" "Maneuvering" "Environment" "Data_Comm" "Energy_Power" "Operations" "Propulsion")
SPACE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!SPACE_SEGMENTS[@]}; do
    create_segment_systems "SPACE" "${SPACE_LETTERS[$i]}" "${SPACE_SEGMENTS[$i]}" $SPACE_COUNT "S" "${SPACE_LETTERS[$i]}"
done

# Create DEFENSE domain
echo "🛡️ Creating DEFENSE domain ($((DEFENSE_COUNT * 7)) systems)..."
DEFENSE_SEGMENTS=("Armor_Protection" "Munitions" "Electronic_Warfare" "Data_C4ISR" "Energy_Systems" "Operations_Command" "Platform_Mobility")
DEFENSE_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!DEFENSE_SEGMENTS[@]}; do
    create_segment_systems "DEFENSE" "${DEFENSE_LETTERS[$i]}" "${DEFENSE_SEGMENTS[$i]}" $DEFENSE_COUNT "D" "${DEFENSE_LETTERS[$i]}"
done

# Create GROUND domain
echo "🚗 Creating GROUND domain ($((GROUND_COUNT * 7)) systems)..."
GROUND_SEGMENTS=("Architecture_Chassis" "Mobility_Drivetrain" "Environmental" "Digital_Autonomous" "Energy_Hybrid" "Operations_Fleet" "Powertrain")
GROUND_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!GROUND_SEGMENTS[@]}; do
    create_segment_systems "GROUND" "${GROUND_LETTERS[$i]}" "${GROUND_SEGMENTS[$i]}" $GROUND_COUNT "G" "${GROUND_LETTERS[$i]}"
done

# Create CROSS domain
echo "🔄 Creating CROSS domain ($((CROSS_COUNT * 7)) systems)..."
CROSS_SEGMENTS=("Adaptive_Architecture" "Multi_Role" "Extended_Environment" "Distributed_Networks" "Energy_Universal" "Orchestration" "Polymorphic_Propulsion")
CROSS_LETTERS=("A" "M" "E" "D" "N" "O" "P")
for i in ${!CROSS_SEGMENTS[@]}; do
    create_segment_systems "CROSS" "${CROSS_LETTERS[$i]}" "${CROSS_SEGMENTS[$i]}" $CROSS_COUNT "X" "${CROSS_LETTERS[$i]}"
done

# Create statistics file
echo "📊 Generating statistics..."
TOTAL_DIRS=$(find . -type d | wc -l)
TOTAL_FILES=$(find . -type f | wc -l)

# Calculate actual totals
ACTUAL_TOTAL_SYSTEMS=$((($AIR_COUNT + $SPACE_COUNT + $DEFENSE_COUNT + $GROUND_COUNT + $CROSS_COUNT) * 7))
ACTUAL_TOTAL_CIS=$(($ACTUAL_TOTAL_SYSTEMS * 10))

cat > STATISTICS.md << EOF
# AMEDEO-P DT-OPTIM Directory Statistics

Generated: $(date)

## Structure Metrics
- Total Directories: $TOTAL_DIRS
- Total Files: $TOTAL_FILES
- Systems Created: $ACTUAL_TOTAL_SYSTEMS
- Configuration Items: $ACTUAL_TOTAL_CIS
- Lifecycle Folders: $(($ACTUAL_TOTAL_CIS * 11))

## Domain Distribution
- AIR: $(($AIR_COUNT * 7)) systems ($(($AIR_COUNT * 70)) CIs)
- SPACE: $(($SPACE_COUNT * 7)) systems ($(($SPACE_COUNT * 70)) CIs)
- DEFENSE: $(($DEFENSE_COUNT * 7)) systems ($(($DEFENSE_COUNT * 70)) CIs)
- GROUND: $(($GROUND_COUNT * 7)) systems ($(($GROUND_COUNT * 70)) CIs)
- CROSS: $(($CROSS_COUNT * 7)) systems ($(($CROSS_COUNT * 70)) CIs)
EOF

echo ""
echo "✅ Directory structure build complete!"
echo "📊 Statistics:"
echo "   - Directories created: $TOTAL_DIRS"
echo "   - Files created: $TOTAL_FILES"
echo "   - Total systems: $ACTUAL_TOTAL_SYSTEMS"
echo "   - Total CIs: $ACTUAL_TOTAL_CIS"
echo ""
echo "📁 Structure created in: $(pwd)"
echo ""
echo "Next steps:"
echo "1. pip install -r requirements.txt"
echo "2. python -m pytest tests/"
echo "3. See docs/guides/QUICK_START.md"