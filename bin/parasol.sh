#!/bin/sh

cd ~/instructlab
source venv/bin/activate

mkdir -p ~/instructlab/taxonomy/knowledge/parasol/overview
cp artifacts/parasol-qna.yaml ~/instructlab/taxonomy/knowledge/parasol/overview/qna.yaml

rm -rf datasets/*
ilab data generate --num-instructions 100 --num-cpus 4
(mkdir -p /tmp/parasol && cd /tmp/parasol  && ilab model train --device cuda --iters 300 --legacy)
