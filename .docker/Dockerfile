ARG PHP_VERSION=8.4
ARG NODE_VERSION=24

# =================================================================
# Base Image
# =================================================================
FROM serversideup/php:${PHP_VERSION}-fpm-nginx AS base

USER root

RUN install-php-extensions intl bcmath gd imagick

# =================================================================
# Development Stage 1: Configuration, custom scripts and dependencies installation
# =================================================================
FROM base AS development

ARG USER_ID=1000
ARG GROUP_ID=1000

USER root

RUN docker-php-serversideup-set-id www-data $USER_ID:$GROUP_ID  && \
    docker-php-serversideup-set-file-permissions --owner $USER_ID:$GROUP_ID
    
USER www-data

# =================================================================
# Deployment Stage 1: Configuration, custom scripts and dependencies installation
# =================================================================
FROM base AS setup

USER root

COPY --chmod=755 ./.docker/entrypoint.d/ /etc/entrypoint.d/

COPY . /var/www/html

RUN composer install --no-dev --optimize-autoloader 

# =================================================================
# Deployment Stage 2: Frontend assets compilation (node, npm, etc.)
# =================================================================
FROM node:${NODE_VERSION}-alpine AS static-assets

WORKDIR /app

COPY --chown=node:node package*.json vite.config.js ./
COPY --chown=node:node resources ./resources
COPY --from=setup --chown=node:node /var/www/html/vendor ./vendor

RUN --mount=type=cache,target=/root/.npm \
    npm ci

RUN npm run build

############################################
# Deployment Final Stage: Deployment
############################################
FROM base AS deployment

USER root

COPY --from=setup /var/www/html /var/www/html

COPY --from=static-assets /app/public/build /var/www/html/public/build

RUN chown -R www-data:www-data /var/www/html

USER www-data