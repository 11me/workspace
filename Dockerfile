FROM ubuntu:latest

# Set the locale to UTF-8
ENV LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y \
        sudo xclip \
        curl tmux \
        unzip git \
        man iproute2 \
        net-tools dnsutils \
        tcpdump \
        ripgrep \
        ssh build-essential \
        make fontconfig && \
        yes | unminimize && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    curl -L -o /tmp/nerdfonts.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip" && \
    unzip -q -d /usr/share/fonts/truetype/nerdfonts /tmp/nerdfonts.zip && \
    fc-cache -f -v && \
    rm /tmp/nerdfonts.zip && \
    groupadd -g 1000 lime && \
    useradd -m -u 1000 -g 1000 -s /bin/bash lime && \
    echo "lime ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/lime

RUN curl -LO https://get.helm.sh/helm-v3.8.2-linux-amd64.tar.gz && \
    tar -zxvf helm-v3.8.2-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf helm-v3.5.3-linux-amd64.tar.gz linux-amd64 && \
    curl -LO https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_amd64 && \
    mv helmfile_linux_amd64 /usr/local/bin/helmfile && \
    chmod +x /usr/local/bin/helmfile && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws && \
    curl -LO 'https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl' && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -L -o /tmp/nvim.deb 'https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb' && \
    dpkg -i /tmp/nvim.deb && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
         /home/lime/.local/share/nvim/site/pack/packer/start/packer.nvim && \
         chown -R "lime:lime" /home/lime/.local/share/nvim && \
    curl -L -o /tmp/go.tar.gz https://go.dev/dl/go1.20.2.linux-amd64.tar.gz && \
        tar xzf /tmp/go.tar.gz && \
        mv -T go /usr/bin/go

USER lime
WORKDIR /home/lime

CMD ["/bin/bash"]

