#!/usr/bin/env bash
set -euo pipefail

EXEC_CMD=${@:-/bin/bash}

source "$CONDA_DIR/etc/profile.d/conda.sh" \
    && conda activate "$CONDA_ENV" \
    && exec $EXEC_CMD
