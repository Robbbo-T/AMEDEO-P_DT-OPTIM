#!/usr/bin/env python3
"""
Migrate all CI directories to use the correct 11 canonical phases
This script will rename directories and update README files accordingly
"""

import os
import re
from pathlib import Path
from typing import Dict, List

# Mapping from old phase names to new canonical names
PHASE_MAPPING = {
    # From build_41_ampel_structure.py (old incorrect names)
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
    "11-DISPOSAL": "11-Sustainment-Recycle",
    # From shell scripts (partially correct but with wrong 11th phase)
# (Removed redundant identity mappings for canonical phases)
    "11-SUSTAINMENT-RECYCLE-EOL": "11-Sustainment-Recycle",
    "11-Sustainment-Recycle-EOL": "11-Sustainment-Recycle"
}

# Canonical phase names as specified in the problem statement
CANONICAL_PHASES = [
    "01-Requirements",
    "02-Design", 
    "03-Building-Prototyping",
    "04-Executables-Packages",
    "05-Verification-Validation",
    "06-Integration-Qualification",
    "07-Certification-Security",
    "08-Production-Scale",
    "09-Ops-Services",
    "10-MRO",
    "11-Sustainment-Recycle"
]

def find_all_ci_directories(base_path: Path) -> List[Path]:
    """Find all CI directories in the repository"""
    ci_dirs = []
    for ci_dir in base_path.rglob("CI-*"):
        if ci_dir.is_dir():
            ci_dirs.append(ci_dir)
    return ci_dirs

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
    
    print(f"  Updating README.md")
    
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

def validate_ci_structure(ci_dir: Path) -> bool:
    """Validate that CI has correct phase structure"""
    missing_phases = []
    extra_phases = []
    
    existing_phases = set()
    for item in ci_dir.iterdir():
        if item.is_dir() and item.name.startswith(("01-", "02-", "03-", "04-", "05-", "06-", "07-", "08-", "09-", "10-", "11-")):
            existing_phases.add(item.name)
    
    canonical_phases_set = set(CANONICAL_PHASES)
    
    missing_phases = canonical_phases_set - existing_phases
    extra_phases = existing_phases - canonical_phases_set
    
    if missing_phases:
        print(f"  MISSING phases: {sorted(missing_phases)}")
    if extra_phases:
        print(f"  EXTRA phases: {sorted(extra_phases)}")
    
    return len(missing_phases) == 0 and len(extra_phases) == 0

def main():
    """Main migration function"""
    base_path = Path("/home/runner/work/AMEDEO-P_DT-OPTIM/AMEDEO-P_DT-OPTIM/03-TECHNICAL-AMEDEO-P")
    
    if not base_path.exists():
        print(f"ERROR: Base path does not exist: {base_path}")
        return
    
    print("Starting CI phase migration...")
    print(f"Base path: {base_path}")
    
    # Find all CI directories
    ci_dirs = find_all_ci_directories(base_path)
    print(f"Found {len(ci_dirs)} CI directories")
    
    # Process each CI directory
    successful_migrations = 0
    failed_migrations = 0
    
    for i, ci_dir in enumerate(ci_dirs, 1):
        try:
            if i % 100 == 0:
                print(f"\nProgress: {i}/{len(ci_dirs)} CIs processed")
            
            # Migrate phase directories
            changes = migrate_ci_phases(ci_dir)
            
            # Update README if there were changes
            if changes:
                update_ci_readme(ci_dir, changes)
            
            # Validate final structure
            if validate_ci_structure(ci_dir):
                successful_migrations += 1
            else:
                failed_migrations += 1
                
        except Exception as e:
            print(f"ERROR processing {ci_dir}: {e}")
            failed_migrations += 1
    
    print("\nMigration completed:")
    print(f"  Successful: {successful_migrations}")
    print(f"  Failed: {failed_migrations}")
    print(f"  Total: {len(ci_dirs)}")
    
    # Final validation
    print("\nPerforming final validation...")
    sample_ci = ci_dirs[0] if ci_dirs else None
    if sample_ci:
        print(f"Sample CI structure ({sample_ci}):")
        for item in sorted(sample_ci.iterdir()):
            if item.is_dir():
                print(f"  {item.name}")

if __name__ == "__main__":
    main()