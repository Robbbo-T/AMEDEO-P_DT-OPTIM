#!/bin/bash
# AMEDEO-P DT-OPTIM Build Script with Multiple Modes
# Version: 3.0.0

set -e

# Default values
MODE="full"
INTERACTIVE=true

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --mode)
            MODE="$2"
            shift 2
            ;;
        --non-interactive)
            INTERACTIVE=false
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--mode minimal|sample|full] [--non-interactive]"
            echo ""
            echo "Modes:"
            echo "  minimal  - 1 system per segment (35 systems total)"
            echo "  sample   - 10% of full structure (392 systems)"
            echo "  full     - Complete structure (3,920 systems)"
            echo ""
            echo "Options:"
            echo "  --non-interactive  - Skip confirmation prompts"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Set system counts based on mode
case $MODE in
    minimal)
        AIR_COUNT=1; SPACE_COUNT=1; DEFENSE_COUNT=1; GROUND_COUNT=1; CROSS_COUNT=1
        TOTAL_SYSTEMS=35
        ;;
    sample)
        AIR_COUNT=20; SPACE_COUNT=10; DEFENSE_COUNT=15; GROUND_COUNT=5; CROSS_COUNT=6
        TOTAL_SYSTEMS=392
        ;;
    full)
        AIR_COUNT=200; SPACE_COUNT=100; DEFENSE_COUNT=150; GROUND_COUNT=50; CROSS_COUNT=60
        TOTAL_SYSTEMS=3920
        ;;
    *)
        echo "Error: Invalid mode '$MODE'. Use minimal, sample, or full."
        exit 1
        ;;
esac

echo "🚀 AMEDEO-P DT-OPTIM Directory Structure Builder"
echo "================================================="
echo "Mode: $MODE"
echo "Systems to create: $TOTAL_SYSTEMS"
echo "Configuration Items: $((TOTAL_SYSTEMS * 10))"
echo "Lifecycle Folders: $((TOTAL_SYSTEMS * 10 * 11))"
echo ""

if [ "$INTERACTIVE" = true ]; then
    read -p "Continue? (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Run the main build script with the specified counts
export AIR_COUNT SPACE_COUNT DEFENSE_COUNT GROUND_COUNT CROSS_COUNT TOTAL_SYSTEMS

echo "Starting build process..."
chmod +x build_structure.sh
echo "y" | ./build_structure.sh