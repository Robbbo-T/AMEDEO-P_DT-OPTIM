"""Setup configuration for AMEDEO-P DT-OPTIM Framework."""

from setuptools import setup, find_packages
from pathlib import Path

# Read the README for long description
this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text(encoding="utf-8")

# Read requirements from requirements.txt if it exists
requirements = []
requirements_file = this_directory / "requirements.txt"
if requirements_file.exists():
    with open(requirements_file, "r", encoding="utf-8") as f:
        requirements = [
            line.strip() 
            for line in f 
            if line.strip() and not line.startswith("#")
        ]
else:
    # Fallback to minimal requirements
    requirements = [
        "numpy>=1.21.0",
        "pandas>=1.3.0",
        "matplotlib>=3.4.0",
        "pyyaml>=5.4.0",
        "pytest>=6.2.0",
    ]

setup(
    # Package information
    name="amedeo-p-dt-optim",
    version="3.0.0",
    packages=find_packages(exclude=["tests", "tests.*", "docs", "examples"]),
    
    # Dependencies
    install_requires=requirements,
    python_requires=">=3.9",
    
    # Optional dependencies for different use cases
    extras_require={
        "dev": [
            "pytest>=6.2.0",
            "pytest-cov>=3.0.0",
            "black>=22.0.0",
            "flake8>=4.0.0",
            "mypy>=0.950",
            "pre-commit>=2.17.0",
        ],
        "quantum": [
            "qiskit>=0.37.0",
            "cirq>=0.14.0",
            "pennylane>=0.24.0",
        ],
        "ml": [
            "scikit-learn>=1.0.0",
            "tensorflow>=2.9.0",
            "torch>=1.11.0",
            "xgboost>=1.6.0",
        ],
        "viz": [
            "plotly>=5.0.0",
            "dash>=2.0.0",
            "bokeh>=2.4.0",
            "seaborn>=0.11.0",
        ],
        "data": [
            "influxdb-client>=1.30.0",
            "networkx>=2.6.0",
            "h5py>=3.6.0",
            "zarr>=2.11.0",
        ],
        "all": [
            "qiskit>=0.37.0",
            "scikit-learn>=1.0.0",
            "tensorflow>=2.9.0",
            "plotly>=5.0.0",
            "influxdb-client>=1.30.0",
        ],
    },
    
    # Package metadata
    author="AMEDEO-P DT-OPTIM Team",
    author_email="team@dt-optim-framework.io",
    maintainer="Robbbo-T",
    maintainer_email="robbbo.t@dt-optim-framework.io",
    description="Quantum-Enhanced Digital Twin Framework for Aerospace Systems - Reference Architecture",
    long_description=long_description,
    long_description_content_type="text/markdown",
    
    # URLs
    url="https://github.com/Robbbo-T/AMEDEO-P_DT-OPTIM",
    project_urls={
        "Bug Tracker": "https://github.com/Robbbo-T/AMEDEO-P_DT-OPTIM/issues",
        "Documentation": "https://amedeo-p-dt-optim.readthedocs.io/",
        "Source Code": "https://github.com/Robbbo-T/AMEDEO-P_DT-OPTIM",
        "Discussions": "https://github.com/Robbbo-T/AMEDEO-P_DT-OPTIM/discussions",
    },
    
    # License
    license="MIT",
    
    # Classifiers for PyPI
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Science/Research",
        "Intended Audience :: Developers",
        "Intended Audience :: Education",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Topic :: Scientific/Engineering",
        "Topic :: Scientific/Engineering :: Artificial Intelligence",
        "Topic :: Scientific/Engineering :: Information Analysis",
        "Topic :: Software Development :: Libraries :: Python Modules",
        "Framework :: Jupyter",
        "Natural Language :: English",
    ],
    
    # Keywords for discovery
    keywords=[
        "digital-twin",
        "aerospace",
        "quantum-computing",
        "synthetic-data",
        "reference-architecture",
        "AMEDEO-P",
        "DT-OPTIM",
        "systems-engineering",
        "simulation",
        "AI",
        "machine-learning",
    ],
    
    # Entry points for command-line scripts
    entry_points={
        "console_scripts": [
            "amedeo-build=scripts.build_structure:main",
            "amedeo-validate=scripts.validate_structure:main",
            "amedeo-generate=scripts.generate_synthetic:main",
            "amedeo-server=scripts.dev_server:main",
        ],
    },
    
    # Include additional files
    include_package_data=True,
    package_data={
        "": ["*.yaml", "*.yml", "*.json", "*.md"],
        "amedeo_p_dt_optim": ["config/*.yaml", "templates/*.jinja2"],
    },
    
    # Zip safety
    zip_safe=False,
    
    # Platform specification
    platforms=["any"],
    
    # Testing
    test_suite="tests",
    tests_require=[
        "pytest>=6.2.0",
        "pytest-cov>=3.0.0",
        "pytest-mock>=3.6.0",
    ],
)