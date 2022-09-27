#-----------------------------------------------------------------------------
# Ubuntu 22.04
#-----------------------------------------------------------------------------
FROM ubuntu:jammy

#-----------------------------------------------------------------------------
# Default user name
#-----------------------------------------------------------------------------
ARG USERNAME=ubuntu
ARG UID=1000
ARG DEBIAN_FRONTEND=nointeractive

RUN apt-get update \
#-----------------------------------------------------------------------------
# See also about download and install files are:
# https://packages.ubuntu.com/ja/jammy/all/software-properties-common/filelist
#-----------------------------------------------------------------------------
 && apt-get install -y --no-install-recommends software-properties-common gnupg-agent \
 && add-apt-repository -y ppa:git-core/ppa \
 && apt-get update -y \
#-----------------------------------------------------------------------------
# Install required dependencies in Homebrew
#-----------------------------------------------------------------------------
 && apt-get install -y --no-install-recommends \
      build-essential \
      procps \
      curl \
      file \
      git \
      locales \
      sudo \
#-----------------------------------------------------------------------------
# Clear apt caches
#-----------------------------------------------------------------------------
 && apt remove --purge -y software-properties-common \
 && apt autoremove --purge -y \
 && rm -rf /var/lib/apt/lists/* \
#-----------------------------------------------------------------------------
# Create users
#-----------------------------------------------------------------------------
 && localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && useradd \
      --uid         ${UID} \
      --user-group \
      --groups      sudo \
      --create-home \
      --shell       /bin/bash \
      ${USERNAME} \
 && useradd \
      --user-group \
      --groups      sudo \
      --create-home \
      --shell       /bin/bash \
      linuxbrew \
 && sed -i "s#(ALL:ALL)#NOPASSWD:#g" /etc/sudoers \
 && echo "export PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linubrew/sbin:${PATH}" \
       > /etc/profile.d/02-set-path.sh \
 && chmod +x /etc/profile.d/02-set-path.sh
ENV HOMEBREW_AUTOREMOVE=
ENV HOMEBREW_NO_INSTALL_CLEANUP=1
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linubrew/sbin:${PATH}"

#-----------------------------------------------------------------------------
# Install Homebrew on Linux
#-----------------------------------------------------------------------------
USER linuxbrew
WORKDIR /home/linuxbrew
RUN git clone https://github.com/Homebrew/brew.git /home/linuxbrew/Homebrew \
 && mkdir -p \
      .linuxbrew/bin \
      .linuxbrew/etc \
      .linuxbrew/include \
      .linuxbrew/lib \
      .linuxbrew/opt \
      .linuxbrew/sbin \
      .linuxbrew/share \
      .linuxbrew/var/homebrew/linked \
      .linuxbrew/Cellar \  
 && mkdir -p .linuxbrew/Homebrew \
 && mv ./Homebrew .linuxbrew \
 && ln -s ../Homebrew/bin/brew .linuxbrew/bin/brew \
 && git -C .linuxbrew/Homebrew remote set-url origin https://github.com/Homebrew/brew \
 && git -C .linuxbrew/Homebrew fetch origin \
 && HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_AUTO_UPDATE=1 brew tap homebrew/core \
 && brew install-bundler-gems \
 && brew cleanup --prune=all \
 && { git -C .linuxbrew/Homebrew config --unset gc.auto; true; } \
 && { git -C .linuxbrew/Homebrew config --unset homebrew.devcmdrun; true; } \
 && rm -rf .cache \
 && sudo chown -R ${USERNAME}:${USERNAME} .

#-----------------------------------------------------------------------------
# Configure enviroments for the default user
#-----------------------------------------------------------------------------
USER ${USERNAME}
WORKDIR /home/${USERNAME}
ENV HOME=/home/${USERNAME}
RUN mkdir -p .config \
 && echo "alias sudo='sudo -i'" >> .bashrc \
 && echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >> .bashrc \
 && echo "export PATH=\"${HOME}/.local/bin:${PATH}\"" >> .bashrc 
