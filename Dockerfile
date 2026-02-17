FROM ubuntu:noble

RUN apt-get update && apt-get -y install nodejs npm git curl wget jq pipx cookiecutter sudo

RUN npm install -g @anthropic-ai/claude-code

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG USERNAME=claude

RUN groupadd -g ${GROUP_ID} ${USERNAME} && \
    useradd -m -u ${USER_ID} -g ${GROUP_ID} -s /bin/bash ${USERNAME}

USER ${USERNAME}
