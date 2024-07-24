## Introduction

This playbook runs ansible commands to amend the workshop content across all provisioned InstructLab environments

## Guide
1. Amend your inventory.ini, ensure that all the necessary fields are there.

    - Host
    - FQDN
    - ssh User
    - ssh Password

2. The workshop setup takes about 10 mins to 20 mins (depending on factors like internet connectivity) to complete. Amend the `ansible.cfg` file if needed to fit the number of forks to suit your needs in executing the setup in parallel.

3. Run ansible-playbook command

```bash
ansible-playbook main.yaml -i inventory.ini
```