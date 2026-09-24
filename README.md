# widget-clima

Widget personalizado do app **RaspController** que mostra a temperatura e a
umidade do quarto, lidas do endpoint `/sensor` do serviço `sensor-pi`
(DHT22, porta 8080).

O script roda uma vez e termina; para atualizar sozinho, use o modo
"recursive" do widget no app. Só usa a biblioteca padrão do Python.

| Situação | Saída |
|---|---|
| leitura ok | `<result1>23.5</result1>` (°C) e `<result2>67.0</result2>` (%) |
| sensor sem leitura válida (`sensorOk` falso) | mensagem de erro |
| `sensor-pi` fora do ar | mensagem de erro |

Qualquer saída sem as tags `<resultN>` aparece como caixa de diálogo de erro
no app, o que é usado de propósito para avisar dos problemas acima. Os
valores saem só como número (sem unidade) para funcionarem nos medidores
(gauge) do app; a unidade é configurada no próprio widget.

## Instalação

```
git clone https://github.com/rtavares-g/widget-clima.git ~/widget-clima
cd ~/widget-clima
./install.sh
```

O `install.sh` garante o `python3`, avisa se o serviço `sensor-quarto` não
estiver rodando, mostra a saída atual do widget e o comando para cadastrar no
app:

```
python3 /home/raspberry/widget-clima/widget_clima.py
```

## Arquivos

| Arquivo | Função |
|---|---|
| `widget_clima.py` | consulta o `/sensor` e imprime os resultados para o app |
| `install.sh` | instalação/reinstalação |

## Configuração

| Variável | Padrão | Descrição |
|---|---|---|
| `URL_SENSOR` | `http://127.0.0.1:8080/sensor` | endpoint JSON do sensor-pi |

## Testar

```
python3 widget_clima.py
```
