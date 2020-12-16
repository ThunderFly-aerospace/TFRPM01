#include "i2c_functions.h"


#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

//RTC

void initCounter()
{
   setRegister(0x00,0b00100000);
}

int getCounter()
{
      uint8_t a = readRegister(0x01);
      uint8_t b = readRegister(0x02);
      uint8_t c = readRegister(0x03);

      return (int)((a&0x0f)*1 + ((a&0xf0)>>4)*10 + (b&0x0f)*100 + ((b&0xf0)>>4)*1000+ (c&0x0f)*10000 + ((c&0xf0)>>4)*1000000);
}

void resetCounter()
{	
        setRegister(0x01,0x00);
        setRegister(0x02,0x00);
        setRegister(0x03,0x00);
}



int main(int argc, char ** argv)
{

   int bus=5;
   int addr=0x50;

   i2c_open(bus,addr);

   initCounter();

   int i=1;
   for(i=0;i<60;i++)
   {
      //resetCounter();
      sleep(1);
      printf("%d\n",getCounter());
   }

   i2c_close();

   return 0;
}
