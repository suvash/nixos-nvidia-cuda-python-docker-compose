# Docker+Compose with CUDA (Nvidia container toolkit) + Jupyter & Python DL libraries on NixOS guide

This repository includes a step-by-step guide for :
- running deep learning libraries(such as pytorch 2.1, vllm on jupyterlab)
- in docker containers
- via docker-compose
- with full CUDA support (container Cuda version: 12.1)
- on NixOS hosts (Cuda Version: 12.3)

The primary target of the usage guide is for setting up deep learning projects on NixOS systems with Nvidia GPUs.

## If you're on NixOS

Follow the guide from step 01.

- [Step 01 : Setup Nvidia driver on NixOS](./01-nixos-nvidia-setup.org)
- [Step 02 : Setup Docker on NixOS with Nvidia container toolkit integration](./02-nixos-docker-nvidia-setup.org)

The following steps are not specific to NixOS. Continue along !

## If you're not on NixOS, but have installed Docker + Nvidia container toolkit successfully, and pass the tests mentioned in step 02

Follow the guide from step 03.

- [Step 03 : Setup Docker Compose with GPU device access](./03-nvidia-docker-compose-setup.org)
- [Step 04 : Prepare a base Python image with DL libraries](./04-base-image-with-python-and-required-libraries.org)
- [Step 05 : Prepare a Compose project with base image, JupyterLab & libs](./05-docker-compose-project-base-image-jupyter-and-friends.org)

# Just a heads up

While most of the files (and project folders are provided), you might have to update a couple of files, specially towards the final step. So, taking the time to go through the documentation is definitely advised.


# Contributions

This guide is definitely most well suited for the author's personal usage. However, contributions are most welcome.

There's a fair chance that this document might not be working (or simply, outdated) by the time you see this. Please feel free to open an issue in that case.
