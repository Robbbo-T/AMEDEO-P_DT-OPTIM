# AMPEL AIRFRAMES Scripts

This folder contains automation for building and indexing the AMPEL ARCHITECTURES structure under `03-TECHNICAL-AMEDEO-P/AIR/Airframes`.

## Scripts

- `build_ampel_airframes.sh` — Creates 200 systems with 41 architecture types, 10 CIs per system, and 11 lifecycle phases per CI. Also generates the AMPEL registry docs and manifest.
- `generate_ampel_index.py` — Scans the AMPEL architecture definition and writes JSON/YAML/CSV index and summary stats to the registry folder.

## Quickstart

```bash
chmod +x scripts/build_ampel_airframes.sh
chmod +x scripts/generate_ampel_index.py

./scripts/build_ampel_airframes.sh
python scripts/generate_ampel_index.py
```
