# TFRPM01 sensor
Revolutions per minute meter for UAV.
It is designed to direct connection to Pixhawk controller (CUAV V5+) trough standard I²C connector.
At the input of meter is supposed a pulse signal from optical encoder, hall sensor etc.
The hardware is inteded to be used for helicopter and autogyro rotor RPM measurement, but its counting capability is up to 20 kHz therefore it should be used for propeller or engine RPM measurement.

![Top view on I2C RPM sensor](/doc/img/TFRPM01A_top_big.png)

![Bottom view on I2C RPM sensor](/doc/img/TFRPM01A_bot_big.png)

The 3Pin probe connector is powered from I²C bus trough RC filter which limits current and voltage spikes to sensor probe.
Therefore sensor is resistant to short circuit at the probe connector power. 

## Where to get it?

ThunderFly RPM counter is commercially available from [ThunderFly s.r.o.](https://www.thunderfly.cz/), write an email to info@thunderfly.cz or shop at [Tindie store](https://www.tindie.com/products/thunderfly/tfrpm01-drone-rpm-tachometer-sensor/).
