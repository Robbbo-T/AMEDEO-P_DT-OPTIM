#!/usr/bin/env python3
"""
Test script to validate the 41 AMPEL structure
"""

import os
from pathlib import Path

def test_41_ampel_structure():
    """Test that all 41 AMPEL architectures exist with proper structure"""
    
    print("Testing 41 AMPEL Architecture Structure...")
    
    # Expected AMPEL directories
    expected_ampels = [
        "AMPEL-01-TUW", "AMPEL-02-BWB", "AMPEL-03-JW", "AMPEL-04-BW", "AMPEL-05-TBW",
        "AMPEL-06-FSW", "AMPEL-07-OW", "AMPEL-08-MW", "AMPEL-09-DP", "AMPEL-10-BLI",
        "AMPEL-11-CANARD", "AMPEL-12-TANDEM", "AMPEL-13-TSA", "AMPEL-14-TAILLESS", 
        "AMPEL-15-DELTA", "AMPEL-16-VGW", "AMPEL-17-LIFTING-BODY", "AMPEL-18-HYBRID-AIRSHIP",
        "AMPEL-19-VTOL-JET", "AMPEL-20-TILTROTOR", "AMPEL-21-TILTWING", "AMPEL-22-COMPOUND-HELI",
        "AMPEL-23-AUTOGYRO", "AMPEL-24-CYCLOGYRO", "AMPEL-25-ORNITHOPTER", "AMPEL-26-STOL",
        "AMPEL-27-AMPHIBIOUS", "AMPEL-28-GROUND-EFFECT", "AMPEL-29-SUPERSONIC", "AMPEL-30-HYPERSONIC",
        "AMPEL-31-ELECTRIC-FIXED", "AMPEL-32-ELECTRIC-ROTARY", "AMPEL-33-HYDROGEN-TUBE", 
        "AMPEL-34-HYDROGEN-BWB", "AMPEL-35-SOLAR", "AMPEL-36-NUCLEAR", "AMPEL-37-BIPLANE",
        "AMPEL-38-TRIPLANE", "AMPEL-39-CHANNEL-WING", "AMPEL-40-RING-WING", "AMPEL-41-MODULAR"
    ]
    
    # Expected segments in each AMPEL
    expected_segments = [
        "A-AIRFRAMES", "M-MECHANICAL", "E-ENVIRONMENTAL", 
        "D-DIGITAL", "E-ENERGY", "O-OPERATING", "P-PROPULSION"
    ]
    
    # Expected lifecycle phases
    expected_phases = [
        "01-REQUIREMENTS", "02-DESIGN", "03-PROTOTYPING", "04-MANUFACTURING",
        "05-VERIFICATION", "06-INTEGRATION", "07-CERTIFICATION", "08-PRODUCTION",
        "09-OPERATIONS", "10-MAINTENANCE", "11-DISPOSAL"
    ]
    
    base_path = Path("03-TECHNICAL-AMEDEO-P/AIR")
    
    # Test 1: Check all 41 AMPEL directories exist
    print(f"\n1. Checking 41 AMPEL directories...")
    missing_ampels = []
    for ampel in expected_ampels:
        ampel_path = base_path / ampel
        if not ampel_path.exists():
            missing_ampels.append(ampel)
        else:
            print(f"   ✅ {ampel}")
    
    if missing_ampels:
        print(f"   ❌ Missing AMPELs: {missing_ampels}")
        return False
    
    print(f"   ✅ All 41 AMPEL directories found")
    
    # Test 2: Check segments in first AMPEL
    print(f"\n2. Checking AMEDEO-P segments in AMPEL-01-TUW...")
    first_ampel = base_path / "AMPEL-01-TUW"
    missing_segments = []
    for segment in expected_segments:
        segment_path = first_ampel / segment
        if not segment_path.exists():
            missing_segments.append(segment)
        else:
            print(f"   ✅ {segment}")
    
    if missing_segments:
        print(f"   ❌ Missing segments: {missing_segments}")
        return False
    
    print(f"   ✅ All 7 AMEDEO-P segments found")
    
    # Test 3: Check CA structure in A-AIRFRAMES
    print(f"\n3. Checking Constituent Assembly structure...")
    airframes_path = first_ampel / "A-AIRFRAMES"
    ca_dirs = [d for d in airframes_path.iterdir() if d.is_dir() and d.name.startswith("CA-")]
    print(f"   ✅ Found {len(ca_dirs)} CA directories in A-AIRFRAMES")
    
    # Test 4: Check CI structure in first CA
    if ca_dirs:
        first_ca = ca_dirs[0]
        print(f"\n4. Checking Configuration Items in {first_ca.name}...")
        ci_dirs = [d for d in first_ca.iterdir() if d.is_dir() and d.name.startswith("CI-")]
        print(f"   ✅ Found {len(ci_dirs)} CI directories")
        
        # Test 5: Check lifecycle phases in first CI
        if ci_dirs:
            first_ci = ci_dirs[0]
            print(f"\n5. Checking lifecycle phases in {first_ci.name}...")
            missing_phases = []
            for phase in expected_phases:
                phase_path = first_ci / phase
                if not phase_path.exists():
                    missing_phases.append(phase)
                else:
                    print(f"   ✅ {phase}")
            
            if missing_phases:
                print(f"   ❌ Missing phases: {missing_phases}")
                return False
            
            print(f"   ✅ All 11 lifecycle phases found")
    
    # Test 6: Count total structure
    print(f"\n6. Counting structure statistics...")
    total_ampels = len([d for d in base_path.iterdir() if d.is_dir() and d.name.startswith("AMPEL-")])
    print(f"   ✅ Total AMPEL architectures: {total_ampels}")
    
    # Count total directories recursively
    total_dirs = sum(1 for _ in base_path.rglob("*") if _.is_dir())
    print(f"   ✅ Total directories created: {total_dirs:,}")
    
    # Count README files
    total_readmes = sum(1 for _ in base_path.rglob("README.md"))
    print(f"   ✅ Total README files: {total_readmes:,}")
    
    print(f"\n✅ 41 AMPEL Architecture Structure Validation: PASSED")
    return True

if __name__ == "__main__":
    success = test_41_ampel_structure()
    exit(0 if success else 1)