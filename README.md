# TFRPM01C - RPM measuring device

Revolutions per minute meter for UAV.
It is designed to direct connection to Pixhawk controller (CUAV V5+) trough standard I²C connector. The device [is supported by PX4 firmware](https://docs.px4.io/master/en/sensor/thunderfly_tachometer.html).
At the input of meter is supposed a pulse signal from optical encoder, hall sensor etc.
The hardware is inteded to be used for helicopter and autogyro rotor RPM measurement, but its counting capability is up to 20 kHz therefore it should be used for propeller or engine RPM measurement.

## Where to get it?

ThunderFly RPM counter is commercially available from [ThunderFly s.r.o.](https://www.thunderfly.cz/), write an email to info@thunderfly.cz or shop at [Tindie store](https://www.tindie.com/products/thunderfly/tfrpm01-drone-rpm-tachometer-sensor/).


## Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| Pulse frequency range | 0 - 20 kHz (equal high and low periods) | Maximum RPM value varies by pulse number per revolution |
| I2C Connector | 2x 4-pin JST-GH | Connected in parallel |
| RPM connector | 3-pin 2.54mm pitch header | Internal 22k Ohm pullup resistor |
| I2C adress | 0x50 default | By switching JP1 possible change to 0x51 |
| Operating and storage temperature | -20 - +40°C | Limited by case material |
| Operational input voltage | 3.6 - 5.4V | Overvoltage internally protected by zener diode |
| Mass | 4 g + 8 g | PCB + case |
| Dimensions | 23.5x42x12.5mm / 37.5x19mm | Case / PCB |
| Weather resistance | IP40 | External connectors fully occupied |

## Features

  * Short circuit protection on probe connector
  * Input status LED indicator - [optionally visible at daylight](/doc/README.md)
  * Pass-trough I²C connectors to allow daisy chain of different sensors
  * Offload flight controller's MCU, by storing the number of counted pulses in internal memory


![Top view on I2C RPM sensor](/doc/img/TFRPM01C_case.jpg)

![Bottom view on I2C RPM sensor](/doc/img/TFRPM01C_pcb.jpg)

The 3Pin probe connector is powered from I²C bus trough RC filter which limits current and voltage spikes to sensor probe.
Therefore sensor is resistant to short circuit at the probe connector power.

The two I²C Pixhawk connectors are connected to each other. This feature allows easily nesting with other I²C devices to single Pixhawks I²C port.

### Connection to the Pixhawk autopilot

The I²C interface connectors respects the [Pixhawk connector standard](https://github.com/pixhawk/Pixhawk-Standards/blob/master/DS-009%20Pixhawk%20Connector%20Standard.pdf). The signal and color coding of the connector and supplied cable are described by following table (ThunderFly color scheme): 

|Signal | Pixhawk Color | ThunderFly color |
|--------|------------------|---------------------|
| +5V    | Red | ![red](https://user-images.githubusercontent.com/5196729/102204855-ab1c3300-3eca-11eb-8083-646d633e3aef.png) Red |
| SCL  | Black |  ![yellow](https://user-images.githubusercontent.com/5196729/102204908-bc653f80-3eca-11eb-9a1d-a02ea5481c03.png) Yellow  |
| SDA  | Black |  ![green](https://user-images.githubusercontent.com/5196729/102205114-04846200-3ecb-11eb-8eb8-251c7e564707.png) Green |
| GND | Black  | ![black](https://user-images.githubusercontent.com/5196729/102204896-b8d1b880-3eca-11eb-8b73-656cac9104e4.png) Black | 

The conductor colors in the cable are different to Pixhawk standard to increase the visual distinction between multiple cables in the UAV.

#### Cable turnig 

To improve I2C bus reliability, the supplied cable is specifically turned by following scheme

- 10 turns for each pair SCL/+5V and SDA/GND per 30cm cable length
- The two pairs are turned again by 4 turns of pairs per 30cm cable length. 

This special cable conductors winding method, greatly improves the signal integrity by minimising of the crosstalk between the SDA and SCL signals. 

### I²C Address configuration

By default the TFRPM01C sensor is manufactured with 0x50 I²C address. This address is possible to change to 0x51 by altering the JP1 solder junction. The junction connection to GND needs to be cut by knife and then soldered to opposite side Vcc.

The default configuration of the junction corresponds to following picture, where center pin is connected to GND by copper trace.

![The default 0x50 address setup](/doc/img/JP1_address_0x50_config.png)

### Mounting options

The device is designed to be mouted with or without plastic case. The 3D printed case is intended to be modifable to particular sensor mount options. The supplied variant of 3D printed case supports two mount options:

  * By default the case could be mounted by screw on flat sulface (the original screew need to be replaced by longer one)
  * The second option is use of [double sided adhesive tape](https://www.3m.com/3M/en_US/vhb-tapes-us/) or [reclosable fastener](https://www.3m.com/3M/en_US/dual-lock-reclosable-fasteners-us/) sticked on the side of the TFRPM01 case. 

#### PCB dimensions

![PCB dimensions](doc/img/TFRPM01C_PCB_dimensions.png)

The PCB is designed to be mounted on flat surface by center screw hole. The supposed screw diameter is metric 3mm e.g. DIN 912 M3 Hexagon socket Head Cap Screws. 


### Sensor options

The sensor could be used with multiple sensor probes. The most used one is a hall effect probe.


![TFRPM01B hall effect magnetic sensor](/doc/img/TFRPM01B_hall_sensor.jpg)

The probe should be connected to the sensor board as follows (- Black, + Red, Pulse Blue)

![TFRPM01B hall effect magnetic sensor connection](/doc/img/TFRPM01B_hall_connection.jpg)

Correct connection of the probe could be check by magnet, the PULSE LED switch on and off according to magnet presence. The sensor board needs to be powered from at least one I²C port during the test.

The sensor could also be used with other probe types. The one example is [TFPROBE01](https://github.com/ThunderFly-aerospace/TFPROBE01), which combines the optical reflective sensor and magnetic hall-effect sensor in one device. However the TFRPM01 sensor needs matching the input parameters to certain probe types. The default configuration is reflected in the following schematics.

![TFRPM01B probe input circuit](/doc/img/TFRPM01_pulse_counter_input.png)

As can be seen from the schematics the default probe power selection is +5V, protected by resistor R2 to about 61 mA short-circuit current. The pull-up resistor R1 with default value 22 kOhm is quite hard and it is generally unsuitable to most optical probes with open-collector outputs. Therefore the resistor R1 should be interchanged to a more suitable value. It is depending on the selected material for the optical sensor this value might need further fine-tuning. (The specific resistor value could be requested during the order process in case of ordering a larger quantity).
