# TFRPM01 testing and demonstration software  


## Prerequisites

Expected Linux kernel module: i2c_dev

## Build

Set the Bus and Address in the source code.

    gcc rtc_1.c i2c_functions.c



# TFRPM01 interactive testing utility

The testing utility used to verify proper function of TFRPM01 device. The utility needs the following elementary testing rig for proper function. 

## Prerequirements
* python3
* [pymlab](https://github.com/MLAB-project/pymlab) with installed I2C drivers e.g. smbus2
* [beepy](https://pypi.org/project/beepy/)
* curses
* argparse


## Usage:

```
cd pymlab_interactive
python3 quality_check.py --port 9 --address 0x50 --req_freq 489 --max_deviation 10
```

`--port` smbus port
`--address` I2C address of TFRPM counter
`--req_freq`
`--max_deviation`

## Screenshots
![Valid test](/doc/img/test_passed.png)
