#!/usr/bin/env python3
"""
Test migration script on a single CI directory
"""

import os
import shutil
from pathlib import Path

# Test the migration on a single CI
def test_single_ci():
    test_ci = Path("/home/runner/work/AMEDEO-P_DT-OPTIM/AMEDEO-P_DT-OPTIM/03-TECHNICAL-AMEDEO-P/AIR/AMPEL-22-COMPOUND-HELI/M-MECHANICAL/CA-002-LandingGearMainLeft/CI-003-002-LandingGearMainLeft")
    
    if not test_ci.exists():
        print(f"Test CI not found: {test_ci}")
        return
    
    print("Before migration:")
    for item in sorted(test_ci.iterdir()):
        print(f"  {item.name}")
    
    # Read current README
    readme_path = test_ci / "README.md"
    if readme_path.exists():
        with open(readme_path, 'r') as f:
            content = f.read()
        print("\nCurrent README lifecycle section:")
        lines = content.split('\n')
        for line in lines:
            if '- [ ]' in line or '- [x]' in line:
                print(f"  {line}")

if __name__ == "__main__":
    test_single_ci()