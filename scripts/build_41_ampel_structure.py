#!/usr/bin/env python3
"""
Build 41 AMPEL Architectures Structure
Creates the complete AMPEL-01-TUW through AMPEL-41-MODULAR structure
as specified in the problem statement
"""

import os
from pathlib import Path
from typing import Dict, List, Tuple

# 41 AMPEL Architectures as specified in the problem statement
AMPEL_41_ARCHITECTURES = [
    ("01", "TUW", "Tube Wing"),
    ("02", "BWB", "Blended Wing Body"),
    ("03", "JW", "Joined Wing"),
    ("04", "BW", "Box Wing"),
    ("05", "TBW", "Truss-Braced Wing"),
    ("06", "FSW", "Forward Swept Wing"),
    ("07", "OW", "Oblique Wing"),
    ("08", "MW", "Morphing Wing"),
    ("09", "DP", "Distributed Propulsion"),
    ("10", "BLI", "Boundary Layer Ingestion"),
    ("11", "CANARD", "Canard Configuration"),
    ("12", "TANDEM", "Tandem Wing"),
    ("13", "TSA", "Three Surface Aircraft"),
    ("14", "TAILLESS", "Tailless"),
    ("15", "DELTA", "Delta Wing"),
    ("16", "VGW", "Variable Geometry Wing"),
    ("17", "LIFTING-BODY", "Lifting Body"),
    ("18", "HYBRID-AIRSHIP", "Hybrid Airship"),
    ("19", "VTOL-JET", "VTOL Jet"),
    ("20", "TILTROTOR", "Tiltrotor"),
    ("21", "TILTWING", "Tiltwing"),
    ("22", "COMPOUND-HELI", "Compound Helicopter"),
    ("23", "AUTOGYRO", "Autogyro"),
    ("24", "CYCLOGYRO", "Cyclogyro"),
    ("25", "ORNITHOPTER", "Ornithopter"),
    ("26", "STOL", "Short Take-Off and Landing"),
    ("27", "AMPHIBIOUS", "Amphibious"),
    ("28", "GROUND-EFFECT", "Ground Effect Vehicle"),
    ("29", "SUPERSONIC", "Supersonic"),
    ("30", "HYPERSONIC", "Hypersonic"),
    ("31", "ELECTRIC-FIXED", "Electric Fixed Wing"),
    ("32", "ELECTRIC-ROTARY", "Electric Rotary Wing"),
    ("33", "HYDROGEN-TUBE", "Hydrogen Tube Wing"),
    ("34", "HYDROGEN-BWB", "Hydrogen BWB"),
    ("35", "SOLAR", "Solar Powered"),
    ("36", "NUCLEAR", "Nuclear Powered"),
    ("37", "BIPLANE", "Biplane"),
    ("38", "TRIPLANE", "Triplane"),
    ("39", "CHANNEL-WING", "Channel Wing"),
    ("40", "RING-WING", "Ring Wing"),
    ("41", "MODULAR", "Modular Reconfigurable")
]

# AMEDEO-P Segments for each AMPEL
AMEDEO_P_SEGMENTS = {
    "A-AIRFRAMES": {
        "description": "Airframes and Structural Components",
        "ca_count": 40,
        "ci_per_ca": 5
    },
    "M-MECHANICAL": {
        "description": "Mechanical Systems",
        "ca_count": 15,
        "ci_per_ca": 5
    },
    "E-ENVIRONMENTAL": {
        "description": "Environmental Control Systems",
        "ca_count": 10,
        "ci_per_ca": 5
    },
    "D-DIGITAL": {
        "description": "Digital and Distributed Systems",
        "ca_count": 12,
        "ci_per_ca": 5
    },
    "E-ENERGY": {
        "description": "Energy and Power Systems",
        "ca_count": 8,
        "ci_per_ca": 5
    },
    "O-OPERATING": {
        "description": "Operating and Organizational Systems",
        "ca_count": 6,
        "ci_per_ca": 5
    },
    "P-PROPULSION": {
        "description": "Propulsion Systems",
        "ca_count": 10,
        "ci_per_ca": 5
    }
}

# Lifecycle phases for each CI
LIFECYCLE_PHASES = [
    "01-REQUIREMENTS",
    "02-DESIGN",
    "03-PROTOTYPING",
    "04-MANUFACTURING",
    "05-VERIFICATION",
    "06-INTEGRATION",
    "07-CERTIFICATION",
    "08-PRODUCTION",
    "09-OPERATIONS",
    "10-MAINTENANCE",
    "11-DISPOSAL"
]

def create_lifecycle_phases(ci_path: Path, ci_name: str, ampel_info: Tuple[str, str, str]):
    """Create 11 lifecycle phases for a CI"""
    ampel_num, ampel_code, ampel_desc = ampel_info
    
    for phase in LIFECYCLE_PHASES:
        phase_path = ci_path / phase
        phase_path.mkdir(parents=True, exist_ok=True)
        
        # Create README for each phase
        readme_content = f"""# {phase}

**Configuration Item**: {ci_name}
**AMPEL Architecture**: AMPEL-{ampel_num}-{ampel_code} ({ampel_desc})
**Phase**: {phase}
**Generated**: {Path.cwd()}

## Phase Objectives
- Define phase-specific goals for {ampel_desc} architecture
- Track progress and deliverables
- Maintain compliance with aerospace standards

## Deliverables
- [ ] Phase documentation
- [ ] Test results (if applicable)
- [ ] Compliance artifacts
- [ ] Review approvals

## Standards Compliance
- DO-178C (Software)
- DO-254 (Hardware)
- ARP4754A (Systems)
- FAA Part 25
- EASA CS-25
"""
        
        with open(phase_path / "README.md", "w") as f:
            f.write(readme_content)

def create_configuration_items(ca_path: Path, ca_name: str, ampel_info: Tuple[str, str, str], ci_count: int):
    """Create Configuration Items for a CA"""
    
    for ci_num in range(1, ci_count + 1):
        ci_name = f"CI-{ci_num:03d}-{ca_name.split('-', 1)[1]}"
        ci_path = ca_path / ci_name
        
        # Create CI directory
        ci_path.mkdir(parents=True, exist_ok=True)
        
        # Create lifecycle phases for this CI
        create_lifecycle_phases(ci_path, ci_name, ampel_info)
        
        # Create CI README
        ampel_num, ampel_code, ampel_desc = ampel_info
        ci_readme = f"""# Configuration Item: {ci_name}

**AMPEL**: AMPEL-{ampel_num}-{ampel_code}
**Architecture**: {ampel_desc}
**Constituent Assembly**: {ca_name}
**Lifecycle Phases**: 11

## CI Overview
Configuration Item for {ampel_desc} architecture component.

## Lifecycle Status
- [ ] 01-REQUIREMENTS
- [ ] 02-DESIGN
- [ ] 03-PROTOTYPING
- [ ] 04-MANUFACTURING
- [ ] 05-VERIFICATION
- [ ] 06-INTEGRATION
- [ ] 07-CERTIFICATION
- [ ] 08-PRODUCTION
- [ ] 09-OPERATIONS
- [ ] 10-MAINTENANCE
- [ ] 11-DISPOSAL

## Compliance
- FAA Part 25
- EASA CS-25
- DO-178C
- DO-254
"""
        
        with open(ci_path / "README.md", "w") as f:
            f.write(ci_readme)

def create_constituent_assemblies(segment_path: Path, segment_name: str, ampel_info: Tuple[str, str, str], ca_count: int, ci_per_ca: int):
    """Create Constituent Assemblies for a segment"""
    
    # Define CA names based on segment type
    ca_names = generate_ca_names(segment_name, ca_count)
    
    for ca_num, ca_name in enumerate(ca_names, 1):
        ca_full_name = f"CA-{ca_num:03d}-{ca_name}"
        ca_path = segment_path / ca_full_name
        
        # Create CA directory
        ca_path.mkdir(parents=True, exist_ok=True)
        
        # Create Configuration Items for this CA
        create_configuration_items(ca_path, ca_full_name, ampel_info, ci_per_ca)
        
        # Create CA README
        ampel_num, ampel_code, ampel_desc = ampel_info
        ca_readme = f"""# Constituent Assembly: {ca_full_name}

**AMPEL**: AMPEL-{ampel_num}-{ampel_code}
**Architecture**: {ampel_desc}
**Segment**: {segment_name}
**Configuration Items**: {ci_per_ca}

## CA Overview
Primary assembly for {ampel_desc} {segment_name.replace('-', ' ').title()} components.

## Configuration Items (CIs)
"""
        
        for ci_num in range(1, ci_per_ca + 1):
            ci_name = f"CI-{ci_num:03d}-{ca_name}"
            ca_readme += f"- {ci_name}\n"
        
        ca_readme += f"""
## Standards Compliance
- FAA Part 25
- EASA CS-25
- DO-178C
- DO-254
"""
        
        with open(ca_path / "README.md", "w") as f:
            f.write(ca_readme)

def generate_ca_names(segment_name: str, ca_count: int) -> List[str]:
    """Generate appropriate CA names based on segment type"""
    
    if segment_name == "A-AIRFRAMES":
        return [
            "FuselageNoseSection", "FuselageForwardSection", "FuselageCenterSection", 
            "FuselageAftSection", "TailConeSection", "WingCenterBox", "WingLeftInner",
            "WingRightInner", "WingLeftOuter", "WingRightOuter", "WingletLeft", 
            "WingletRight", "HorizontalStabilizer", "VerticalStabilizer", "Elevators",
            "Rudder", "AileronsLeft", "AileronsRight", "FlapsInboardLeft", 
            "FlapsInboardRight", "FlapsOutboardLeft", "FlapsOutboardRight", "SlatsLeft",
            "SlatsRight", "SpoilersLeft", "SpoilersRight", "EnginePylonLeft", 
            "EnginePylonRight", "NacelleLeft", "NacelleRight", "ThrustReverserLeft",
            "ThrustReverserRight", "PassengerDoorsFwd", "PassengerDoorsAft", 
            "CargoDoorsFwd", "CargoDoorsAft", "EmergencyExitsLeft", "EmergencyExitsRight",
            "ServicePanels", "AccessPanels"
        ][:ca_count]
    
    elif segment_name == "M-MECHANICAL":
        return [
            "LandingGearNose", "LandingGearMainLeft", "LandingGearMainRight",
            "BrakeSystemLeft", "BrakeSystemRight", "FlightControlActuators",
            "FlightControlCables", "FlightControlPulleys", "TrimActuators",
            "FlapDriveSystem", "SlatDriveSystem", "SpoilerActuators",
            "DoorActuators", "CargoHandlingSystem", "TowingInterface"
        ][:ca_count]
    
    elif segment_name == "E-ENVIRONMENTAL":
        return [
            "AirConditioningPack1", "AirConditioningPack2", "PressurizationSystem",
            "CabinAirDistribution", "AntiIcingSystem", "OxygenSystem",
            "FireSuppressionSystem", "WasteManagement", "WaterSystem", 
            "LightingSystem"
        ][:ca_count]
    
    else:
        # Generic naming for other segments
        return [f"Component{i:02d}" for i in range(1, ca_count + 1)]

def create_ampel_structure(base_path: Path, ampel_info: Tuple[str, str, str]):
    """Create complete structure for one AMPEL architecture"""
    
    ampel_num, ampel_code, ampel_desc = ampel_info
    ampel_name = f"AMPEL-{ampel_num}-{ampel_code}"
    ampel_path = base_path / ampel_name
    
    print(f"Creating {ampel_name} ({ampel_desc})...")
    
    # Create AMPEL directory
    ampel_path.mkdir(parents=True, exist_ok=True)
    
    # Create AMEDEO-P segments
    for segment_name, segment_info in AMEDEO_P_SEGMENTS.items():
        segment_path = ampel_path / segment_name
        segment_path.mkdir(parents=True, exist_ok=True)
        
        # Create Constituent Assemblies for this segment
        create_constituent_assemblies(
            segment_path, 
            segment_name, 
            ampel_info, 
            segment_info["ca_count"], 
            segment_info["ci_per_ca"]
        )
        
        # Create segment README
        segment_readme = f"""# {segment_name.replace('-', ' ').title()}

**AMPEL**: {ampel_name}
**Architecture**: {ampel_desc}
**Description**: {segment_info['description']}
**Constituent Assemblies**: {segment_info['ca_count']}
**Configuration Items per CA**: {segment_info['ci_per_ca']}

## Overview
{segment_info['description']} for {ampel_desc} architecture.

## Structure
- Constituent Assemblies: {segment_info['ca_count']}
- Configuration Items: {segment_info['ca_count'] * segment_info['ci_per_ca']}
- Lifecycle Phases: 11 per CI
- Total Folders: {segment_info['ca_count'] * segment_info['ci_per_ca'] * 11}
"""
        
        with open(segment_path / "README.md", "w") as f:
            f.write(segment_readme)
    
    # Create main AMPEL README
    total_cas = sum(info["ca_count"] for info in AMEDEO_P_SEGMENTS.values())
    total_cis = sum(info["ca_count"] * info["ci_per_ca"] for info in AMEDEO_P_SEGMENTS.values())
    total_folders = total_cis * 11
    
    ampel_readme = f"""# {ampel_name}: {ampel_desc}

## Architecture Overview
{ampel_desc} configuration within the AMEDEO-P Digital Twin framework.

## AMEDEO-P Segments
- **A-AIRFRAMES**: Airframes and Structural Components
- **M-MECHANICAL**: Mechanical Systems  
- **E-ENVIRONMENTAL**: Environmental Control Systems
- **D-DIGITAL**: Digital and Distributed Systems
- **E-ENERGY**: Energy and Power Systems
- **O-OPERATING**: Operating and Organizational Systems
- **P-PROPULSION**: Propulsion Systems

## Structure Summary
- **Total Segments**: {len(AMEDEO_P_SEGMENTS)}
- **Total Constituent Assemblies**: {total_cas}
- **Total Configuration Items**: {total_cis}
- **Total Lifecycle Phases**: {total_folders}

## Compliance Standards
- FAA Part 25 (Transport Category Airplanes)
- EASA CS-25 (Large Aeroplanes)
- DO-178C (Software Considerations)
- DO-254 (Hardware Design Assurance)
- ARP4754A (Systems Development)

## Generated Structure
This structure was automatically generated for the AMEDEO-P DT-OPTIM framework.
"""
    
    with open(ampel_path / "README.md", "w") as f:
        f.write(ampel_readme)

def main():
    """Build complete 41 AMPEL structure"""
    
    print("=" * 80)
    print("Building 41 AMPEL Architectures Structure")
    print("AMEDEO-P DT-OPTIM Framework")
    print("=" * 80)
    print()
    
    # Base path for AIR domain
    base_path = Path("03-TECHNICAL-AMEDEO-P/AIR")
    base_path.mkdir(parents=True, exist_ok=True)
    
    # Create each AMPEL architecture
    for ampel_info in AMPEL_41_ARCHITECTURES:
        create_ampel_structure(base_path, ampel_info)
    
    # Create AIR domain README
    air_readme = f"""# AIR Domain - AMEDEO-P DT-OPTIM

## Overview
Complete implementation of 41 AMPEL (Aircraft Multi-Program Enhanced Lifecycle) architectures.

## AMPEL Architectures ({len(AMPEL_41_ARCHITECTURES)} Total)
"""
    
    for ampel_num, ampel_code, ampel_desc in AMPEL_41_ARCHITECTURES:
        air_readme += f"- **AMPEL-{ampel_num}-{ampel_code}**: {ampel_desc}\n"
    
    total_cas = sum(info["ca_count"] for info in AMEDEO_P_SEGMENTS.values())
    total_cis = sum(info["ca_count"] * info["ci_per_ca"] for info in AMEDEO_P_SEGMENTS.values())
    total_folders = total_cis * 11
    
    air_readme += f"""
## Structure Statistics
- **AMPEL Architectures**: {len(AMPEL_41_ARCHITECTURES)}
- **Segments per AMPEL**: {len(AMEDEO_P_SEGMENTS)}
- **CAs per AMPEL**: {total_cas}
- **CIs per AMPEL**: {total_cis}
- **Total CAs**: {len(AMPEL_41_ARCHITECTURES) * total_cas:,}
- **Total CIs**: {len(AMPEL_41_ARCHITECTURES) * total_cis:,}
- **Total Lifecycle Folders**: {len(AMPEL_41_ARCHITECTURES) * total_folders:,}

## AMEDEO-P Segment Framework
Each AMPEL implements the complete AMEDEO-P framework:
- **A**: Airframes and Structures
- **M**: Mechanical Systems
- **E**: Environmental Systems
- **D**: Digital/Distributed Systems
- **E**: Energy Systems
- **O**: Operating/Organizational Systems
- **P**: Propulsion Systems
"""
    
    with open(base_path / "README.md", "w") as f:
        f.write(air_readme)
    
    print("\n" + "=" * 80)
    print("✅ 41 AMPEL Architectures Structure Complete!")
    print(f"📁 Total AMPELs: {len(AMPEL_41_ARCHITECTURES)}")
    print(f"📁 Total CAs: {len(AMPEL_41_ARCHITECTURES) * total_cas:,}")
    print(f"📁 Total CIs: {len(AMPEL_41_ARCHITECTURES) * total_cis:,}")
    print(f"📁 Total Folders: {len(AMPEL_41_ARCHITECTURES) * total_folders:,}")
    print("=" * 80)

if __name__ == "__main__":
    main()