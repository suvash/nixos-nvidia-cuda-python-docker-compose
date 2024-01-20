FROM suvash/deeplibs:py3.11-cuda12.1-ubuntu22.04-<CORRECT-SHA>

ENV PATH="/opt/bin:$PATH" \
    APP_DIR="/app" \
    JUPYTER_CONFIG_DIR="/app/.jupyter"

WORKDIR "$APP_DIR"

COPY ./app/requirements.txt "$APP_DIR/requirements.txt"
RUN set -exu \
    \
    && . "$CONDA_DIR/etc/profile.d/conda.sh" \
    && conda activate "$CONDA_ENV" \
    && sg "$CONDA_GROUP" -c "pip install --no-cache-dir \
                                         -r $APP_DIR/requirements.txt"

RUN set -exu \
    \
    && chmod -R g+w "$CONDA_DIR"

COPY ./app/.jupyter "$JUPYTER_CONFIG_DIR"
COPY ./bin /opt/bin

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
CMD ["/bin/bash"]
