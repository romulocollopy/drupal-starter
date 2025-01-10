ARG VERSION="latest"

FROM drupal:${VERSION} AS dev

ARG USER="runner"
ENV HOME_DIR="/opt/drupal"
ENV APP_DIR="${HOME_DIR}/web"

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN /usr/sbin/useradd -m ${USER} -G www-data
COPY --chown=runner:www-data ./web ${APP_DIR}
COPY ./composer.json ${HOME_DIR}
COPY ./composer.lock ${HOME_DIR}

WORKDIR ${APP_DIR}
USER ${USER}
