FROM bitnami/wordpress:latest

# Copy custom scripts
COPY --chmod=+x scripts/install_composer.sh /usr/local/bin/install_composer.sh
COPY --chmod=+x scripts/configure_wp.sh /usr/local/bin/configure_wp.sh


# Install Composer
RUN chmod +x /usr/local/bin/install_composer.sh \
    && chmod +x /usr/local/bin/configure_wp.sh
