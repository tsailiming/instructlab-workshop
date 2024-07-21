#!/bin/sh
# Adapted from https://github.com/jameslabocki/ilabdemo/blob/main/install.sh#L44
# Runs on Red Hat Demo Platform - InstructLab RHEL VM (Nvidia/CUDA) 

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "ROOT DIR: ${ROOT_DIR}"

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
# Ensure llma_cpp has CUDA support
pip uninstall llama_cpp_python -y
pip install --force-reinstall "llama_cpp_python[server]==0.2.79" --config-settings cmake.args="-DLLAMA_CUDA=on"

# Install InstructLab
pip install -r $ROOT_DIR/requirements.txt
pip install 'numpy<2.0'

#ilab init --non-interactive
cp $ROOT_DIR/artifacts/config.yaml ~/workshop/config.yaml
cp $ROOT_DIR/artifacts/ilab-qna.yaml ~/workshop/ilab-qna.yaml 

ln -sf $HOME/.local/share/instructlab/taxonomy $ILAB_HOME/.
ln -sf $HOME/.local/share/instructlab/datasets $ILAB_HOME/.
ln -sf $HOME/.local/share/instructlab/models $ILAB_HOME/.

# Copy parasol model
cp $ROOT_DIR/artifacts/ggml-parasol-pretrained-Q4_K_M.gguf ~/workshop/ggml-parasol-pretrained-Q4_K_M.gguf

(cd $ROOT_DIR && make build-content)

# Install zip
echo "installing zip"
sleep 1
sudo dnf install zip -y

# Install sdkman in order to get newer versions of Java and Maven. Then install Quarkus, Java, and Maven.
echo "installing sdkman"
curl -s "https://get.sdkman.io" | bash
source "/home/instruct/.sdkman/bin/sdkman-init.sh"
sdk install java 21.0.3-tem