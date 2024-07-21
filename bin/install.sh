#!/bin/sh
# Adapted from https://github.com/jameslabocki/ilabdemo/blob/main/install.sh#L44
# Runs on Red Hat Demo Platform - InstructLab RHEL VM (Nvidia/CUDA) 

# Clean up existing content
#rm -rf #HOME/files
#rm -rf #HOME/instructlab

export ILAB_HOME=/home/instruct/instructlab

mkdir -p $ILAB_HOME
mkdir -p ~/workshop
mv $ILAB_HOME/models/ggml-ilab-pretrained-Q4_K_M.gguf ~/workshop/ggml-ilab-pretrained-Q4_K_M.gguf
rm -rf $ILAB_HOME/*
rm -rf ~/files

# Prepare python virtual environment
python3 -m venv $ILAB_HOME/venv
source $ILAB_HOME/venv/bin/activate

rm -rf $HOME/.cache/pip
# Install InstructLab
pip install -r requirements.txt
# Ensure llma_cpp has CUDA support
pip install --force-reinstall "llama_cpp_python[server]==0.2.79" --config-settings cmake.args="-DLLAMA_CUDA=on"
# Put back the correct version
pip install 'numpy<2.0'

#ilab init --non-interactive
cp artifacts/config.yaml ~/workshop/config.yaml
cp artifacts/ilab-qna.yaml ~/workshop/ilab-qna.yaml 

#ilab model download
ln -sf $HOME/.local/share/instructlab/taxonomy $ILAB_HOME/.
ln -sf $HOME/.local/share/instructlab/datasets $ILAB_HOME/.
ln -sf $HOME/.local/share/instructlab/models $ILAB_HOME/.

#cp ~/workshop/ggml-ilab-pretrained-Q4_K_M.gguf $ILAB_HOME/models/

#mkdir -p $ILAB_HOME/taxonomy/knowledge/parasol/overview
#curl -o $ILAB_HOME/taxonomy/knowledge/parasol/overview/qna.yaml https://raw.githubusercontent.com/gshipley/backToTheFuture/main/qna.yaml

#mkdir -p $ILAB_HOME/workshop
#cp artifacts/* $ILAB_HOME/workshop
#cp artifacts/ggml-ilab-pretrained-Q4_K_M.gguf $ILAB_HOME/models/ggml-ilab-pretrained-Q4_K_M.gguf

make build-content

# Install zip
echo "installing zip"
sleep 1
sudo dnf install zip -y

# Install sdkman in order to get newer versions of Java and Maven. Then install Quarkus, Java, and Maven.
echo "installing sdkman"
curl -s "https://get.sdkman.io" | bash
source "/home/instruct/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.3-tem

# # Clone parasol app
# echo "cloning parasol-insurance"
# git clone https://github.com/rh-rad-ai-roadshow/parasol-insurance.git $HOME/workshop/parasol-insurance