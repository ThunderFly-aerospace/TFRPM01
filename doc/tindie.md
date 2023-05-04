**TFRPM01D Will be stocked again at the beginning of may.**

# General Description

TFRPM01 is an open-source frequency sensor [tachometer](https://en.wikipedia.org/wiki/Tachometer) intended for the measurement of rotational actuators on drones. The TFRPM01 sensor itself does not contain a sensing probe. It needs to be connected externally. This allows you to connect a number of different probes based on different technologies. For basic diagnostics, the sensor is equipped with an LED indicator that shows the logic state of the input pin.

TFRPM01 is supported by Pixhawk autopilots with PX4. For the correct setting of the sensor, see the [official documentation](https://docs.px4.io/master/en/sensor/thunderfly_tachometer.html). The sensor is designed to be able to count high frequencies without overloading the autopilot CPU.

# Technical description

Sensor is based on I²C pulse counter IO [PCF8583](https://www.nxp.com/docs/en/data-sheet/PCF8583.pdf). 

I2C connector is a 4-pin JST-GH connector compliant with [Pixhawk Reference Standards](https://pixhawk.org/standards/). The second I2C connector can be used as a thought-pass I2C output and allows to connect another sensor. 

There can be two sensors on one bus. The default sensor address is 0x50. It can be changed to 0x51 by the use of soldering iron. A sensor with a different address is available on request.

For connecting the probe, the sensor is equipped with a standard three-pin header connector. The connector contains a power and signal pin. The order of pins is GND 5V Signal. It supports 5V TTL signals. The maximum pulse frequency of IO is 20 kHz with a 50% duty cycle. Maximal measured frequency and accuracy depend on the driver setting.


# Supported probes

## Hall-Effect Sensor Probe

Hall-Effect sensors (magnetically operated) are ideal for harsh environments, where dirt, dust, and water can contact the sensed rotor.

Many different hall-effect sensors are commercially available. For example, a 5100 Miniature Flange Mounting Proximity Sensor is a good choice. 

![Example of Hall effect probe](https://github.com/ThunderFly-aerospace/TFRPM01/raw/TFRPM01B/doc/img/TFRPM01B_hall_sensor.jpg "Hall effect probe")

## Optical Sensor Probe

The optical sensor can also be used (and maybe is a better fit, depending on the measurement requirements). Both transmissive and reflective sensor types may be used for pulse generation. We suggest the [TFPROBE01](https://github.com/ThunderFly-aerospace/TFPROBE01) reflective optical sensor, which is combined with optional magnetic sensing. 

![Optical Sensor Probe](https://raw.githubusercontent.com/ThunderFly-aerospace/TFPROBE01/TFPROBE01A/doc/img/TFPROBE01A_sensors.jpg "Optical sensor probe")

# PX4 configuration

How to set up the TRRPM01 sensor with [PX4](https://px4.io/) based autopilot is described in [official documentation](https://docs.px4.io/master/en/sensor/thunderfly_tachometer.html). PX4 driver acquires RPM frequency from the sensor and sends it as an internal uORB message. uORB message is logged in autopilot and translated to MAVLink message and can be received/visualized by a ground station (QGroundControl). 

![PlotJugles screen with RPM data](https://raw.githubusercontent.com/ThunderFly-aerospace/TFRPM01/TFRPM01C/doc/img/rpm_graph.png)

The sensor was tested with CUAV V5+ and CUAV Nano autopilot. Other PX4 based autopilots should be also supported with PX4 firmware.

## Use of multiple TFRPM01 sensors

In applications where multiple TFRPM01 are needed, the [TFI2CADT01](https://www.tindie.com/products/thunderfly/tfi2cadt01-i2c-address-translator/) module could be used. That allows the connection of up to six TFRPM01s to a single I2C port.

![Multiple sensors](https://raw.githubusercontent.com/ThunderFly-aerospace/TFI2CADT01/TFICADT01A/doc/img/TFI2CADT01_multi_TFRPM01.jpg)

# The package includes:
- TFRPM01D
- Plastic case

# Accessories

## I2C cables
I2C cables for connecting to the autopilot are not included in the package. You will need to purchase the cables separately from our [tindie catalog](https://www.tindie.com/stores/thunderfly/). We offer high-quality cables that are compatible with the [Pixhawk standard](https://raw.githubusercontent.com/pixhawk/Pixhawk-Standards/master/DS-009%20Pixhawk%20Connector%20Standard.pdf) and with a [ThunderFly color](https://docs.px4.io/main/en/assembly/cable_wiring.html#i2c-cables) scheme for easy signal identification. Our cables are specifically designed with improved resistance to electromagnetic interference and feature a silicone insulator that makes them highly flexible.

  * Length 15 cm - [TFCAB15I2C01](https://github.com/ThunderFly-aerospace/TFCAB01) [Buy at Tindie](https://www.tindie.com/products/thunderfly/tfcab15i2c01-15-cm-i2c-cable-for-pixhawk-drones/)
  * Length 30 cm - [TFCAB30I2C01](https://github.com/ThunderFly-aerospace/TFCAB01) [Buy at Tindie](https://www.tindie.com/products/thunderfly/tfcab30i2c01-30-cm-i2c-cable-for-pixhawk-drones/)
  * Length 45 cm - [TFCAB45I2C01](https://github.com/ThunderFly-aerospace/TFCAB01) [Buy at Tindie](https://www.tindie.com/products/thunderfly/tfcab45i2c01-45-cm-i2c-cable-for-pixhawk-drones/)


## Sensor probe

  * Hall probe with flange
  * Omnipolar magnetic and reflective optical probe [TFPROBE01](https://github.com/ThunderFly-aerospace/TFPROBE01)
