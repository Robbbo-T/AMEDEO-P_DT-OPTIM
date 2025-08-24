#!/bin/bash
# AMEDEO-P DT-OPTIM Setup Script
# Version: 3.0.0
# Purpose: Sets up the complete development environment

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 AMEDEO-P DT-OPTIM Setup${NC}"
echo "=========================================="
echo "Version: 3.0.0"
echo "Purpose: Framework Environment Setup"
echo ""

# Function to check command existence
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to compare versions
version_gt() {
    test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1";
}

# Check Python installation and version
echo "📋 Checking prerequisites..."

if ! command_exists python3; then
    echo -e "${RED}❌ Python 3 is required but not installed.${NC}"
    echo "Please install Python 3.9 or higher from https://www.python.org/"
    exit 1
fi

# Get Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
PYTHON_FULL_VERSION=$(python3 --version 2>&1)

echo -e "${GREEN}✅ Found Python: $PYTHON_FULL_VERSION${NC}"

# Check if Python version is >= 3.9
if ! version_gt "$PYTHON_VERSION" "3.8"; then
    echo -e "${RED}❌ Python 3.9+ required (found $PYTHON_VERSION)${NC}"
    exit 1
fi

# Check for pip
if ! python3 -m pip --version &> /dev/null; then
    echo -e "${YELLOW}⚠️  pip not found. Installing pip...${NC}"
    python3 -m ensurepip --default-pip
fi

# Check for venv module
if ! python3 -c "import venv" &> /dev/null; then
    echo -e "${RED}❌ Python venv module not found.${NC}"
    echo "Please install: python3-venv (Ubuntu/Debian) or python3-virtualenv"
    exit 1
fi

# Check available disk space
AVAILABLE_SPACE=$(df -h . | awk 'NR==2 {print $4}')
echo -e "${GREEN}✅ Available disk space: $AVAILABLE_SPACE${NC}"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo ""
    echo "📦 Creating virtual environment..."
    python3 -m venv venv
    echo -e "${GREEN}✅ Virtual environment created${NC}"
else
    echo -e "${GREEN}✅ Virtual environment already exists${NC}"
fi

# Activate virtual environment
echo ""
echo "🔄 Activating virtual environment..."
source venv/bin/activate || {
    echo -e "${RED}❌ Failed to activate virtual environment${NC}"
    exit 1
}

# Upgrade pip
echo ""
echo "📥 Upgrading pip..."
pip install --quiet --upgrade pip setuptools wheel

# Install dependencies
echo ""
echo "📥 Installing dependencies..."

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    echo "📝 Creating requirements.txt..."
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

# Optional: ML frameworks
# scikit-learn>=1.0.0
# tensorflow>=2.9.0

# Optional: Data management
# influxdb-client>=1.30.0
# networkx>=2.6.0
EOF
fi

# Install requirements with progress
pip install -r requirements.txt || {
    echo -e "${RED}❌ Failed to install dependencies${NC}"
    echo "Try running: pip install --upgrade -r requirements.txt"
    exit 1
}

echo -e "${GREEN}✅ Dependencies installed successfully${NC}"

# Make scripts executable
echo ""
echo "🔨 Setting up scripts..."

# Create scripts directory if it doesn't exist
mkdir -p scripts

# Make build scripts executable
if [ -f "build_structure.sh" ]; then
    chmod +x build_structure.sh
    echo -e "${GREEN}✅ build_structure.sh is executable${NC}"
fi

# Create validation script if it doesn't exist
if [ ! -f "scripts/validate_structure.sh" ]; then
    echo "📝 Creating validation script..."
    cat > scripts/validate_structure.sh << 'EOFVAL'
#!/bin/bash
# Structure validation script

echo "Validating AMEDEO-P DT-OPTIM Structure..."
echo ""

# Check domains
ERRORS=0
for DOMAIN in AIR SPACE DEFENSE GROUND CROSS; do
    if [ -d "03-TECHNICAL-AMEDEO-P/$DOMAIN" ]; then
        SYSTEMS=$(find "03-TECHNICAL-AMEDEO-P/$DOMAIN" -name "System-*" -type d 2>/dev/null | wc -l)
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

if [ $ERRORS -eq 0 ]; then
    echo ""
    echo "✅ Validation passed!"
    exit 0
else
    echo ""
    echo "❌ Validation failed with $ERRORS errors"
    exit 1
fi
EOFVAL
    chmod +x scripts/validate_structure.sh
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo ""
    echo "📝 Creating .gitignore..."
    cat > .gitignore << 'EOF'
# AMEDEO-P DT-OPTIM .gitignore

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environment
venv/
env/
ENV/
env.bak/
venv.bak/

# Data files
data/synthetic/
*.csv
*.json
*.parquet
*.pkl
*.h5
*.hdf5

# Logs
*.log
logs/

# OS
.DS_Store
Thumbs.db
Desktop.ini

# IDE
.vscode/
.idea/
*.swp
*.swo
*.sublime-*

# Testing
.pytest_cache/
.coverage
htmlcov/
.tox/

# Documentation builds
docs/_build/
docs/.doctrees/

# Jupyter
.ipynb_checkpoints/

# Project specific
STATISTICS.md
test_builds/
temp_builds/

# Keep these
!data/examples/
!data/samples/
!.github/
EOF
    echo -e "${GREEN}✅ .gitignore created${NC}"
fi

# Create .editorconfig if it doesn't exist
if [ ! -f ".editorconfig" ]; then
    echo "📝 Creating .editorconfig..."
    cat > .editorconfig << 'EOF'
# EditorConfig for AMEDEO-P DT-OPTIM
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.py]
indent_style = space
indent_size = 4
max_line_length = 120

[*.{yaml,yml}]
indent_style = space
indent_size = 2

[*.md]
trim_trailing_whitespace = false

[*.sh]
indent_style = space
indent_size = 4

[Makefile]
indent_style = tab
EOF
    echo -e "${GREEN}✅ .editorconfig created${NC}"
fi

# Create directory structure for framework
echo ""
echo "📁 Creating base directories..."
mkdir -p {docs,scripts,tests,data/examples,config,tools,examples}
echo -e "${GREEN}✅ Base directories created${NC}"

# Create a simple test to verify installation
echo ""
echo "🧪 Creating verification script..."
cat > scripts/verify_installation.py << 'EOF'
#!/usr/bin/env python3
"""Verify AMEDEO-P DT-OPTIM installation."""

import sys
import importlib

def check_module(module_name, required=True):
    """Check if a module is installed."""
    try:
        importlib.import_module(module_name)
        print(f"✅ {module_name}: Installed")
        return True
    except ImportError:
        if required:
            print(f"❌ {module_name}: Not installed (REQUIRED)")
        else:
            print(f"⚠️  {module_name}: Not installed (optional)")
        return False

def main():
    """Run installation verification."""
    print("AMEDEO-P DT-OPTIM Installation Verification")
    print("=" * 45)
    
    # Check Python version
    py_version = sys.version_info
    if py_version >= (3, 9):
        print(f"✅ Python version: {py_version.major}.{py_version.minor}.{py_version.micro}")
    else:
        print(f"❌ Python version: {py_version.major}.{py_version.minor} (3.9+ required)")
    
    print("\nCore Dependencies:")
    required_modules = ['numpy', 'pandas', 'matplotlib', 'yaml', 'pytest']
    all_installed = all(check_module(m) for m in required_modules)
    
    print("\nOptional Dependencies:")
    optional_modules = ['qiskit', 'sklearn', 'tensorflow', 'networkx']
    for m in optional_modules:
        check_module(m, required=False)
    
    if all_installed:
        print("\n✅ All required dependencies are installed!")
        print("Ready to build the AMEDEO-P DT-OPTIM structure.")
        return 0
    else:
        print("\n❌ Some required dependencies are missing.")
        print("Run: pip install -r requirements.txt")
        return 1

if __name__ == "__main__":
    sys.exit(main())
EOF

chmod +x scripts/verify_installation.py

# Run verification
echo ""
echo "🧪 Verifying installation..."
python scripts/verify_installation.py

# Create a simple Makefile for common tasks
echo ""
echo "📝 Creating Makefile..."
cat > Makefile << 'EOF'
# AMEDEO-P DT-OPTIM Makefile

.PHONY: help setup build validate test clean

help:
	@echo "AMEDEO-P DT-OPTIM Framework Commands"
	@echo "====================================="
	@echo "make setup    - Set up the environment"
	@echo "make build    - Build the directory structure"
	@echo "make validate - Validate the structure"
	@echo "make test     - Run tests"
	@echo "make clean    - Clean generated files"

setup:
	@./setup.sh

build:
	@./build_structure.sh

validate:
	@./scripts/validate_structure.sh

test:
	@python -m pytest tests/

clean:
	@rm -rf data/synthetic/*
	@rm -rf __pycache__
	@rm -rf .pytest_cache
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@echo "Cleaned generated files"
EOF

# Display summary
echo ""
echo "=========================================="
echo -e "${GREEN}✅ Setup complete!${NC}"
echo "=========================================="
echo ""
echo "Environment Summary:"
echo "  Python: $PYTHON_FULL_VERSION"
echo "  Virtual Environment: $(pwd)/venv"
echo "  Platform: $(uname -s)"
echo ""
echo "Next steps:"
echo ""
echo "1. Activate the virtual environment:"
echo -e "   ${YELLOW}source venv/bin/activate${NC}"
echo ""
echo "2. Build the directory structure:"
echo -e "   ${YELLOW}./build_structure.sh${NC}"
echo "   Options:"
echo "     --mode minimal  (35 systems - for testing)"
echo "     --mode sample   (392 systems - for development)"
echo "     --mode full     (3,920 systems - complete structure)"
echo ""
echo "3. Validate the structure:"
echo -e "   ${YELLOW}./scripts/validate_structure.sh${NC}"
echo ""
echo "4. Read the documentation:"
echo -e "   ${YELLOW}cat docs/guides/QUICK_START.md${NC}"
echo ""
echo "Alternative: Use Make commands:"
echo -e "   ${YELLOW}make build${NC}    - Build structure"
echo -e "   ${YELLOW}make validate${NC} - Validate"
echo -e "   ${YELLOW}make test${NC}     - Run tests"
echo -e "   ${YELLOW}make help${NC}     - Show all commands"
echo ""
echo "=========================================="
echo "Happy coding! 🚀"