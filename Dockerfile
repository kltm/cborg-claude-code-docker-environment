FROM ubuntu:noble

RUN apt-get update && apt-get -y install nodejs npm git curl wget jq pipx cookiecutter sudo

RUN npm install -g @anthropic-ai/claude-code

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=claude

# If UID/GID already exist, reuse them; otherwise create fresh
RUN if id -u ${USER_ID} >/dev/null 2>&1; then \
      existing_user=$(getent passwd ${USER_ID} | cut -d: -f1) && \
      usermod -l ${USERNAME} -d /home/${USERNAME} -m "$existing_user" && \
      groupmod -n ${USERNAME} $(getent group ${GROUP_ID} | cut -d: -f1) ; \
    else \
      groupadd -g ${GROUP_ID} ${USERNAME} && \
      useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USERNAME} ; \
    fi

USER ${USERNAME}
