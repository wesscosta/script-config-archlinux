#!/bin/bash

echo "========== ATUALIZANDO SISTEMA =========="
sudo pacman -Syu --noconfirm

echo "========== OTIMIZANDO OS MIRRORS =========="
# Instala o Reflector
sudo pacman -S --noconfirm reflector

# Atualiza os mirrors usando Reflector (pegando os 10 melhores)
sudo reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "========== OTIMIZANDO CONFIGURAÇÃO DO PACMAN =========="
# Faz backup da configuração original do pacman.conf
sudo cp /etc/pacman.conf /etc/pacman.conf.bak

# Habilita opções extras no pacman.conf
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
echo "ILoveCandy" | sudo tee -a /etc/pacman.conf > /dev/null

echo "========== INSTALANDO PACOTES ESSENCIAIS =========="
# Instala pacotes essenciais do repositório oficial
sudo pacman -S --noconfirm \
    base-devel \
    git \
    wget \
    curl \
    vim \
    zsh \
    nodejs \
    npm \
    python \
    docker \
    steam \
    lutris \
    nvidia \
    nvidia-utils \
    nvidia-settings \
    sddm \
    reflector \
    thunderbird \
    telegram-desktop \

# Habilita e inicia o SDDM
sudo systemctl enable sddm
sudo systemctl start sddm

echo "========== CONFIGURANDO O ZSH =========="
# Instala e configura o Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
    chsh -s $(which zsh)
fi

echo "========== INSTALANDO YAY (AUR) =========="
# Instala o yay se ainda não estiver instalado
if ! command -v yay &>/dev/null; then
    cd /opt
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R $USER:$USER yay
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

echo "========== INSTALANDO PACOTES DO AUR =========="
aur_packages=(
    'visual-studio-code-bin'
    'google-chrome'
    'microsoft-edge-stable-bin'
    'spotify'
    'postman-bin'
    'insomnia'
    'slack-desktop'
    'discord'
    'zoom'
    'teams'
    'notion-app-electron'
    'obs-studio'
    'android-studio'
    'react-native-cli'
    'zapzap'
    'docker-desktop'
    'dbeaver'
)

for package in "${aur_packages[@]}"; do
    if ! pacman -Qq $package &>/dev/null; then
        echo "Instalando $package do AUR..."
        yay -S --noconfirm $package
    else
        echo "$package já está instalado."
    fi
done

echo "========== ADICIONANDO USUÁRIO AO GRUPO DOCKER =========="
sudo usermod -aG docker $USER

echo "========== FINALIZANDO INSTALAÇÃO =========="
echo "Instalação concluída. O sistema será reiniciado em 5 segundos..."
sleep 5
sudo reboot
