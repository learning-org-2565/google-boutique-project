#!/bin/bash
# DevOps Service Analysis for productcatalogservice
# Run this BEFORE creating any Dockerfile

echo "🔍 DEVOPS SERVICE ANALYSIS - productcatalogservice"
echo "=================================================="

# Navigate to service directory
cd src/productcatalogservice/ 2>/dev/null || {
    echo "❌ Please run from microservices-demo root directory"
    exit 1
}

echo
echo "📁 1. FILE STRUCTURE ANALYSIS"
echo "-----------------------------"
echo "Service files:"
ls -la
echo
echo "Directory tree:"
find . -type f | head -20

echo
echo "🔌 2. PORT & ENDPOINT ANALYSIS"
echo "------------------------------"
echo "Looking for ports and endpoints..."
grep -r "Listen\|Port\|:.*[0-9]" . --include="*.go" 2>/dev/null | head -10
echo
echo "Health check patterns:"
grep -r "health\|ready\|liveness" . --include="*.go" 2>/dev/null | head -5

echo
echo "📦 3. DEPENDENCY ANALYSIS"
echo "------------------------"
if [ -f "go.mod" ]; then
    echo "Go module file (go.mod):"
    cat go.mod
    echo
    echo "Go dependencies summary:"
    grep "require" go.mod | wc -l && echo "total dependencies"
else
    echo "❌ No go.mod found - checking for other build files"
    ls -la | grep -E "(Makefile|package\.json|requirements\.txt)"
fi

echo
echo "📄 4. DATA FILE ANALYSIS"
echo "------------------------"
echo "JSON/Config files:"
find . -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.toml"
echo
echo "Static assets:"
find . -name "static" -o -name "assets" -o -name "public" -o -name "data" 2>/dev/null

echo
echo "🔧 5. BUILD REQUIREMENTS"
echo "------------------------"
echo "Go version (if specified):"
grep "go [0-9]" go.mod 2>/dev/null || echo "Go version not specified in go.mod"
echo
echo "CGO dependencies check:"
grep -r "import \"C\"" . --include="*.go" 2>/dev/null && echo "⚠️  CGO dependencies found" || echo "✅ No CGO dependencies (good for static builds)"

echo
echo "🌐 6. ENVIRONMENT VARIABLES"
echo "---------------------------"
echo "Environment variable usage:"
grep -r "os\.Getenv\|os\.LookupEnv" . --include="*.go" 2>/dev/null | head -10

echo
echo "🏗️  7. BUILD COMMANDS"
echo "--------------------"
echo "Checking for build scripts:"
ls -la | grep -E "(Makefile|build\.sh|docker-compose)"
echo
echo "Standard Go build test:"
echo "go build ." && go build . 2>/dev/null && echo "✅ Builds successfully" || echo "❌ Build issues (check dependencies)"

echo
echo "📊 8. DEVOPS SUMMARY"
echo "===================="
echo "✅ Analysis complete!"
echo "📝 Key findings saved above"
echo "🚀 Ready for Dockerfile creation"
echo
echo "Next: Use these findings to create optimized Dockerfile"