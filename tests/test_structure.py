"""
Test suite for AMEDEO-P DT-OPTIM structure validation
"""
import os
import pytest
import yaml
from pathlib import Path

def test_framework_config_exists():
    """Test that framework configuration file exists and is valid"""
    config_path = Path("config/framework.yaml")
    assert config_path.exists(), "Framework configuration file missing"
    
    with open(config_path, 'r') as f:
        config = yaml.safe_load(f)
    
    assert config['framework']['name'] == 'AMEDEO-P DT-OPTIM'
    assert config['framework']['version'] == '3.0.0'
    assert config['total_systems'] == 3920
    assert config['total_cis'] == 39200

def test_main_directories_exist():
    """Test that main framework directories exist"""
    main_dirs = [
        "00-FRAMEWORK",
        "01-ORGANIZATIONAL", 
        "02-PROCEDURAL",
        "03-TECHNICAL-AMEDEO-P",
        "04-INTELLIGENT-MACHINE"
    ]
    
    for directory in main_dirs:
        assert os.path.isdir(directory), f"Directory {directory} missing"

def test_supporting_directories_exist():
    """Test that supporting directories were created"""
    support_dirs = [
        "scripts",
        "docs",
        "config", 
        "tools",
        "examples",
        "data",
        "tests"
    ]
    
    for directory in support_dirs:
        assert os.path.isdir(directory), f"Supporting directory {directory} missing"

def test_build_scripts_exist():
    """Test that build scripts are present and executable"""
    scripts = [
        "build_structure.sh",
        "validate_structure.sh",
        "scripts/setup.sh"
    ]
    
    for script in scripts:
        assert os.path.isfile(script), f"Script {script} missing"
        assert os.access(script, os.X_OK), f"Script {script} not executable"

def test_python_package_files():
    """Test that Python package files exist"""
    package_files = [
        "setup.py",
        "requirements.txt"
    ]
    
    for file in package_files:
        assert os.path.isfile(file), f"Package file {file} missing"

def test_documentation_structure():
    """Test that documentation directories exist"""
    doc_dirs = [
        "docs/guides",
        "docs/architecture", 
        "docs/domains",
        "docs/api"
    ]
    
    for directory in doc_dirs:
        assert os.path.isdir(directory), f"Documentation directory {directory} missing"
    
    # Test specific guide files
    assert os.path.isfile("docs/guides/QUICK_START.md"), "Quick start guide missing"
    assert os.path.isfile("docs/guides/TROUBLESHOOTING.md"), "Troubleshooting guide missing"

def test_domain_structure():
    """Test that technical domain directories exist"""
    domains = ["AIR", "SPACE", "DEFENSE", "GROUND", "CROSS"]
    
    for domain in domains:
        domain_path = f"03-TECHNICAL-AMEDEO-P/{domain}"
        assert os.path.isdir(domain_path), f"Domain {domain} directory missing"

if __name__ == "__main__":
    pytest.main([__file__])