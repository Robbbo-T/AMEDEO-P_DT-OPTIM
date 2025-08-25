"""
Test suite for AMPEL Architecture Index Generator v2.0
"""
import os
import sys
import yaml
import json
import pytest
from pathlib import Path

# Import the generator from the scripts package


try:
    from scripts.generate_ampel_index_v2 import AMPELGeneratorV2, TRLLevel
except ImportError:
    pytest.skip("AMPEL Generator v2.0 not available", allow_module_level=True)

class TestAMPELGeneratorV2:
    """Test class for AMPEL Generator v2.0"""
    
    @pytest.fixture
    def generator(self):
        """Create a test generator instance"""
        return AMPELGeneratorV2(base_path="test_air_domain")
    
    @pytest.fixture
    def cleanup_test_directory(self):
        """Clean up test directory after tests"""
        yield
        import shutil
        test_path = Path("test_air_domain")
        if test_path.exists():
            shutil.rmtree(test_path)
    
    def test_trl_level_enum(self):
        """Test that TRL level enum is properly defined"""
        assert TRLLevel.TRL_9.value == "Operational"
        assert TRLLevel.TRL_7_8.value == "Flight Proven"
        assert TRLLevel.TRL_5_6.value == "Prototype/Demo"
        assert TRLLevel.TRL_3_4.value == "Research/Concept"
        assert TRLLevel.HISTORICAL.value == "Historical/Dormant"
    
    def test_generator_initialization(self, generator):
        """Test that generator initializes correctly"""
        assert generator.base_path.name == "test_air_domain"
        assert len(generator.ampel_definitions) == 43
        assert len(generator.amedeo_segments) == 7
        assert len(generator.lifecycle_phases) == 11
    
    def test_ampel_definitions_structure(self, generator):
        """Test AMPEL definitions have correct structure"""
        for definition in generator.ampel_definitions:
            assert len(definition) == 5  # num, code, description, trl, example
            assert isinstance(definition[0], int)  # number
            assert isinstance(definition[1], str)  # code
            assert isinstance(definition[2], str)  # description
            assert isinstance(definition[3], TRLLevel)  # TRL level
            assert isinstance(definition[4], str)  # example
    
    def test_trl_icon_mapping(self, generator):
        """Test TRL icon mapping function"""
        assert generator._get_trl_icon(TRLLevel.TRL_9) == "✅"
        assert generator._get_trl_icon(TRLLevel.TRL_7_8) == "✈️"
        assert generator._get_trl_icon(TRLLevel.TRL_5_6) == "🔧"
        assert generator._get_trl_icon(TRLLevel.TRL_3_4) == "🔬"
        assert generator._get_trl_icon(TRLLevel.HISTORICAL) == "📚"
    
    def test_ca_distribution_logic(self, generator):
        """Test CA distribution based on TRL"""
        # Test some distributions
        airframes_func = generator.ca_distribution['A-AIRFRAMES']
        assert airframes_func(TRLLevel.TRL_5_6) == 6
        assert airframes_func(TRLLevel.TRL_9) == 5
        
        digital_func = generator.ca_distribution['D-DIGITAL']
        assert digital_func(TRLLevel.TRL_5_6) == 7
        assert digital_func(TRLLevel.TRL_9) == 6


class TestAMPELStructureValidation:
    """Test the generated AMPEL structure"""
    
    @pytest.fixture
    def air_structure_path(self):
        """Path to the generated AIR structure"""
        return Path("03-TECHNICAL-AMEDEO-P/AIR")
    
    def test_air_manifest_exists(self, air_structure_path):
        """Test that AIR manifest file exists and is valid"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        manifest_path = air_structure_path / "AIR_MANIFEST.yaml"
        assert manifest_path.exists(), "AIR manifest file missing"
        
        with open(manifest_path, 'r') as f:
            manifest = yaml.safe_load(f)
        
        assert manifest['domain'] == 'AIR'
        assert manifest['type'] == 'AMPEL Architecture Index v2.0'
        assert manifest['version'] == '2.0.0'
        assert 'ampel_architectures' in manifest
        assert len(manifest['ampel_architectures']) == 43
    
    def test_trl_report_exists(self, air_structure_path):
        """Test that TRL report exists and has correct content"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        trl_report_path = air_structure_path / "TRL_REPORT.md"
        assert trl_report_path.exists(), "TRL report missing"
        
        with open(trl_report_path, 'r') as f:
            content = f.read()
        
        assert "Technology Readiness Level (TRL) Report" in content
        assert "TRL Distribution Summary" in content
        assert "✅" in content  # Operational systems icon
        assert "✈️" in content  # Flight proven icon
    
    def test_validation_report_exists(self, air_structure_path):
        """Test that validation report exists"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        validation_report_path = air_structure_path / "VALIDATION_REPORT.md"
        assert validation_report_path.exists(), "Validation report missing"
        
        with open(validation_report_path, 'r') as f:
            content = f.read()
        
        assert "AMPEL Architecture Validation Report" in content
        assert "Structure Validation Summary" in content
    
    def test_ampel_directories_structure(self, air_structure_path):
        """Test that AMPEL directories have correct structure"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        # Check first AMPEL directory
        ampel_dir = air_structure_path / "AMPEL-01-TUW"
        if not ampel_dir.exists():
            pytest.skip("AMPEL directories not generated yet")
        
        # Check AMPEL has README and config
        assert (ampel_dir / "README.md").exists()
        assert (ampel_dir / "ampel-config.yaml").exists()
        
        # Check AMEDEO-P segments exist
        expected_segments = [
            "A-AIRFRAMES", "M-MECHANICAL", "E-ENVIRONMENTAL", 
            "D-DIGITAL", "E-ENERGY", "O-OPERATING", "P-PROPULSION"
        ]
        
        for segment in expected_segments:
            segment_path = ampel_dir / segment
            assert segment_path.exists(), f"Segment {segment} missing"
            assert (segment_path / "README.md").exists()
            assert (segment_path / "segment-config.yaml").exists()
    
    def test_ca_structure(self, air_structure_path):
        """Test CA (Constituent Assembly) structure"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        # Check a sample CA
        ca_path = air_structure_path / "AMPEL-01-TUW" / "A-AIRFRAMES" / "CA-001"
        if not ca_path.exists():
            pytest.skip("CA structure not generated yet")
        
        assert (ca_path / "README.md").exists()
        assert (ca_path / "ca-config.yaml").exists()
        
        # Check for CIs
        ci_dirs = [d for d in ca_path.iterdir() if d.is_dir() and d.name.startswith("CI-")]
        assert len(ci_dirs) > 0, "No Configuration Items found"
    
    def test_ci_lifecycle_phases(self, air_structure_path):
        """Test CI (Configuration Item) lifecycle phases"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        # Check a sample CI
        ci_path = air_structure_path / "AMPEL-01-TUW" / "A-AIRFRAMES" / "CA-001" / "CI-0001"
        if not ci_path.exists():
            pytest.skip("CI structure not generated yet")
        
        assert (ci_path / "README.md").exists()
        assert (ci_path / "ci-config.yaml").exists()
        
        # Check lifecycle phases
        expected_phases = [
            "01-REQUIREMENTS", "02-DESIGN", "03-DEVELOPMENT", "04-TESTING",
            "05-VALIDATION", "06-PRODUCTION", "07-DEPLOYMENT", "08-OPERATION",
            "09-MAINTENANCE", "10-OPTIMIZATION", "11-DECOMMISSION"
        ]
        
        for phase in expected_phases:
            phase_path = ci_path / phase
            assert phase_path.exists(), f"Lifecycle phase {phase} missing"
            assert (phase_path / "README.md").exists()
            
            # Check templates
            templates_path = phase_path / "templates"
            assert templates_path.exists(), f"Templates missing for {phase}"
            assert (templates_path / "checklist.yaml").exists()
            assert (templates_path / "technical_spec.md").exists()
            assert (templates_path / "metrics.json").exists()
    
    def test_trl_integration_in_configs(self, air_structure_path):
        """Test that TRL information is properly integrated into config files"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        # Check AMPEL config
        ampel_config_path = air_structure_path / "AMPEL-01-TUW" / "ampel-config.yaml"
        if not ampel_config_path.exists():
            pytest.skip("AMPEL config not generated yet")
        
        with open(ampel_config_path, 'r') as f:
            config = yaml.safe_load(f)
        
        assert 'trl' in config, "TRL information missing from AMPEL config"
        assert 'level' in config['trl'], "TRL level missing"
        assert 'classification' in config['trl'], "TRL classification missing"
        assert 'example_programs' in config['trl'], "TRL examples missing"
    
    def test_statistical_accuracy(self, air_structure_path):
        """Test that the generated statistics are accurate"""
        if not air_structure_path.exists():
            pytest.skip("AIR structure not generated yet")
        
        # Count actual AMPEL directories
        ampel_dirs = [d for d in air_structure_path.iterdir() 
                     if d.is_dir() and d.name.startswith("AMPEL-")]
        
        assert len(ampel_dirs) == 43, f"Expected 43 AMPEL directories, found {len(ampel_dirs)}"
        
        # Check TRL distribution in manifest
        manifest_path = air_structure_path / "AIR_MANIFEST.yaml"
        if manifest_path.exists():
            with open(manifest_path, 'r') as f:
                manifest = yaml.safe_load(f)
            
            assert manifest['structure']['ampel_count'] == 43
            assert manifest['structure']['segments_per_ampel'] == 7
            assert manifest['structure']['lifecycle_phases'] == 11


def test_script_execution():
    """Test that the script can be executed successfully"""
    import subprocess
    import sys
    
    # Run the script
    result = subprocess.run([
        sys.executable, 
        "scripts/generate_ampel_index_v2.py"
    ], capture_output=True, text=True, cwd=".")
    
    # Check if it ran successfully (exit code 0)
    assert result.returncode == 0, f"Script failed with error: {result.stderr}"
    
    # Check for success indicators in output
    assert "Generation completed successfully!" in result.stdout
    assert "AMPEL architectures" in result.stdout