#!/bin/bash
# Build script for CS Quest with JupyterLite integration

echo "=========================================="
echo "CS Quest Build Script"
echo "=========================================="
echo ""

# Step 1: Install JupyterLite if not already installed
echo "📦 Checking JupyterLite installation..."
if ! command -v jupyter &> /dev/null; then
    echo "⚠️  Jupyter not found. Please install JupyterLite:"
    echo "   pip install jupyterlite-core jupyterlite-pyodide-kernel"
    python -m pip install -r requirements.txt
    #exit 1
fi

# Step 2: Build JupyterLite site
echo "🔨 Building JupyterLite..."
cd jupyterlite
jupyter lite build --contents content --output-dir ../jupyterlite_build

if [ $? -eq 0 ]; then
    echo "✅ JupyterLite built successfully"
else
    echo "❌ JupyterLite build failed"
    exit 1
fi

cd ..

npm install -D @quarto/netlify-plugin-quarto

# Step 3: Build Quarto site
echo ""
echo "🔨 Building Quarto website..."
quarto render

if [ $? -eq 0 ]; then
    echo "✅ Quarto site built successfully"
else
    echo "❌ Quarto build failed"
    exit 1
fi

# Step 4: Copy JupyterLite to Quarto output
echo ""
echo "📋 Copying JupyterLite to _site..."
mkdir -p _site/jupyterlite
cp -r jupyterlite_build/* _site/jupyterlite/

echo "✅ JupyterLite copied to _site/jupyterlite"

# Step 5: Success message
echo ""
echo "=========================================="
echo "✨ Build Complete!"
echo "=========================================="
echo ""
echo "📁 Output directory: _site/"
echo ""
echo "To preview locally:"
echo "  cd _site"
echo "  python -m http.server 8000"
echo ""
echo "Then visit: http://localhost:8000"
echo ""
echo "JupyterLite available at: http://localhost:8000/jupyterlite/lab/index.html"
echo ""
