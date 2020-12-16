#!/usr/bin/python

import time
import datetime
import sys
from pymlab import config

#### Script Arguments ###############################################
sys.stderr.write("TFRPM01 test suite.\n")

if len(sys.argv) != 3:
    sys.stderr.write("Invalid number of arguments.\n")
    sys.stderr.write("Usage: %s PORT ADDRESS\n" % (sys.argv[0], ))
    sys.stderr.write("Address is 0x50 or 0x51.\n")
    sys.exit(1)

port    = sys.argv[1]
address = int(sys.argv[2],0)
#### Sensor Configuration ###########################################

cfg = config.Config(
    i2c = {
        "port": port,
        "device": None,  # OPTIONAL here you can explicitly set I2C driver with 'hid', 'smbus', 'serial'
        "serial_number": None, # OPTIONAL serial number of I2CUSB01A (CP2112 IO), works only with HID driver
    },
	bus = [
		{
           "name": "rtc01",
           "type": "rtc01",
           "address": address
        }
	]
)


cfg.initialize()
print("counter module example \r\n")
counter = cfg.get_device("rtc01")

#### Data readout ###################################################
counter.set_config(counter.FUNCT_MODE_count)
counter.reset_counter()

try:
    while True:
        count = counter.get_count()
        freq = counter.get_frequency()
        integration = counter.get_integration_time()

        print("{}; count: {}, freq: {:.2f}, integration_time: {:.2f}".format(time.time(), count, freq, integration))
        time.sleep(0.5)
        if count >= counter.MAX_COUNT/2:
            counter.reset_counter()
            print("Counter is over half of counting range. Counter was reseted")

except KeyboardInterrupt:
    sys.exit(0)
