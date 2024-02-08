# TFRPM01 testing and demonstration software  


## Prerequisites

Expected Linux kernel module: i2c_dev

## Build

Set the Bus and Address in the source code.

    gcc rtc_1.c i2c_functions.c



# TFRPM01 interactive testing utility

```
cd pymlab_interactive
python3 quality_check.py --port 7 --address 0x50 --req_freq 1000 --max_deviation 500
```

## Prerequirements 
* python3
* [pymlab](https://github.com/MLAB-project/pymlab) with installed I2C drivers e.g. smbus2
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
![obrazek](https://github.com/ThunderFly-aerospace/TFRPM01/assets/5196729/f1046602-cf83-4bb0-9f1a-cd9a75cdab36)

