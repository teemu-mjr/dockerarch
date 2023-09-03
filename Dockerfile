FROM archlinux:latest

# update and install git
RUN pacman -Syyu --noconfirm && \
  pacman -S --noconfirm \
    git

# clone .dotfiles
WORKDIR /root
RUN git clone https://github.com/teemu-mjr/.dotfiles --depth 1

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
  tmux \
  neovim

# clone nvim
WORKDIR /root/.config
RUN git clone https://github.com/teemu-mjr/nvim --depth 1

# sync neovim
WORKDIR /root
RUN nvim --headless "+Lazy! sync" +qa
