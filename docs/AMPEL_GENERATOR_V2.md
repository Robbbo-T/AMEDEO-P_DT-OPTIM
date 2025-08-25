# AMPEL Architecture Index Generator v2.0

## Overview

The AMPEL Architecture Index Generator v2.0 is an enhanced version of the AMPEL architecture framework generator that introduces Technology Readiness Level (TRL) classifications, real-world examples, and comprehensive reporting capabilities for the AIR domain within the AMEDEO-P DT-OPTIM framework.

## Features

### ✨ New in v2.0

- **TRL Classifications**: Each AMPEL architecture is classified by Technology Readiness Level (TRL 1-9 and Historical)
- **Real-World Examples**: Every architecture includes references to actual aircraft, programs, or research projects
- **Enhanced Documentation**: Comprehensive README files with TRL context and navigation
- **Advanced Reporting**: TRL distribution analysis and validation reports
- **Adaptive Structure**: CA/CI counts adapt based on technology maturity (TRL level)
- **Template Systems**: Complete lifecycle phase templates with TRL progression tracking

### 🏗️ Architecture Coverage

The generator creates **43 AMPEL architectures** covering:

#### Operational Systems (TRL 9) - 15 architectures
- Tube Wing (Boeing 737, Airbus A320)
- Canard Configuration (Rafale, Piaggio Avanti)
- Delta Wing (Concorde, Mirage fighters)
- VTOL Jet (Harrier, F-35B)
- And more proven configurations

#### Flight Proven (TRL 7-8) - 8 architectures
- Forward Swept Wing (X-29, Su-47)
- Lifting Body (NASA HL-10, Dream Chaser)
- Compound Helicopter (S-97 Raider)
- Electric Rotary Wing (eVTOL demonstrators)

#### Prototype/Demo (TRL 5-6) - 8 architectures
- Blended Wing Body (NASA X-48)
- Truss-Braced Wing (NASA X-66A)
- Distributed Propulsion (NASA X-57)
- Tiltwing (eVTOL concepts)

#### Research/Concept (TRL 3-4) - 9 architectures
- Joined Wing (conceptual studies)
- Boundary Layer Ingestion (MIT D8)
- Hydrogen propulsion concepts
- Modular reconfigurable systems

#### Historical/Dormant - 3 architectures
- Nuclear Powered (1950s testbeds)
- Triplane (WWI era)
- Channel Wing (1940s prototypes)

## Usage

### Quick Start

```bash
# Make executable
chmod +x scripts/generate_ampel_index_v2.py

# Run the generator
python3 scripts/generate_ampel_index_v2.py
```

### Output Structure

The generator creates:

```
03-TECHNICAL-AMEDEO-P/AIR/
├── AIR_MANIFEST.yaml              # Complete architecture manifest
├── TRL_REPORT.md                  # TRL distribution analysis
├── VALIDATION_REPORT.md           # Structure validation
└── AMPEL-XX-CODE/                 # 43 AMPEL architectures
    ├── README.md                  # Architecture overview with TRL info
    ├── ampel-config.yaml          # Configuration with TRL data
    └── [A|M|E|D|E|O|P]-SEGMENT/   # 7 AMEDEO-P segments
        ├── README.md              # Segment documentation
        ├── segment-config.yaml    # Segment configuration
        └── CA-XXX/                # Constituent Assemblies (TRL-adaptive)
            ├── README.md          # CA documentation
            ├── ca-config.yaml     # CA configuration
            └── CI-XXXX/           # Configuration Items (TRL-adaptive)
                ├── README.md      # CI documentation
                ├── ci-config.yaml # CI configuration with TRL tracking
                └── XX-PHASE/      # 11 lifecycle phases
                    ├── README.md  # Phase documentation
                    └── templates/ # Phase templates
                        ├── checklist.yaml
                        ├── technical_spec.md
                        └── metrics.json
```

### Generated Statistics

The v2.0 generator creates:
- **63,446** directories
- **239,973** files
- **43** AMPEL architectures
- **1,421** Constituent Assemblies
- **5,140** Configuration Items
- **56,540** Lifecycle phases

## TRL Integration

### TRL-Aware Structure

The generator adapts the structure based on TRL level:

- **Higher TRL (7-9)**: More CAs and CIs (mature systems need more components)
- **Lower TRL (3-6)**: Fewer CAs and CIs (early-stage concepts)
- **Historical**: Special handling for dormant technologies

### TRL Progression Tracking

Each Configuration Item tracks:
- Current TRL level
- Appropriate lifecycle phase
- TRL advancement criteria
- Maturity assessment

### TRL Classification Criteria

- **TRL 9**: Operational systems in service
- **TRL 7-8**: Flight proven prototypes or demonstrations  
- **TRL 5-6**: Prototype testing or advanced demonstrations
- **TRL 3-4**: Research phase with concepts or lab tests
- **Historical**: Past programs, currently dormant

## Configuration

### AMEDEO-P Segments

Each AMPEL contains 7 segments:
- **A-AIRFRAMES**: Airframe systems, structures, and aerodynamics
- **M-MECHANICAL**: Mechanical systems, actuators, and mechanisms
- **E-ENVIRONMENTAL**: Environmental control and life support systems
- **D-DIGITAL**: Digital systems, avionics, and flight control
- **E-ENERGY**: Energy generation, storage, and management
- **O-OPERATING**: Operating procedures, human factors, and interfaces
- **P-PROPULSION**: Propulsion systems, integration, and performance

### Lifecycle Phases

11 phases with TRL integration:
1. **REQUIREMENTS** (TRL 1-2): Initial concept and requirements
2. **DESIGN** (TRL 2-3): Conceptual and preliminary design
3. **DEVELOPMENT** (TRL 3-4): Detailed design and development
4. **TESTING** (TRL 4-5): Component and subsystem testing
5. **VALIDATION** (TRL 5-6): System validation in relevant environment
6. **PRODUCTION** (TRL 6-7): Production readiness
7. **DEPLOYMENT** (TRL 7-8): System demonstration
8. **OPERATION** (TRL 8-9): Operational use
9. **MAINTENANCE**: Ongoing support
10. **OPTIMIZATION**: Performance enhancement
11. **DECOMMISSION**: End-of-life

## Testing

Run the comprehensive test suite:

```bash
python3 -m pytest tests/test_ampel_generator_v2.py -v
```

Tests cover:
- Generator initialization and configuration
- TRL enum and classification logic
- Structure generation and validation
- File system integrity
- Configuration file validation
- Statistical accuracy

## Compatibility

### Requirements
- Python 3.8+
- PyYAML >= 5.4.0
- Pathlib (standard library)

### Framework Integration
- Compatible with AMEDEO-P v3.0.0
- Follows established naming conventions
- Integrates with existing validation scripts
- Maintains backward compatibility with v1.0 structure

## Reports and Analysis

### TRL Report
- Complete TRL distribution analysis
- Architecture classification by maturity
- Technology roadmap insights
- Maturity progression recommendations

### Validation Report
- Structure integrity verification
- File system organization validation
- Documentation coverage assessment
- Statistical accuracy confirmation

## Real-World Examples

Each architecture includes detailed real-world examples:

**Operational Examples**:
- Boeing 737 MAX (Tube Wing)
- F-35B Lightning II (VTOL Jet)
- V-22 Osprey (Tiltrotor)

**Development Examples**:
- NASA X-66A (Truss-Braced Wing)
- NASA X-57 Maxwell (Distributed Propulsion)
- Airbus ZEROe (Hydrogen BWB)

**Research Examples**:
- MIT D8 (Boundary Layer Ingestion)
- Drone Swarms (Modular Reconfigurable)

## Future Enhancements

Planned improvements:
- Integration with quantum simulation framework
- Enhanced sustainability metrics
- International standards compliance tracking
- Real-time TRL progression monitoring

---

*Generated by AMPEL Architecture Generator v2.0*  
*User: Robbbo-T*  
*Audit Date: 2025-08-25*