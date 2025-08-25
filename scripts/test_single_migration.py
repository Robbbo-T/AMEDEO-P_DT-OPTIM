#!/usr/bin/env python3
"""
Test migration script on a single CI directory only
"""

import os
import re
from pathlib import Path
from typing import Dict, List

# Mapping from old phase names to new canonical names
PHASE_MAPPING = {
    "01-REQUIREMENTS": "01-Requirements",
    "02-DESIGN": "02-Design", 
    "03-PROTOTYPING": "03-Building-Prototyping",
    "04-MANUFACTURING": "04-Executables-Packages",
    "05-VERIFICATION": "05-Verification-Validation",
    "06-INTEGRATION": "06-Integration-Qualification", 
    "07-CERTIFICATION": "07-Certification-Security",
    "08-PRODUCTION": "08-Production-Scale",
    "09-OPERATIONS": "09-Ops-Services",
    "10-MAINTENANCE": "10-MRO",
    "11-DISPOSAL": "11-Sustainment-Recycle"
}

def migrate_ci_phases(ci_dir: Path) -> Dict[str, str]:
    """Migrate phase directories within a CI and return mapping of changes"""
    changes = {}
    
    print(f"Processing CI: {ci_dir}")
    
    # Get all phase directories in this CI
    phase_dirs = [d for d in ci_dir.iterdir() if d.is_dir() and d.name != "README.md"]
    
    for phase_dir in phase_dirs:
        old_name = phase_dir.name
        if old_name in PHASE_MAPPING:
            new_name = PHASE_MAPPING[old_name]
            if old_name != new_name:
                new_path = phase_dir.parent / new_name
                print(f"  Renaming: {old_name} -> {new_name}")
                phase_dir.rename(new_path)
                changes[old_name] = new_name
            else:
                print(f"  Already correct: {old_name}")
        else:
            print(f"  WARNING: Unknown phase directory: {old_name}")
    
    return changes

def update_ci_readme(ci_dir: Path, phase_changes: Dict[str, str]) -> None:
    """Update CI README.md file with correct phase names"""
    readme_path = ci_dir / "README.md"
    if not readme_path.exists():
        print(f"  No README.md found in {ci_dir}")
        return
    
    print("  Updating README.md")
    
    try:
        with open(readme_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Replace old phase names in the lifecycle status section
        for old_phase, new_phase in PHASE_MAPPING.items():
            if old_phase != new_phase:
                content = content.replace(f"- [ ] {old_phase}", f"- [ ] {new_phase}")
                content = content.replace(f"- [x] {old_phase}", f"- [x] {new_phase}")
        
        with open(readme_path, 'w', encoding='utf-8') as f:
            f.write(content)
            
    except Exception as e:
        print(f"  ERROR updating README: {e}")

def main():
    # Test on single CI
    test_ci = Path("/home/runner/work/AMEDEO-P_DT-OPTIM/AMEDEO-P_DT-OPTIM/03-TECHNICAL-AMEDEO-P/AIR/AMPEL-22-COMPOUND-HELI/M-MECHANICAL/CA-002-LandingGearMainLeft/CI-003-002-LandingGearMainLeft")
    
    if not test_ci.exists():
        print(f"Test CI not found: {test_ci}")
        return
    
    print("BEFORE migration:")
    for item in sorted(test_ci.iterdir()):
        if item.is_dir():
            print(f"  {item.name}")
    
    # Migrate phase directories
    changes = migrate_ci_phases(test_ci)
    
    # Update README if there were changes
    if changes:
        update_ci_readme(test_ci, changes)
    
    print("\nAFTER migration:")
    for item in sorted(test_ci.iterdir()):
        if item.is_dir():
            print(f"  {item.name}")
    
    # Show updated README
    readme_path = test_ci / "README.md"
    if readme_path.exists():
        with open(readme_path, 'r') as f:
            content = f.read()
        print("\nUpdated README lifecycle section:")
        lines = content.split('\n')
        for line in lines:
            if '- [ ]' in line or '- [x]' in line:
                print(f"  {line}")

if __name__ == "__main__":
    main()