FROM tyrm/mastodon:v3.1.1

ADD styles/  /opt/mastodon/app/javascript/styles/
COPY themes.yml /opt/mastodon/config/themes.yml
COPY en.yml /opt/mastodon/config/locales/en.yml

USER root

RUN chown -R mastodon:mastodon /opt/mastodon/app/javascript/styles /opt/mastodon/config/themes.yml /opt/mastodon/config/locales/en.yml

USER mastodon

RUN cd ~ && \
    OTP_SECRET=precompile_placeholder SECRET_KEY_BASE=precompile_placeholder rails assets:precompile && \
    yarn cache clean
