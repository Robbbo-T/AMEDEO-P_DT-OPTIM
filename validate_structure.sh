#!/bin/bash
# Validates the created directory structure

echo "Validating AMEDEO-P DT-OPTIM Structure..."

# Check domains
for DOMAIN in AIR SPACE DEFENSE GROUND CROSS; do
    if [ -d "03-TECHNICAL-AMEDEO-P/$DOMAIN" ]; then
        echo "✅ $DOMAIN domain exists"
        SYSTEMS=$(find "03-TECHNICAL-AMEDEO-P/$DOMAIN" -name "System-*" -type d | wc -l)
        echo "   Systems found: $SYSTEMS"
    else
        echo "❌ $DOMAIN domain missing"
    fi
done

# Count total CIs
TOTAL_CIS=$(find . -name "CI-*" -type d | wc -l)
echo ""
echo "Total Configuration Items: $TOTAL_CIS"

# Verify lifecycle phases
SAMPLE_CI=$(find . -name "CI-*" -type d | head -1)
if [ -n "$SAMPLE_CI" ]; then
    echo ""
    echo "Checking lifecycle phases in: $SAMPLE_CI"
    for PHASE in 01-REQUIREMENTS 02-DESIGN 03-BUILDING-PROTOTYPING; do
        if [ -d "$SAMPLE_CI/$PHASE" ]; then
            echo "✅ $PHASE exists"
        else
            echo "❌ $PHASE missing"
        fi
    done
fi