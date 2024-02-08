# TFRPM01 testing and demonstration software  


## Prerequisites

Expected Linux kernel module: i2c_dev

## Build

Set Bus and Address in source code.

    gcc rtc_1.c i2c_functions.c



# TFRPM01 interactive testing utility

```
cd pymlab_interactive
python3 quality_check.py --port 7 --address 0x50 --req_freq 1000 --max_deviation 500
```

## Prerequirements 
* python3
* pymlab
* curses
* argparse 


## Usage: 

```
python3 quality_check.py --port 7 --address 0x50 --req_freq 1000 --max_deviation 500
```

`--port` smbus port 
`--address` I2C address of TFRPM counter
`--req_freq` 
`--max_deviation`

## Screenshots

