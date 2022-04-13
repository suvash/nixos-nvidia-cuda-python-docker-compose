FROM nvidia/cuda:11.6.2-devel-ubuntu20.04

RUN set -exu \
    \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
               bzip2 \
               ca-certificates \
               wget \
               curl \
               jq \
               gosu \
    && apt-get clean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/apt/lists/* \
    && gosu nobody true

ARG WORKDIR="/workspace"
ARG CONDA_DIR="/conda"
ARG CONDA_GROUP="conda"
ARG CONDA_ENV="py310-cuda116"
ARG CONDA_VERSION="py39_4.11.0"
ARG CONDA_SHA256SUM="4ee9c3aa53329cd7a63b49877c0babb49b19b7e5af29807b793a76bdb1d362b4"

ENV CONDA_AUTO_UPDATE_CONDA=false \
    CONDA_DIR="$CONDA_DIR" \
    CONDA_ENV="$CONDA_ENV" \
    CONDA_GROUP="$CONDA_GROUP" \
    PATH="$CONDA_DIR/bin:$PATH"

RUN set -exu \
    \
    && MINICONDA_URL="https://repo.continuum.io/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh" \
    && wget "$MINICONDA_URL" -O /tmp/miniconda.sh \
    && echo "$CONDA_SHA256SUM /tmp/miniconda.sh" > /tmp/shashum.txt \
    && sha256sum --check --status /tmp/shashum.txt \
    && groupadd "$CONDA_GROUP" \
    && sg "$CONDA_GROUP" -c "sh /tmp/miniconda.sh -b -p $CONDA_DIR" \
    && rm /tmp/miniconda.sh /tmp/shashum.txt \
    && ln -s "$CONDA_DIR/etc/profile.d/conda.sh" /etc/profile.d/conda.sh \
    && echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> "$HOME/.bashrc" \
    && find "$CONDA_DIR" -follow -type f -name '*.a' -delete \
    && find "$CONDA_DIR" -follow -type f -name '*.js.map' -delete \
    && conda clean -afy

COPY ./environment.yml "/tmp/$CONDA_ENV/environment.yml"
RUN sed -i "s/CONDA_ENV/$CONDA_ENV/g" "/tmp/$CONDA_ENV/environment.yml" \
    && sg "$CONDA_GROUP" -c "conda env create -f /tmp/$CONDA_ENV/environment.yml" \
    && echo "conda activate $CONDA_ENV" >> "$HOME/.bashrc"

COPY ./pytorch.requirements.txt "/tmp/$CONDA_ENV/pytorch.requirements.txt"
RUN set -exu \
    \
    && . "$CONDA_DIR/etc/profile.d/conda.sh" \
    && conda activate "$CONDA_ENV" \
    && sg "$CONDA_GROUP" -c "pip install --no-cache-dir \
                                         -r /tmp/$CONDA_ENV/pytorch.requirements.txt \
                                         -f https://download.pytorch.org/whl/torch_stable.html"

COPY ./jax.requirements.txt "/tmp/$CONDA_ENV/jax.requirements.txt"
RUN set -exu \
    \
    && . "$CONDA_DIR/etc/profile.d/conda.sh" \
    && conda activate "$CONDA_ENV" \
    && sg "$CONDA_GROUP" -c "pip install --no-cache-dir \
                                         -r /tmp/$CONDA_ENV/jax.requirements.txt \
                                         -f https://storage.googleapis.com/jax-releases/jax_releases.html"

WORKDIR "$WORKDIR"
