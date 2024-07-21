## Introduction

This repository enhances the existing workshop content. 

## Credits

Based on the following sources:
* [James Labocki](https://github.com/jameslabocki/ilabdemo/blob/main/install.sh)
* Summit 2024 InstructLab [content](https://github.com/rhpds/showroom_instructlab_summit2024/tree/main)
* InstructLab [setup](https://github.com/redhat-cop/agnosticd/tree/development/ansible/roles/ai_setup_ilab)

## Setup Guide

1. Order a [demo catalogue](https://demo.redhat.com/catalog?item=babylon-catalog-prod/rhdp.instructlab-rhel.prod&utm_source=webapp&utm_medium=share-link)

2. SSH into the vm and git clone the repo under the `instruct` user:

    ```bash
    git clone https://github.com/tsailiming/instructlab-workshop
    ```

3. Run the install script.

  
    ```bash
    cd instructlab-workshop && 
    bin/install.sh
    ```

> [!NOTE]  
> `llama_cpp_python` can take 15mins to compile and install. 

4. Accesss the updated showroom content

## Changes

1. The `bin/install.sh` will setup InstructLab with `instructlab==0.18.0a4` and ensure `llama_cpp_python` has GPU offload support enabled. 

2. A sample [Parasol](https://github.com/rh-rad-ai-roadshow/parasol-insurance.git) application is deployed in the showroom instructions.

3. The updated showroom content can be viewed [here](showroom/content/modules/ROOT/pages/index.adoc).