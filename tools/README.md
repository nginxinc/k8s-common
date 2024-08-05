# Tools

This directory contains the source code used to generate the VM image used in NGF tests.

## Building the VM image

To build the VM image, run the following command:

```bash
packer build -var 'project_id=<PROJECT_ID>' -var 'builder_sa=<BUILDER_SA>' build.pkr.hcl
```
