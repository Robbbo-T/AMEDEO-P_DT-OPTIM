#!/bin/bash
# AMEDEO-P DT-OPTIM Setup Script
# Version: 3.0.0
# Purpose: Sets up the development environment

set -e

echo "🔧 AMEDEO-P DT-OPTIM Setup"
echo "=========================="

# Check Python version
echo "Checking Python version..."
python3 --version || {
    echo "❌ Python 3.9+ required"
    exit 1
}

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Make scripts executable
echo "Setting up scripts..."
chmod +x build_structure.sh
chmod +x validate_structure.sh

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. source venv/bin/activate"
echo "2. ./build_structure.sh"
echo "3. ./validate_structure.sh"