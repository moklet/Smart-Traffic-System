#asm
   .equ __i2c_port=0x15 ;PORTB
   .equ __sda_bit=1
   .equ __scl_bit=0
#endasm
/*
  CodeVisionAVR C Compiler
  (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.

  Prototypes for I2C bus master functions

  BEFORE #include -ING THIS FILE YOU
  MUST DECLARE THE I/O ADDRESS OF THE
  DATA REGISTER OF THE PORT AT WHICH
  THE I2C BUS IS CONNECTED AND
  THE DATA BITS USED FOR SDA & SCL

  EXAMPLE FOR PORTB:

    #asm
        .equ __i2c_port=0x18
        .equ __sda_bit=3
        .equ __scl_bit=4
    #endasm
    #include <i2c.h>
*/
#pragma used+
void i2c_init(void);
unsigned char i2c_start(void);
void i2c_stop(void);
unsigned char i2c_read(unsigned char ack);
unsigned char i2c_write(unsigned char data);
#pragma used-
//#include <stdio.h>
unsigned char read_adc(unsigned char channel)
{
     unsigned char datax;   
     i2c_start();
     i2c_write(0x90);
     //i2c_write((channel+0x10));
	 i2c_write((channel+0x0));
     i2c_stop();
     i2c_start();
     i2c_write(0x90 | 1);
     datax = i2c_read(0);
     i2c_stop();
     return datax;
}
void write_dac(unsigned char tmp1, unsigned char tmp2)
{
     i2c_start();
     i2c_write(0x90);
     i2c_write(tmp1+0x10);
     i2c_write(tmp2);
     i2c_stop();
}
unsigned char bcd2dec(unsigned char input)
{
     unsigned char tmp_data, tmp1;
     tmp_data = input;
     tmp1 = tmp_data % 16;
     if (tmp_data > 15) tmp_data = tmp_data / 16;
     else tmp_data = 0;
     tmp_data = (tmp_data * 10)+tmp1;
     return tmp_data;
}
unsigned char dec2bcd(unsigned char input)
{
     unsigned char tmp_data;
     if (input > 9) tmp_data = ((input / 10)*16) + (input % 10);
     else
        tmp_data = input;
     return tmp_data;
}
unsigned char read_rtc(unsigned char alamat)
{
     unsigned char tmp_data;
     i2c_start();
     i2c_write(0xD0 );
     i2c_write(alamat);
     i2c_stop();
     i2c_start();
     i2c_write(0xD0  | 1);
     tmp_data = i2c_read(0);
     i2c_stop();
     return bcd2dec(tmp_data);
}
void write_rtc(unsigned char alamat, unsigned char datax)
{
	 i2c_start();
     i2c_write(0xD0 );
     i2c_write(alamat);
     if (alamat < 7)
        i2c_write(dec2bcd(datax));
     else
        i2c_write(datax);
     i2c_stop();
}
unsigned char bacamem(unsigned int alamat)
{    unsigned char aa;
     unsigned char datax;
     aa=alamat>>8;aa=aa<<1;
     i2c_start();
     i2c_write(0xA0  |aa);
     i2c_write(alamat);
     i2c_stop();
     i2c_start();
     i2c_write(0xA0  | (aa|1));
     datax = i2c_read(0);
     i2c_stop();
     return datax;
}
void tulismem(unsigned int alamat, unsigned char nilai)
{    unsigned char aa;
     aa=alamat>>8;aa=aa<<1;
     i2c_start();
     i2c_write(0xA0 |aa);
     i2c_write(alamat);
     i2c_write(nilai);
     i2c_stop();
     delay_ms(10);
}
/*
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

unsigned char read_EEPROM2(unsigned char chip_addr,unsigned int address)
{
     unsigned char datax					;
     unsigned char addresshi				;
     unsigned char addresslo				;
     unsigned char chip						;
	 addresshi	= address >> 8				;
	 addresslo	= address					;
	 chip		= chip_addr << 1			;
     i2c_start()							;
     i2c_write(EEPROM_ADDR | chip )			;
     i2c_write(addresshi)					;
     i2c_write(addresslo)					;
	 i2c_stop()								;
     i2c_start()							;
     i2c_write(EEPROM_ADDR | (chip | 1 ))	;
     datax = i2c_read(0)					;
     i2c_stop()								;
     return datax							;
}

void write_EEPROM2(unsigned char chip_addr,unsigned int address, unsigned char nilai)
{
     unsigned char addresshi				;
     unsigned char addresslo				;
     unsigned char chip						;
	 addresshi	= address >> 8				;
	 addresslo	= address					;
	 chip		= chip_addr << 1			;
	 i2c_start()							;
     i2c_write(EEPROM_ADDR | chip_addr )	;
     i2c_write(addresshi)					;
     i2c_write(addresslo)					;
     i2c_write(nilai)						;
     i2c_stop()								;
     delay_ms(10)							;
}
*/
