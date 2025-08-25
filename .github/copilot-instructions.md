# GitHub Copilot Instructions for AMEDEO-P DT-OPTIM

## Project Overview

AMEDEO-P DT-OPTIM is a Quantum-Enhanced Digital Twin Framework for Aerospace Systems. This is a reference architecture and educational framework, NOT a deployed system.

## Key Concepts

### AMEDEO-P Acronym
- **A**: Airframes (includes AMPEL ARCHITECTURES)
- **M**: Mechanical Systems
- **E**: Environmental Systems
- **D**: Digital/Distributed Systems
- **E**: Energy Systems
- **O**: Operating/Organizational Systems
- **P**: Propulsion Systems

### AMPEL ARCHITECTURES
AMPEL (Aircraft Multi-Program Enhanced Lifecycle) is the framework for the Airframes segment, containing:
- 41 architecture types
- 200 systems in AIR/Airframes
- 8 categories (U, C, D, M, N, P, A, V)

## Code Style Guidelines

### Python Code
- Use type hints for all functions
- Follow PEP 8 standards
- Include docstrings for all classes and functions
- Use async/await for I/O operations

Example:
```python
from typing import List, Dict, Optional
import asyncio

async def generate_synthetic_data(
    domain: str,
    systems: List[str],
    duration: float
) -> Dict[str, np.ndarray]:
    """
    Generate synthetic telemetry data for aerospace systems.
    
    Args:
        domain: Operational domain (AIR, SPACE, DEFENSE, GROUND, CROSS)
        systems: List of system identifiers
        duration: Simulation duration in hours
        
    Returns:
        Dictionary of synthetic data arrays
    """
    # Implementation
    pass
```

### Directory Structure
Always follow this pattern:
```
03-TECHNICAL-AMEDEO-P/
├── {DOMAIN}/
│   ├── {SEGMENT}/
│   │   ├── System-{XXX}-{CODE}/
│   │   │   ├── CA-{ID}/
│   │   │   │   ├── CI-{ID}-{NUM}/
│   │   │   │   │   ├── 01-REQUIREMENTS/
│   │   │   │   │   ├── 02-DESIGN/
│   │   │   │   │   └── ... (11 phases)
```

### Naming Conventions

#### Systems
- Pattern: `System-XXX-{ARCH}`
- Example: `System-036-BWB` (Blended Wing Body)

#### Configuration Items
- Pattern: `CI-{Domain}{Segment}{System}-{Item}`
- Example: `CI-AF036-001` (AIR, Airframes, System 036, Item 001)

#### AMPEL Architectures
- Always use 3-letter codes: TUW, BWB, FLW, DEL, VGW, etc.
- Maintain consistency with AMPEL registry

## Common Patterns

### Synthetic Data Generation
When generating synthetic data, always:
1. Include realistic noise (0.1-1% Gaussian)
2. Maintain temporal consistency
3. Apply domain-specific constraints
4. Generate at minimum 1000Hz sampling rate

### Quantum Simulation
- Use Qiskit or Cirq for quantum simulation
- Default to 1000 qubits (simulated)
- Always note this is SIMULATED, not real quantum hardware

### Lifecycle Management
Each CI must have exactly 11 phases:
1. REQUIREMENTS
2. DESIGN
3. BUILDING-PROTOTYPING
4. EXECUTABLES-PACKAGES
5. VERIFICATION-VALIDATION
6. INTEGRATION-QUALIFICATION
7. CERTIFICATION-SECURITY
8. PRODUCTION-SCALE
9. OPS-SERVICES
10. MRO
11. SUSTAINMENT-RECYCLE-EOL

## Domain-Specific Rules

### AIR Domain
- 1,400 total systems
- 200 per segment
- AMPEL ARCHITECTURES in Airframes segment
- Follow FAA/EASA standards

### SPACE Domain
- 700 total systems
- 100 per segment
- Consider orbital mechanics
- Temperature range: -270°C to +120°C

### DEFENSE Domain
- 1,050 total systems
- 150 per segment
- Include classification levels
- Follow MIL-STD standards

## Important Notes

1. **This is a reference architecture** - Always clarify this is conceptual, not deployed
2. **Synthetic data only** - No real sensor data exists
3. **Educational purpose** - Focus on learning and demonstration
4. **Quantum is simulated** - Real quantum computers aren't available until 2029+
5. **Use AMPEL codes** - Always reference the 41 architecture types correctly

## Common Mistakes to Avoid

1. ❌ Don't claim this is a real, deployed system
2. ❌ Don't generate random architecture codes - use the 41 defined AMPEL types
3. ❌ Don't skip lifecycle phases - all 11 are required
4. ❌ Don't mix domain-specific interpretations of AMEDEO-P segments
5. ❌ Don't claim quantum supremacy - we're using classical simulation

## Helpful Resources

- AMPEL Registry: `03-TECHNICAL-AMEDEO-P/AIR/Airframes/AMPEL-REGISTRY/`
- Architecture Overview: `docs/architecture/OVERVIEW.md`
- Lifecycle Templates: `templates/lifecycle-phases/`
- Synthetic Data Generators: `00-FRAMEWORK/synthetic-core/`

## When in Doubt

- Check the AMPEL manifest for architecture codes
- Verify against the 11-phase lifecycle model
- Ensure domain-specific segment interpretations are correct
- Remember: This is educational/reference, not operational
