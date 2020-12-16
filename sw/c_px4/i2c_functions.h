//i2c_functions similar test communication code for PX4Firmware
//PX4Firmware provides only transfer function, 
//i2c_open and i2c_close is needed to implement transfer function on Linux

//setRegister and readRegister adn funcions like this hleps implement communication, 
//but they are not part of PX4Firmware


#include <stdint.h>

void i2c_open(int bus, int addr);
void i2c_close();
void transfer( uint8_t *send, unsigned send_len, uint8_t *recv, unsigned recv_len);
void setRegister(uint8_t reg, uint8_t value);
uint8_t readRegister(uint8_t reg);
//void setRegister16(uint8_t reg, uint16_t value);
uint16_t readRegister16(uint8_t reg);
