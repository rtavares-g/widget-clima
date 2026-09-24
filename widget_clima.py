#!/usr/bin/env python3
"""Widget do RaspController: mostra temperatura e umidade lidas do endpoint
/sensor do serviço sensor-pi (DHT22).

Roda uma vez e termina; para atualizar sozinho use o modo "recursive" do app.
Qualquer print sem a tag <resultN> vira uma caixa de diálogo de erro no app.
"""

import json
import os
import urllib.request

URL_SENSOR = os.environ.get("URL_SENSOR", "http://127.0.0.1:8080/sensor")
TIMEOUT_SEG = 3

try:
    with urllib.request.urlopen(URL_SENSOR, timeout=TIMEOUT_SEG) as resp:
        dados = json.load(resp)
except OSError as e:
    print(f"Serviço sensor-pi fora do ar ({URL_SENSOR}): {e}")
except ValueError as e:
    print(f"Resposta inválida de {URL_SENSOR}: {e}")
else:
    temperatura = dados.get("temperature")
    umidade = dados.get("humidity")
    if not dados.get("sensorOk") or temperatura is None or umidade is None:
        print("Sensor DHT22 sem leitura válida")
    else:
        print(f"<result1>{temperatura:.1f} °C</result1>")
        print(f"<result2>{umidade:.0f} %</result2>")
