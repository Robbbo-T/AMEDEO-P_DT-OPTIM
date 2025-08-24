from setuptools import setup, find_packages

setup(
    name="amedeo-p-dt-optim",
    version="3.0.0",
    packages=find_packages(),
    install_requires=[
        "numpy>=1.21.0",
        "pandas>=1.3.0",
        "pyyaml>=5.4.0",
        "pytest>=6.2.0",
    ],
    python_requires=">=3.9",
    author="AMEDEO-P DT-OPTIM Team",
    description="Quantum-Enhanced Digital Twin Framework for Aerospace Systems",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/Robbbo-T/AMEDEO-P_DT-OPTIM",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Science/Research",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
)