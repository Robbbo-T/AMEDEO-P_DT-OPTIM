#!/bin/bash
# Quick Build Modes Script
# Version: 1.0.0
# Purpose: Provides easy access to different build modes

echo "🚀 AMEDEO-P DT-OPTIM Quick Build Options"
echo "======================================="
echo ""
echo "Select a build mode:"
echo "1) Minimal  - 35 systems (1 per segment)"
echo "2) Sample   - 392 systems (10% of full)"
echo "3) Full     - 3,920 systems (complete)"
echo "4) Custom   - Specify parameters"
echo ""
read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo "Building minimal structure..."
        ./build_structure.sh --mode minimal
        ;;
    2)
        echo "Building sample structure..."
        ./build_structure.sh --mode sample
        ;;
    3)
        echo "Building full structure..."
        ./build_structure.sh --mode full
        ;;
    4)
        echo "Custom mode - edit build_structure.sh directly"
        echo "Available parameters:"
        echo "  --mode [minimal|sample|full]"
        echo "  --non-interactive"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac