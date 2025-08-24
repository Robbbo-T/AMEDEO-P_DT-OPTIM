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
)