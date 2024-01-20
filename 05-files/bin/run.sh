#!/usr/bin/env bash
set -euo pipefail

source "$CONDA_DIR/etc/profile.d/conda.sh"
conda activate "$CONDA_ENV"


for arg; do
  case $arg in
    lab)
      echo 'Running Jupyter lab'
      exec jupyter lab
      ;;
    *)
      echo "Unknown target: $arg."
      exit 1
  esac
done
