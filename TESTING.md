# Testování TFRPM01


## Testování s PX4 autopilotem

### Pomocí QGroundControlu
V QGC přejdete do `menu` > `Analyze tools` > `Mavlink Inspector`

Zde v levém sloupci najděte zprávu `raw_rpm`. Pokud neexistuje, je potřeba zjistit, jestli je driver senzoru spuštěný. 
Pokud se tam zpráva vyskytuje, klikněte na ní. V pravé části pak uvidíte živá data. 

### Pomocí PX4 (NuttX) konzole
Jestli máte spuštěný driver zjistíte příkazem: 
```
pcf8583 status
```
Pokud je driver spuštěn, bude vypsán port a základní nastavení spuštěné instance.  V případě že driver neběží, tak je potřeba jej spustit

The driver does not start automatically in any airframes. You can start it manually from the console or add it to the [startup script](../concept/system_startup.md#customizing-the-system-startup) on SD card.

#### Start driver from console
Start driver from the [console](https://docs.qgroundcontrol.com/master/en/analyze_view/mavlink_console.html) with the command:
```
pcf8583 start -X -b <bus number>
```
insted of `<bus number>` you must specify the bus number to which the device is connected. `-X` means that it is external bus.

:::note
Bus number `-b <bus number>` does not match the bus numbering on the autopilot. After running the command, the driver shows the bus number corresponding to the label on the box.

When using CUAV V5+ or CUAV Nano:

| bus label | -b number |
|-----------|-----------|
| 1    |  -X -b 4  |
| 2    |  -X -b 2  |
| 3    |  -X -b 1  |

:::

**Vypsání posledních měřených hodnot**
```
listener rpm -n 100
```
_parametr `-n` nastavuje počet vypsaných zpráv_

## Základní (manuální) testování
Základní testování TFRPM01 po výrobě lze provést pomocí python [skriptu](/sw/pymlab/TFRPM_readout.py) postaveném na knihovně [PyMLAB](https://github.com/MLAB-project/pymlab). 


Skript ze složky `/sw/pymlab/` spustíte příkazem:

```
sudo python3 TFRPM_readout.py 0 0x50
```

Po úspěšném spuštění by se měly objevit měřené hodnoty. Nyní, pomocí nějaké sondy nebo uzeměním signálového pinu, simulujte čitací signál. Hodnota `count` by měla růst. Pro přesnější měření lze použit signál generovaný osciloskopem nebo jiným zdrojem pilového signálu. 


Výstup pak může vypadat následovně: 

```bash
TFRPM01 test suite.
{'port': '0', 'device': None, 'serial_number': None}
counter module example 

1608153501.8307571; count: 0, freq: 0.00, integration_time: 0.03
1608153502.3609016; count: 0, freq: 0.00, integration_time: 0.56
1608153502.8917809; count: 0, freq: 0.00, integration_time: 1.09
1608153503.4219267; count: 0, freq: 0.00, integration_time: 1.62
1608153503.9529395; count: 0, freq: 0.00, integration_time: 2.15
1608153504.4839747; count: 0, freq: 0.00, integration_time: 2.68
1608153505.0149646; count: 0, freq: 0.00, integration_time: 3.21
1608153505.5448906; count: 0, freq: 0.00, integration_time: 3.74
1608153506.0749886; count: 0, freq: 0.00, integration_time: 4.27
1608153506.6050436; count: 0, freq: 0.00, integration_time: 4.80
1608153507.136024; count: 0, freq: 0.00, integration_time: 5.34
1608153507.6670556; count: 0, freq: 0.00, integration_time: 5.87
1608153508.197005; count: 0, freq: 0.00, integration_time: 6.40
1608153508.728068; count: 0, freq: 0.00, integration_time: 6.93
1608153509.2590628; count: 2, freq: 0.27, integration_time: 7.46
1608153509.7890441; count: 5, freq: 0.63, integration_time: 7.99
1608153510.3190136; count: 8, freq: 0.94, integration_time: 8.52
1608153510.8490016; count: 11, freq: 1.22, integration_time: 9.05
1608153511.3801253; count: 14, freq: 1.46, integration_time: 9.58
```

V prvním sloupci je čas. Následuje počet detekovaných signálů, určená frekvence a čas po kterou je frekvence počitána. 


## Automatické testování
