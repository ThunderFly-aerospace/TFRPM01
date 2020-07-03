#include "i2c_functions.h"

#include <linux/i2c-dev.h>
#include <i2c/smbus.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

//from https://www.kernel.org/doc/Documentation/i2c/dev-interface

//I2C
int file;
int gaddr;

void i2c_open(int bus, int addr)
{
   gaddr=addr;

   char filename[20];

   snprintf(filename, 19, "/dev/i2c-%d", bus);
   file = open(filename, O_RDWR);

   if (file < 0) 
   {
       fprintf(stderr, "Chyba otevření: %s \n",filename);
       exit(1);
   }

   if (ioctl(file, I2C_SLAVE, addr) < 0) 
   {
       fprintf(stderr, "Chyba nastavení adresy : 0x%x \n", addr);
       exit(1);
   } 
}

void i2c_close()
{
   close(file);
}

/*void transfer(uint8_t *send, int sendlen, uint8_t *rcv, int rcvlen)
{
     if (file < 0) 
     {
         fprintf(stderr,"soubor neotevřen\n");
     }

     int ret;
     if(send!=NULL)
     {
        ret=write(file,send,sendlen);
        if(ret!=sendlen)
            fprintf(stderr,"chyba zápisu: %d\n", ret);
     }
     if(rcv!=NULL)
     {
        ret=read(file, rcv, rcvlen);
        if(rcvlen!=ret)
            fprintf(stderr,"chyba čtení: %d\n",ret);
     }
}*/

void transfer( uint8_t *send, unsigned send_len, uint8_t *recv, unsigned recv_len)
{

	struct i2c_msg msgv[2];
	unsigned msgs;

	msgs = 0;

	if (send_len > 0) {
		msgv[msgs].addr = gaddr;
		msgv[msgs].flags = 0;
		msgv[msgs].buf = send;
		msgv[msgs].len = send_len;
		msgs++;
	}

	if (recv_len > 0) {
		msgv[msgs].addr = gaddr;
		msgv[msgs].flags = I2C_M_RD;
		msgv[msgs].buf = recv;
		msgv[msgs].len = recv_len;
		msgs++;
	}

	if (msgs == 0) {
		return;
	}

	struct i2c_rdwr_ioctl_data packets;

	packets.msgs  = msgv;

	packets.nmsgs = msgs;

   int ret = ioctl(file, I2C_RDWR, (unsigned long)&packets);
   if (ret == -1) 
   {
				fprintf(stderr, "transfer failed\n");

	} 

}


//I2C -registrs
void setRegister(uint8_t reg, uint8_t value)
{
      uint8_t buff[2];
      buff[0]=reg;
      buff[1]=value;
      transfer(buff, 2, NULL, 0);

}

uint8_t readRegister(uint8_t reg)
{
      uint8_t rcv;
      transfer(&reg, 1, &rcv, 1);
      return rcv;
}

/*void 
setRegister16(uint8_t reg, uint16_t value)
{
      printf("check endians first...");
      uint8_t buff[3];
      buff[0]=reg;
      buff[1]= (uint8_t)((value & (uint16_t) 0xFF00) >> 8); //TODO: check indians 
      buff[2]=(uint8_t)( value & (uint16_t) 0x00FF);      
      transfer(buff, 3, NULL, 0);
}*/

uint16_t 
readRegister16(uint8_t reg)
{
      uint8_t rcv[2];
      transfer(&reg, 1, rcv, 2);
      //printf("%x %x =>",rcv[0], rcv[1]);
      uint16_t ret=0x0;
      ret=rcv[0]<<8 | rcv[1];
      //printf("%x\n",ret);
      return ret;
}
