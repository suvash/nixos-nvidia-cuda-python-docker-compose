FROM suvash/deeplibs:py3.10-cuda12.2-ubuntu22.04-f798f2f

ENV PATH="/opt/bin:$PATH" \
    APP_DIR="/app"

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

COPY ./app/.jupyter "$APP_DIR/.jupyter"
COPY ./bin /opt/bin

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
CMD ["/bin/bash"]
