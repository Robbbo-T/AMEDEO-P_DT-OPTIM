#!/usr/bin/env python3
"""
AMPEL ARCHITECTURES Index Generator
Generates searchable index and documentation for all 200 systems
"""

import json
import yaml
from pathlib import Path
from typing import Dict, List, Tuple
import pandas as pd

# AMPEL Architecture definitions
AMPEL_ARCHITECTURES = {
    "AMPEL-U": {
        "UNI": ("Universal", 20, range(1, 21))
    },
    "AMPEL-C": {
        "TUW": ("Tube-and-Wing", 15, range(21, 36)),
        "BWB": ("Blended Wing Body", 12, range(36, 48)),
        "HWB": ("Hybrid Wing Body", 8, range(48, 56)),
        "FLW": ("Flying Wing", 10, range(56, 66)),
        "TBW": ("Truss-Braced Wing", 8, range(66, 74)),
        "BOX": ("Box Wing", 6, range(74, 80)),
        "JOW": ("Joined Wing", 5, range(80, 85)),
        "TDW": ("Tandem Wing", 6, range(85, 91)),
        "CAN": ("Canard", 5, range(91, 96)),
        "TSF": ("Three-Surface", 5, range(96, 101))
    },
    "AMPEL-D": {
        "DEL": ("Delta Wing", 8, range(101, 109)),
        "VGW": ("Variable Geometry", 6, range(109, 115)),
        "FSW": ("Forward-Swept Wing", 4, range(115, 119)),
        "OBW": ("Oblique Wing", 3, range(119, 122)),
        "CSW": ("Compound Swept", 4, range(122, 126))
    },
    "AMPEL-M": {
        "BIP": ("Biplane", 5, range(126, 131)),
        "TRP": ("Triplane", 5, range(131, 136)),
        "MUP": ("Multi-plane", 5, range(136, 141)),
        "STP": ("Staggered", 5, range(141, 146)),
        "CHW": ("Channel Wing", 5, range(146, 151))
    },
    "AMPEL-N": {
        "RNG": ("Ring Wing", 4, range(151, 155)),
        "ANN": ("Annular", 4, range(155, 159)),
        "LFB": ("Lifting Body", 4, range(159, 163)),
        "WIG": ("Wing-in-Ground", 4, range(163, 167)),
        "DUC": ("Ducted", 4, range(167, 171))
    },
    "AMPEL-P": {
        "DPW": ("Distributed Propulsion", 3, range(171, 174)),
        "BLI": ("Boundary Layer Ingestion", 3, range(174, 177)),
        "PJW": ("Propulsive Joined Wing", 3, range(177, 180)),
        "FAN": ("Fan Wing", 3, range(180, 183)),
        "CYC": ("Cycloidal", 3, range(183, 186))
    },
    "AMPEL-A": {
        "MOR": ("Morphing Wing", 2, range(186, 188)),
        "ADP": ("Adaptive", 2, range(188, 190)),
        "SMT": ("Smart Materials", 2, range(190, 192)),
        "BIO": ("Biomimetic", 2, range(192, 194)),
        "FLD": ("Folding", 2, range(194, 196))
    },
    "AMPEL-V": {
        "TLT": ("Tiltrotor", 1, range(196, 197)),
        "VTL": ("VTOL", 1, range(197, 198)),
        "STO": ("STOL", 1, range(198, 199)),
        "CMP": ("Compound", 1, range(199, 200)),
        "QDR": ("Quadrotor", 1, range(200, 201))
    }
}

def generate_ampel_index():
    """Generate comprehensive AMPEL index"""
    
    index = []
    
    for category, architectures in AMPEL_ARCHITECTURES.items():
        for code, (name, count, systems) in architectures.items():
            for sys_num in systems:
                system_id = f"System-{sys_num:03d}-{code}"
                ca_id = f"CA-AF{sys_num:03d}"
                
                # Generate CI list
                cis = [f"CI-AF{sys_num:03d}-{ci:03d}" for ci in range(1, 11)]
                
                index.append({
                    "system_id": system_id,
                    "system_number": sys_num,
                    "category": category,
                    "architecture_code": code,
                    "architecture_name": name,
                    "constituent_assembly": ca_id,
                    "configuration_items": cis,
                    "total_cis": 10,
                    "lifecycle_phases": 11,
                    "total_folders": 110  # 10 CIs × 11 phases
                })
    
    return index

def save_index(index: List[Dict], output_dir: Path):
    """Save index in multiple formats"""
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Save as JSON
    with open(output_dir / "ampel_index.json", "w") as f:
        json.dump(index, f, indent=2)
    
    # Save as YAML
    with open(output_dir / "ampel_index.yaml", "w") as f:
        yaml.dump(index, f, default_flow_style=False)
    
    # Save as CSV
    df = pd.DataFrame(index)
    df.to_csv(output_dir / "ampel_index.csv", index=False)
    
    # Generate statistics
    stats = {
        "total_systems": len(index),
        "total_cis": sum(item["total_cis"] for item in index),
        "total_folders": sum(item["total_folders"] for item in index),
        "categories": len(AMPEL_ARCHITECTURES),
        "architecture_types": sum(
            len(archs) for archs in AMPEL_ARCHITECTURES.values()
        )
    }
    
    with open(output_dir / "ampel_statistics.json", "w") as f:
        json.dump(stats, f, indent=2)
    
    print(f"✅ AMPEL Index generated with {len(index)} systems")
    print(f"📁 Output saved to {output_dir}")
    
    return stats

if __name__ == "__main__":
    base_dir = Path("03-TECHNICAL-AMEDEO-P/AIR/Airframes/AMPEL-REGISTRY")
    index = generate_ampel_index()
    stats = save_index(index, base_dir)
    
    print("\n📊 AMPEL Statistics:")
    for key, value in stats.items():
        print(f"  {key}: {value:,}")