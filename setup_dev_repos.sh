#!/bin/bash

# ModelingToolkitStandardLibrary.jl Development Repository Setup
# This script clones related SciML repositories for local development and testing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default directory for cloned repositories
DEV_DIR="${1:-../dev-repos}"

echo -e "${GREEN}Setting up development repositories for ModelingToolkitStandardLibrary.jl${NC}"
echo -e "${YELLOW}Target directory: $DEV_DIR${NC}"

# Create development directory if it doesn't exist
mkdir -p "$DEV_DIR"
cd "$DEV_DIR"

# List of repositories to clone
repos=(
    "https://github.com/ranocha/BSeries.jl"
    "https://github.com/SciML/RootedTrees.jl"
    "https://github.com/SciML/DifferentialEquations.jl"
    "https://github.com/SciML/ReservoirComputing.jl"
    "https://github.com/SciML/ModelingToolkit.jl"
    "https://github.com/SciML/ModelingToolkitNeuralNets.jl"
    "https://github.com/SciML/NeuralPDE.jl"
    "https://github.com/SciML/ParameterizedFunctions.jl"
    "https://github.com/SciML/DataDrivenDiffEq.jl"
    "https://github.com/SciML/Catalyst.jl"
    "https://github.com/SciML/MultiScaleArrays.jl"
)

echo -e "${YELLOW}Cloning ${#repos[@]} repositories...${NC}"

# Clone each repository
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    
    if [ -d "$repo_name" ]; then
        echo -e "${YELLOW}Repository $repo_name already exists, updating...${NC}"
        cd "$repo_name"
        git pull origin main || git pull origin master || echo -e "${RED}Failed to update $repo_name${NC}"
        cd ..
    else
        echo -e "${GREEN}Cloning $repo_name...${NC}"
        git clone "$repo" || echo -e "${RED}Failed to clone $repo${NC}"
    fi
done

echo -e "${GREEN}Development repository setup complete!${NC}"
echo -e "${YELLOW}Repositories are located in: $(pwd)${NC}"
echo -e "${YELLOW}To use these repositories for development, you may want to add them to your Julia dev environment:${NC}"
echo -e "julia -e 'using Pkg; Pkg.develop(path=\"$(pwd)/RepositoryName.jl\")'"