#!/bin/bash
# Instala/reinstala o widget de temperatura e umidade do RaspController.
# Uso: ./install.sh   (rodar de dentro da pasta clonada do repositorio)

set -e

REPO_URL="https://github.com/rtavares-g/widget-clima.git"
INSTALL_DIR="$HOME/widget-clima"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
    if [ ! -d "$INSTALL_DIR" ]; then
        git clone "$REPO_URL" "$INSTALL_DIR"
    fi
    cd "$INSTALL_DIR"
else
    cd "$SCRIPT_DIR"
fi

sudo apt update
sudo apt install -y python3

chmod +x widget_clima.py

if ! systemctl is-active --quiet sensor-quarto; then
    echo "==> Aviso: servico sensor-quarto (sensor-pi) nao esta rodando - instale/inicie o sensor-pi"
fi

echo
echo "==> Saida atual do widget:"
python3 widget_clima.py || true

echo
echo "==> No app RaspController, crie/edite o widget personalizado com o comando:"
echo "    python3 $(pwd)/widget_clima.py"
