#!/bin/sh
# Runs on Summit Connect 2024: Advanced InstructLab Workshop - Train a LLM for the Parasol Insurance Company

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "ROOT DIR: ${ROOT_DIR}"

(cd $ROOT_DIR && make build-content)