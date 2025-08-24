#!/usr/bin/env python3
"""
AMEDEO-P DT-OPTIM Framework Initialization Script
Initializes the framework in different modes
"""

import argparse
import os
import subprocess
import sys
from pathlib import Path

def main():
    parser = argparse.ArgumentParser(description='Initialize AMEDEO-P DT-OPTIM Framework')
    parser.add_argument('--mode', choices=['reference', 'minimal', 'sample', 'full'], 
                       default='reference', help='Initialization mode')
    parser.add_argument('--skip-build', action='store_true', 
                       help='Skip directory structure build')
    
    args = parser.parse_args()
    
    print(f"🚀 Initializing AMEDEO-P DT-OPTIM Framework in {args.mode} mode")
    
    # Check if we're in the right directory
    if not Path('build_structure.sh').exists():
        print("❌ Error: build_structure.sh not found. Run from repository root.")
        sys.exit(1)
    
    # Install dependencies if requirements.txt exists
    if Path('requirements.txt').exists():
        print("📦 Installing dependencies...")
        try:
            subprocess.run([sys.executable, '-m', 'pip', 'install', '-r', 'requirements.txt'], 
                         check=True, capture_output=True)
            print("✅ Dependencies installed successfully")
        except subprocess.CalledProcessError as e:
            print(f"⚠️  Warning: Failed to install dependencies: {e}")
    
    # Build directory structure unless skipped
    if not args.skip_build:
        print(f"🏗️  Building directory structure in {args.mode} mode...")
        
        # Map modes to build script modes
        mode_map = {
            'reference': 'minimal',
            'minimal': 'minimal', 
            'sample': 'sample',
            'full': 'full'
        }
        
        build_mode = mode_map.get(args.mode, 'minimal')
        
        try:
            # Make sure scripts are executable
            os.chmod('build_structure.sh', 0o755)
            os.chmod('scripts/build_with_modes.sh', 0o755)
            
            # Run build script
            subprocess.run(['./scripts/build_with_modes.sh', '--mode', build_mode, '--non-interactive'], 
                         check=True)
            print("✅ Directory structure built successfully")
        except subprocess.CalledProcessError as e:
            print(f"❌ Error building structure: {e}")
            sys.exit(1)
    
    # Run validation
    print("🔍 Validating structure...")
    try:
        subprocess.run(['./validate_structure.sh'], check=True, capture_output=True)
        print("✅ Structure validation passed")
    except subprocess.CalledProcessError:
        print("⚠️  Warning: Structure validation failed")
    
    print("\n🎉 Framework initialization complete!")
    print("\nNext steps:")
    print("1. Explore the generated structure in 03-TECHNICAL-AMEDEO-P/")
    print("2. Review documentation in docs/")
    print("3. Run tests with: python -m pytest tests/")
    print("4. See docs/guides/QUICK_START.md for usage instructions")

if __name__ == '__main__':
    main()