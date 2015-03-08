

#asm
   .equ __i2c_port=0x18 ;PORTB
   .equ __sda_bit=2
   .equ __scl_bit=7
#endasm

#include <i2c.h>
//#include <stdio.h>


#define EEPROM_ADDR    0xA0 


unsigned char read_EEPROM(unsigned char alamat)
{
     unsigned char datax;
     i2c_start();
     i2c_write(EEPROM_ADDR);
     i2c_write(alamat);
     i2c_stop();
     i2c_start();
     i2c_write(EEPROM_ADDR | 1);
     datax = i2c_read(0);
     i2c_stop();
     return datax;
}

void write_EEPROM(unsigned char alamat, unsigned char nilai)
{
     i2c_start();
     i2c_write(EEPROM_ADDR);
     i2c_write(alamat);
     i2c_write(nilai);
     i2c_stop();
     delay_ms(10);
}

