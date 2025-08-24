#!/bin/bash
# AMEDEO-P DT-OPTIM Structure Validation Script
# Version: 3.0.0
# Purpose: Validates the created directory structure and reports statistics

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default values
VALIDATION_LEVEL="standard"
VERBOSE="false"
OUTPUT_FORMAT="console"
REPORT_FILE="validation_report.txt"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --level)
            VALIDATION_LEVEL="$2"
            shift 2
            ;;
        --verbose|-v)
            VERBOSE="true"
            shift
            ;;
        --output)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        --report)
            REPORT_FILE="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --level LEVEL    Validation level: quick, standard, thorough (default: standard)"
            echo "  --verbose,-v     Show detailed output"
            echo "  --output FORMAT  Output format: console, json, markdown (default: console)"
            echo "  --report FILE    Save report to file (default: validation_report.txt)"
            echo "  --help,-h        Show this help message"
            echo ""
            echo "Validation Levels:"
            echo "  quick    - Basic structure check (fast)"
            echo "  standard - Check structure and counts (medium)"
            echo "  thorough - Deep validation with all files (slow)"
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Header
echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     AMEDEO-P DT-OPTIM Structure Validation v3.0.0     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "Validation Level: ${CYAN}$VALIDATION_LEVEL${NC}"
echo -e "Start Time: ${CYAN}$(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo ""

# Initialize counters
ERRORS=0
WARNINGS=0
TOTAL_DOMAINS=0
TOTAL_SEGMENTS=0
TOTAL_SYSTEMS=0
TOTAL_CAS=0
TOTAL_CIS=0
TOTAL_LIFECYCLE=0

# Expected structure based on build mode
declare -A EXPECTED_SYSTEMS
EXPECTED_SYSTEMS["AIR"]=1400
EXPECTED_SYSTEMS["SPACE"]=700
EXPECTED_SYSTEMS["DEFENSE"]=1050
EXPECTED_SYSTEMS["GROUND"]=350
EXPECTED_SYSTEMS["CROSS"]=420

# Domain segments mapping
declare -A DOMAIN_SEGMENTS
DOMAIN_SEGMENTS["AIR"]="Airframes Mechanical Environmental Digital_Distributed Energy Operating_Systems Propulsion"
DOMAIN_SEGMENTS["SPACE"]="Architecture Maneuvering Environment Data_Comm Energy_Power Operations Propulsion"
DOMAIN_SEGMENTS["DEFENSE"]="Armor_Protection Munitions Electronic_Warfare Data_C4ISR Energy_Systems Operations_Command Platform_Mobility"
DOMAIN_SEGMENTS["GROUND"]="Architecture_Chassis Mobility_Drivetrain Environmental Digital_Autonomous Energy_Hybrid Operations_Fleet Powertrain"
DOMAIN_SEGMENTS["CROSS"]="Adaptive_Architecture Multi_Role Extended_Environment Distributed_Networks Energy_Universal Orchestration Polymorphic_Propulsion"

# Function to print progress
print_progress() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "${CYAN}[$(date '+%H:%M:%S')]${NC} $1"
    fi
}

# Function to check domain
check_domain() {
    local domain=$1
    local expected_segments=$2
    
    echo -e "\n${CYAN}Checking $domain Domain...${NC}"
    
    if [ ! -d "03-TECHNICAL-AMEDEO-P/$domain" ]; then
        echo -e "${RED}  ❌ $domain domain directory missing${NC}"
        ERRORS=$((ERRORS + 1))
        return 1
    fi
    
    TOTAL_DOMAINS=$((TOTAL_DOMAINS + 1))
    
    # Check segments
    local segment_count=0
    for segment in $expected_segments; do
        if [ -d "03-TECHNICAL-AMEDEO-P/$domain/$segment" ]; then
            segment_count=$((segment_count + 1))
            print_progress "  ✓ Segment $segment exists"
            
            if [[ "$VALIDATION_LEVEL" != "quick" ]]; then
                # Count systems in segment
                local systems=$(find "03-TECHNICAL-AMEDEO-P/$domain/$segment" -name "System-*" -type d 2>/dev/null | wc -l)
                TOTAL_SYSTEMS=$((TOTAL_SYSTEMS + systems))
                print_progress "    Found $systems systems"
            fi
        else
            echo -e "${YELLOW}  ⚠️  Segment $segment missing${NC}"
            WARNINGS=$((WARNINGS + 1))
        fi
    done
    
    TOTAL_SEGMENTS=$((TOTAL_SEGMENTS + segment_count))
    
    # Summary for domain
    if [[ "$VALIDATION_LEVEL" != "quick" ]]; then
        local domain_systems=$(find "03-TECHNICAL-AMEDEO-P/$domain" -name "System-*" -type d 2>/dev/null | wc -l)
        local domain_cis=$(find "03-TECHNICAL-AMEDEO-P/$domain" -name "CI-*" -type d 2>/dev/null | wc -l)
        
        echo -e "${GREEN}  ✅ $domain: $segment_count/7 segments, $domain_systems systems, $domain_cis CIs${NC}"
        
        # Check if counts match expected (if in standard/thorough mode)
        if [[ "$VALIDATION_LEVEL" == "thorough" ]]; then
            local expected=${EXPECTED_SYSTEMS[$domain]}
            if [ "$domain_systems" -ne "$expected" ]; then
                echo -e "${YELLOW}  ⚠️  Expected $expected systems, found $domain_systems${NC}"
                WARNINGS=$((WARNINGS + 1))
            fi
        fi
    else
        echo -e "${GREEN}  ✅ $domain domain exists with $segment_count segments${NC}"
    fi
}

# Function to validate CI naming convention
validate_ci_naming() {
    local ci_path=$1
    local ci_name=$(basename "$ci_path")
    
    # Expected pattern: CI-{Domain}{Segment}{System:03d}-{Item:03d}
    if [[ ! "$ci_name" =~ ^CI-[ASDGX][AMEDOP][0-9]{3}-[0-9]{3}$ ]]; then
        echo -e "${YELLOW}  ⚠️  Invalid CI naming: $ci_name${NC}"
        WARNINGS=$((WARNINGS + 1))
        return 1
    fi
    return 0
}

# Function to check lifecycle phases
check_lifecycle_phases() {
    local ci_path=$1
    local phases=(
        "01-REQUIREMENTS"
        "02-DESIGN"
        "03-BUILDING-PROTOTYPING"
        "04-EXECUTABLES-PACKAGES"
        "05-VERIFICATION-VALIDATION"
        "06-INTEGRATION-QUALIFICATION"
        "07-CERTIFICATION-SECURITY"
        "08-PRODUCTION-SCALE"
        "09-OPS-SERVICES"
        "10-MRO"
        "11-SUSTAINMENT-RECYCLE-EOL"
    )
    
    local phase_count=0
    for phase in "${phases[@]}"; do
        if [ -d "$ci_path/$phase" ]; then
            phase_count=$((phase_count + 1))
            if [ -f "$ci_path/$phase/README.md" ]; then
                print_progress "      ✓ $phase with README"
            else
                print_progress "      ✓ $phase (no README)"
            fi
        else
            if [[ "$VALIDATION_LEVEL" == "thorough" ]]; then
                echo -e "${RED}      ❌ Missing phase: $phase${NC}"
                ERRORS=$((ERRORS + 1))
            fi
        fi
    done
    
    TOTAL_LIFECYCLE=$((TOTAL_LIFECYCLE + phase_count))
    return 0
}

# Main validation
echo -e "${BLUE}═══ Starting Validation ═══${NC}"

# 1. Check framework directories
echo -e "\n${CYAN}Checking Framework Structure...${NC}"
FRAMEWORK_DIRS=(
    "00-FRAMEWORK"
    "01-ORGANIZATIONAL"
    "02-PROCEDURAL"
    "03-TECHNICAL-AMEDEO-P"
    "04-INTELLIGENT-MACHINE"
    "docs"
    "scripts"
    "config"
)

for dir in "${FRAMEWORK_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo -e "${GREEN}  ✅ $dir exists${NC}"
    else
        echo -e "${RED}  ❌ $dir missing${NC}"
        ERRORS=$((ERRORS + 1))
    fi
done

# 2. Check each domain
for domain in AIR SPACE DEFENSE GROUND CROSS; do
    check_domain "$domain" "${DOMAIN_SEGMENTS[$domain]}"
done

# 3. Count total CIs and CAs (if not quick mode)
if [[ "$VALIDATION_LEVEL" != "quick" ]]; then
    echo -e "\n${CYAN}Counting Configuration Items...${NC}"
    TOTAL_CAS=$(find . -name "CA-*" -type d 2>/dev/null | wc -l)
    TOTAL_CIS=$(find . -name "CI-*" -type d 2>/dev/null | wc -l)
    echo -e "${GREEN}  Found $TOTAL_CAS Constituent Assemblies${NC}"
    echo -e "${GREEN}  Found $TOTAL_CIS Configuration Items${NC}"
fi

# 4. Sample validation (thorough mode only)
if [[ "$VALIDATION_LEVEL" == "thorough" ]]; then
    echo -e "\n${CYAN}Performing Deep Validation (sampling)...${NC}"
    
    # Sample 10 random CIs for detailed check
    SAMPLE_CIS=$(find . -name "CI-*" -type d 2>/dev/null | shuf -n 10)
    
    for ci in $SAMPLE_CIS; do
        ci_name=$(basename "$ci")
        print_progress "  Checking $ci_name..."
        
        # Validate naming
        validate_ci_naming "$ci"
        
        # Check lifecycle phases
        check_lifecycle_phases "$ci"
    done
fi

# 5. Check for required files
echo -e "\n${CYAN}Checking Required Files...${NC}"
REQUIRED_FILES=(
    "README.md"
    "requirements.txt"
    "setup.py"
    "config/framework.yaml"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}  ✅ $file exists${NC}"
    else
        echo -e "${YELLOW}  ⚠️  $file missing${NC}"
        WARNINGS=$((WARNINGS + 1))
    fi
done

# Calculate statistics
echo -e "\n${BLUE}═══ Validation Statistics ═══${NC}"
echo ""

# Summary table
echo -e "${CYAN}Structure Summary:${NC}"
echo "┌─────────────────────┬──────────┐"
echo "│ Component           │ Count    │"
echo "├─────────────────────┼──────────┤"
printf "│ Domains             │ %8d │\n" $TOTAL_DOMAINS
printf "│ Segments            │ %8d │\n" $TOTAL_SEGMENTS
printf "│ Systems             │ %8d │\n" $TOTAL_SYSTEMS
printf "│ Constituent Assem.  │ %8d │\n" $TOTAL_CAS
printf "│ Config Items        │ %8d │\n" $TOTAL_CIS
if [[ "$VALIDATION_LEVEL" == "thorough" ]]; then
    printf "│ Lifecycle Phases    │ %8d │\n" $TOTAL_LIFECYCLE
fi
echo "└─────────────────────┴──────────┘"

# Disk usage
if command -v du &> /dev/null; then
    DISK_USAGE=$(du -sh . 2>/dev/null | cut -f1)
    echo -e "\n${CYAN}Disk Usage:${NC} $DISK_USAGE"
fi

# File counts
TOTAL_DIRS=$(find . -type d 2>/dev/null | wc -l)
TOTAL_FILES=$(find . -type f 2>/dev/null | wc -l)
echo -e "${CYAN}Total Directories:${NC} $TOTAL_DIRS"
echo -e "${CYAN}Total Files:${NC} $TOTAL_FILES"

# Validation result
echo -e "\n${BLUE}═══ Validation Result ═══${NC}"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}╔════════════════════════════╗${NC}"
    echo -e "${GREEN}║   ✅ VALIDATION PASSED!    ║${NC}"
    echo -e "${GREEN}╚════════════════════════════╝${NC}"
    EXIT_CODE=0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}╔════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║  ⚠️  VALIDATION PASSED WITH WARNINGS ║${NC}"
    echo -e "${YELLOW}╚════════════════════════════════════╝${NC}"
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
    EXIT_CODE=0
else
    echo -e "${RED}╔════════════════════════════╗${NC}"
    echo -e "${RED}║   ❌ VALIDATION FAILED!    ║${NC}"
    echo -e "${RED}╚════════════════════════════╝${NC}"
    echo -e "${RED}Errors: $ERRORS${NC}"
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
    EXIT_CODE=1
fi

# Generate report if requested
if [[ "$OUTPUT_FORMAT" == "json" ]]; then
    cat > "$REPORT_FILE" << EOF
{
    "validation_date": "$(date -Iseconds)",
    "validation_level": "$VALIDATION_LEVEL",
    "result": $([ $EXIT_CODE -eq 0 ] && echo '"passed"' || echo '"failed"'),
    "statistics": {
        "domains": $TOTAL_DOMAINS,
        "segments": $TOTAL_SEGMENTS,
        "systems": $TOTAL_SYSTEMS,
        "constituent_assemblies": $TOTAL_CAS,
        "configuration_items": $TOTAL_CIS,
        "lifecycle_phases": $TOTAL_LIFECYCLE,
        "total_directories": $TOTAL_DIRS,
        "total_files": $TOTAL_FILES
    },
    "issues": {
        "errors": $ERRORS,
        "warnings": $WARNINGS
    }
}
EOF
    echo -e "\n${CYAN}JSON report saved to: $REPORT_FILE${NC}"
elif [[ "$OUTPUT_FORMAT" == "markdown" ]]; then
    cat > "$REPORT_FILE" << EOF
# AMEDEO-P DT-OPTIM Validation Report

**Date**: $(date '+%Y-%m-%d %H:%M:%S')  
**Level**: $VALIDATION_LEVEL  
**Result**: $([ $EXIT_CODE -eq 0 ] && echo '✅ PASSED' || echo '❌ FAILED')

## Statistics

| Component | Count |
|-----------|-------|
| Domains | $TOTAL_DOMAINS |
| Segments | $TOTAL_SEGMENTS |
| Systems | $TOTAL_SYSTEMS |
| Constituent Assemblies | $TOTAL_CAS |
| Configuration Items | $TOTAL_CIS |
| Lifecycle Phases | $TOTAL_LIFECYCLE |
| Total Directories | $TOTAL_DIRS |
| Total Files | $TOTAL_FILES |

## Issues

- **Errors**: $ERRORS
- **Warnings**: $WARNINGS

## Disk Usage

$DISK_USAGE
EOF
    echo -e "\n${CYAN}Markdown report saved to: $REPORT_FILE${NC}"
fi

echo ""
echo -e "End Time: ${CYAN}$(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo ""

exit $EXIT_CODE