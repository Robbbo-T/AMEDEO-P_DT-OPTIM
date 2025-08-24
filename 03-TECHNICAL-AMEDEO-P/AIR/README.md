# AIR Domain - Aviation Systems

This directory contains aviation and atmospheric flight systems implementations for the AMEDEO-P framework.

## System Inventory

- **Total Systems**: 1,400
- **Configuration Items**: 14,000 (10 CIs per system)
- **Lifecycle Points**: 154,000 (11 phases × CIs)

## AMEDEO-P Segments

| Segment | Interpretation | Systems | Example CIs |
|---------|---------------|---------|-------------|
| **A** | Airframes & Structures | 200 | Wings, fuselage, control surfaces |
| **M** | Mechanical Systems | 200 | Landing gear, actuators, hydraulics |
| **E** | Environmental Control | 200 | Pressurization, HVAC, oxygen |
| **D** | Digital/Avionics | 200 | FMS, navigation, communication |
| **E** | Energy/Electrical | 200 | Generators, batteries, distribution |
| **O** | Operating Systems | 200 | Flight ops, crew systems, procedures |
| **P** | Propulsion | 200 | Turbofans, turboprops, fuel systems |

## Key Systems

### Aircraft Types
- Commercial aviation (passenger aircraft)
- General aviation (private and business aircraft)
- Military aviation (fighters, transports, helicopters)
- Unmanned aerial vehicles (UAVs/drones)
- Advanced air mobility (eVTOL, air taxis)

### System Categories
- Flight control systems
- Propulsion and power systems
- Avionics and navigation
- Environmental and life support
- Landing and ground systems

## CI Naming Convention

Pattern: `CI-A{Segment}{System:03d}-{Item:03d}`

Examples:
- `CI-AF001-001` - Airframe System 001, Item 001
- `CI-AM045-012` - Mechanical System 045, Item 012
- `CI-AE023-005` - Environmental System 023, Item 005

## Status

Aviation domain with traditional aerospace focus covering all aspects of atmospheric flight systems.