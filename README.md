# Script de Pós-Instalação do Arch Linux

Este script automatiza a pós-instalação do Arch Linux, configurando o sistema para um uso otimizado em uma máquina **Asus TUF F15** com **KDE Plasma** e **Zsh**. Ele instala pacotes essenciais, configura o `pacman`, otimiza os mirrors com `Reflector` e instala pacotes do AUR via `yay`.

## Recursos do Script

- **Atualização do Sistema**
- **Otimiza os mirrors com Reflector** (selecionando os mais rápidos e recentes)
- **Configura o ****`pacman.conf`**:
  - Habilita cores no terminal (`Color`)
  - Ativa downloads simultâneos (`ParallelDownloads = 10`)
  - Aplica personalização visual (`ILoveCandy`)
- **Instala pacotes essenciais**:
  - KDE Plasma e aplicativos
  - Drivers NVIDIA
  - Ferramentas de desenvolvimento (Node.js, Python, Docker, React Native CLI)
  - Steam e Lutris para jogos
- **Configuração do Zsh**:
  - Instala Oh My Zsh e plugins (`zsh-syntax-highlighting` e `zsh-autosuggestions`)
- **Instala o ****`yay`**** (AUR Helper)**
- **Instala pacotes do AUR**: Google Chrome, VS Code, Spotify, Postman, Discord, entre outros
- **Adiciona o usuário ao grupo ****`docker`** para permissão de execução sem `sudo`

---

## Como Usar

1. Clone este repositório e acesse o diretório:
   ```sh
   git clone https://github.com/wesscosta/script-config-archlinux.git
   cd seu-repositorio
   ```
2. Torne o script executável:
   ```sh
   chmod +x post-install.sh
   ```
3. Execute o script:
   ```sh
   ./post-install.sh
   ```

---

## Lista de Pacotes Instalados

### Pacotes Oficiais (Pacman)

```
base-devel git wget curl vim zsh nodejs npm python docker steam lutris
nvidia nvidia-utils nvidia-settings sddm plasma-meta kde-applications-meta reflector
```

### Pacotes do AUR (Yay)

```
visual-studio-code-bin google-chrome spotify postman-bin insomnia slack-desktop discord
zoom teams notion-app obs-studio android-studio react-native-cli
```

---

## Personalização e Modificações

Caso deseje modificar os pacotes ou configurações, edite o arquivo `post-install.sh` antes da execução.

---

## Reinicialização Automática

O script finaliza a execução com um **reboot automático** após 5 segundos. Caso não queira reiniciar imediatamente, comente a linha final do script.

---

## Autor

Desenvolvido por Weslley Costa. Contribuições são bem-vindas!

