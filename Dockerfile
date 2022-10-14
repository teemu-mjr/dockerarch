FROM archlinux:latest

# update and install git
RUN pacman -Syyu --noconfirm && \
  pacman -S --noconfirm \
    git

# clone .dotfiles
WORKDIR /root
RUN git clone https://github.com/teemu-mjr/.dotfiles --recursive

# install .dotfiles
WORKDIR /root/.dotfiles
RUN mkdir /root/.config
RUN ./install.sh --noconfirm
WORKDIR /root

# install other debs
RUN pacman -S --noconfirm \
  wget \
  curl \
  gcc \
  fish \
  neovim 

# install oh-my-posh
RUN wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh && \
  chmod +x /usr/local/bin/oh-my-posh

# sync neovim
RUN nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync"
RUN nvim --headless "+TSInstallSync! all" +qa
