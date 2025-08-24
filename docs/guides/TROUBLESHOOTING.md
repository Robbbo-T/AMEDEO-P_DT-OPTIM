# Troubleshooting Guide

## Common Issues and Solutions

### Build Script Issues

#### Problem: Permission denied when running scripts
```bash
chmod +x build_structure.sh
chmod +x validate_structure.sh
chmod +x scripts/setup.sh
```

#### Problem: Script fails with "command not found"
- Ensure you're running from the repository root
- Check that bash is available: `which bash`

### Python Environment Issues

#### Problem: ModuleNotFoundError
```bash
# Activate virtual environment
source venv/bin/activate

# Reinstall dependencies
pip install -r requirements.txt
```

#### Problem: Python version too old
- Requires Python 3.9 or higher
- Check version: `python3 --version`
- Update Python or use pyenv

### Directory Structure Issues

#### Problem: Directory creation fails
- Check available disk space (requires ~500MB)
- Ensure write permissions in the repository directory
- Run with sudo if necessary (not recommended)

#### Problem: Build script takes too long
- Expected time: 5-10 minutes for full structure
- Consider using minimal mode for testing

### Memory Issues

#### Problem: System runs out of memory
- Minimum 16GB RAM recommended
- Close other applications
- Consider building domains separately

### Git Issues

#### Problem: .gitignore not working
```bash
git rm -r --cached .
git add .
git commit -m "Fix gitignore"
```

#### Problem: Too many files in git
- Ensure .gitignore is properly configured
- Add large directories to .gitignore before building

## Performance Tips

1. **Use SSD storage** for better I/O performance
2. **Build incrementally** for testing
3. **Use symbolic links** for repeated structures if needed
4. **Monitor disk space** during build

## Getting Help

1. Check [FAQ](../FAQ.md)
2. Review [Architecture Overview](../architecture/OVERVIEW.md)
3. Validate structure with `./validate_structure.sh`
4. Open an issue on GitHub with error details

## Debug Commands

```bash
# Check system resources
df -h                    # Disk space
free -h                  # Memory usage
python3 --version        # Python version

# Validate structure
./validate_structure.sh

# Check Python packages
pip list

# Test basic functionality
python -c "import numpy, pandas, yaml; print('Dependencies OK')"
```