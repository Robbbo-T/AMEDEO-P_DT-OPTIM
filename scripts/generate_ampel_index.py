#!/usr/bin/env python3
"""
AMPEL ARCHITECTURES Index Generator
Generates searchable index and documentation for all 200 systems
"""

import json
import yaml
from pathlib import Path
from typing import Dict, List, Tuple, Optional
import sys

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

def generate_ampel_index() -> List[Dict]:
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

def save_index(index: List[Dict], output_dir: Path) -> Dict:
    """Save index in multiple formats"""
    
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Save as JSON
    with open(output_dir / "ampel_index.json", "w") as f:
        json.dump(index, f, indent=2)
    print("✅ JSON index saved")
    
    # Save as YAML
    with open(output_dir / "ampel_index.yaml", "w") as f:
        yaml.dump(index, f, default_flow_style=False)
    print("✅ YAML index saved")
    
    # Save as CSV with error handling
    try:
        import pandas as pd
        df = pd.DataFrame(index)
        # Flatten the configuration_items list for CSV
        df['configuration_items'] = df['configuration_items'].apply(lambda x: ', '.join(x))
        df.to_csv(output_dir / "ampel_index.csv", index=False)
        print("✅ CSV index saved")
    except ImportError:
        print("⚠️  pandas is not installed. Skipping CSV export.")
        print("   Install with: pip install pandas")
    except Exception as e:
        print(f"⚠️  Failed to export CSV: {e}")
    
    # Generate statistics
    stats = {
        "total_systems": len(index),
        "total_cis": sum(item["total_cis"] for item in index),
        "total_folders": sum(item["total_folders"] for item in index),
        "categories": len(AMPEL_ARCHITECTURES),
        "architecture_types": sum(
            len(archs) for archs in AMPEL_ARCHITECTURES.values()
        ),
        "systems_by_category": {}
    }
    
    # Count systems per category
    for category in AMPEL_ARCHITECTURES:
        stats["systems_by_category"][category] = sum(
            1 for item in index if item["category"] == category
        )
    
    with open(output_dir / "ampel_statistics.json", "w") as f:
        json.dump(stats, f, indent=2)
    print("✅ Statistics saved")
    
    return stats

def generate_markdown_report(index: List[Dict], output_dir: Path):
    """Generate a markdown report of the AMPEL index"""
    
    report = ["# AMPEL ARCHITECTURES Index Report\n"]
    report.append(f"Generated: {Path.cwd()}\n")
    report.append(f"Total Systems: {len(index)}\n\n")
    
    report.append("## System Distribution by Category\n\n")
    
    current_category = None
    for item in index:
        if item["category"] != current_category:
            current_category = item["category"]
            report.append(f"\n### {current_category}\n\n")
            report.append("| System ID | Architecture | CA | CIs |\n")
            report.append("|-----------|--------------|----|----- |\n")
        
        report.append(
            f"| {item['system_id']} | "
            f"{item['architecture_name']} | "
            f"{item['constituent_assembly']} | "
            f"{item['total_cis']} |\n"
        )
    
    with open(output_dir / "ampel_index_report.md", "w") as f:
        f.writelines(report)
    
    print("✅ Markdown report saved")

def validate_index(index: List[Dict]) -> bool:
    """Validate the generated index for completeness"""
    
    print("\n🔍 Validating index...")
    
    # Check for 200 systems
    if len(index) != 200:
        print(f"❌ Expected 200 systems, found {len(index)}")
        return False
    
    # Check system numbering continuity
    system_numbers = sorted([item["system_number"] for item in index])
    expected_numbers = list(range(1, 201))
    
    if system_numbers != expected_numbers:
        missing = set(expected_numbers) - set(system_numbers)
        if missing:
            print(f"❌ Missing system numbers: {missing}")
        return False
    
    # Check architecture codes
    all_codes = set()
    for category in AMPEL_ARCHITECTURES.values():
        all_codes.update(category.keys())
    
    index_codes = set(item["architecture_code"] for item in index)
    
    if all_codes != index_codes:
        print(f"❌ Architecture code mismatch")
        return False
    
    print("✅ Index validation passed")
    return True

def main():
    """Main execution function"""
    
    print("=" * 60)
    print("AMPEL ARCHITECTURES Index Generator")
    print("=" * 60)
    print()
    
    # Set base directory
    base_dir = Path("03-TECHNICAL-AMEDEO-P/AIR/Airframes/AMPEL-REGISTRY")
    
    # Generate index
    print("📊 Generating AMPEL index...")
    index = generate_ampel_index()
    
    # Validate index
    if not validate_index(index):
        print("❌ Index validation failed!")
        sys.exit(1)
    
    # Save index in multiple formats
    print(f"\n💾 Saving to {base_dir}...")
    stats = save_index(index, base_dir)
    
    # Generate markdown report
    generate_markdown_report(index, base_dir)
    
    # Display statistics
    print("\n" + "=" * 60)
    print("📊 AMPEL Statistics:")
    print("=" * 60)
    for key, value in stats.items():
        if key == "systems_by_category":
            print(f"\nSystems by Category:")
            for cat, count in value.items():
                print(f"  {cat}: {count:,}")
        else:
            print(f"{key}: {value:,}")
    
    print("\n" + "=" * 60)
    print("✅ AMPEL Index generation complete!")
    print("=" * 60)

if __name__ == "__main__":
    main()

