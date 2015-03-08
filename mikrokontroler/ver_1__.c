/* File include */
#include <mega8.h>
#include <delay.h>    
#include <stdio.h>    
#include "lcdku.c"
#ifndef __lcdku_C
#define __lcdku_C

#define   rs              PORTC.0//PORTC.2
#define   enable          PORTC.1//PORTC.3
#define	  clock           PORTC.2//PORTC.4
#define   tx_LCD          PORTC.3 //PORTC.5


void dataout(unsigned char data_LCD, char kode)
{
  unsigned char i;
  clock=0;
  for(i=0;i<8;i++)
  {
    tx_LCD=(data_LCD & 0x1)==0x1 ? 1 : 0;
    delay_us(4);
    clock=1;
    delay_us(4);
    clock=0;
    data_LCD=data_LCD>>1;
  }
  rs=kode;
  delay_us(40);
  enable=1;
  delay_us(40);
  enable=0;
}

void pos(unsigned char i,unsigned char n)
{
  if(i==1)
  {
    dataout (0x80+n-1,0);
    delay_us(40);
  }
  else if (i==2)
  {
    dataout (0xc0+n-1,0);
    delay_us(40);
  }
  else if (i==3)
  {
    dataout (0x90+n-1,0);
    delay_us(40);
  }
  else if (i==4)
  {
    dataout (0xd0+n-1,0);
    delay_us(40);
  }
  else;
}


void busek()
{
        dataout(0x01,0);
        delay_ms(2);
}


void initlcd()
{
        delay_ms(1000);
        dataout(0x30,0);
        delay_ms(500);
        dataout(0x30,0);
        delay_us(10000);
        dataout(0x30,0);
        delay_us(4000);
        dataout(0x38,0);
        delay_us(4000);
        dataout(0x08,0);
        delay_us(4000);
        dataout(0x01,0);
        delay_us(4000);
        dataout(0x0c,0);
        delay_us(4000);
        dataout(0x06,0);
        delay_us(4000);
}


void cetak(int i,int n,flash char *text)
{
        pos(i,n);
        while(*text)
        {
                dataout(*text++,1);
                delay_us(40);
        }
}     

#endif
#include "i2c.c"


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



/* Pendefinisian */    

//pin 11,12,13,5

#define ldr1       PIND.5    //PORTC.3  
#define ldr2       PIND.6    //PORTC.3  
#define ldr3       PIND.7    //PORTC.3  
#define ldr4       PIND.3    //PORTC.3  
#define led       PORTB.7    //PORTC.3  

/* Inisialisasi variabel global */   
unsigned int data_serial;
bit tanda_rx;

unsigned char kon(unsigned char n)
  {
   if (n <10) return(n+0x30);
   else return(n+0x37);

  }
/*Inisialisasi input output */
void init_port()
{
        DDRD =0b00000011; 
        PORTD=0b11111101;
        DDRC =0b11001111;
        PORTC=0b11111111;
        DDRB =0b11111111;
        PORTB=0b10111101;
} 
void initser()
{
     UBRRL=51;//25;
     UBRRH=0;                     
     UCSRA=0x80;//aslinya 0
     UCSRB=0x98; //Txd,Rxd Enabled aslinya 18
     UCSRC=0x86; //8 bit data  
}

void kirimser(char TxData)
{
     UDR = TxData;   
//     time_us(100);  
} 

void kirimtext(flash char *text)
{
        
        while(*text)
        {
                kirimser(*text++);
        }
}     

void inttim(char in)
{
if(in==0)TIMSK=TIMSK & 0xFE;
else TIMSK=TIMSK|0x1;
}             

void init_timer0()
{       
        /* Timer ini akan digunakan sebagai penghitung kecepatan */
        /* Mode yang digunakan adalah normal */
        TCCR0=0x02;//3;
        TCNT0=-25;
        inttim(1);
} 

void init_ext_interrupt()
{
        /* Set untuk interupt 0 rising edge */
        MCUCR=0x01;//3;//2;
        GICR=GICR|0x40; //0x40;
}

/* Turn registers saving off */
#pragma savereg-
/* interrupt handler */

void tampilhex(long int biner)
{
         long int ascii;
//         ascii=biner; ascii=kon((ascii/0x100000)%0x10); dataout(ascii,1);
//         ascii=biner; ascii=kon((ascii/0x10000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x1000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x100)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
}#pragma savereg+  
#pragma savereg-
/* interrupt handler */
interrupt [12] void interuptrx(void) 
{               
//     while((UCSRA & 0x80) == 0x00);
 //if(UDR=='a')tanda_rx=1;   
 data_serial=(data_serial<<8)+UDR;
 tanda_rx=1;     
 pos(2,11);tampilhex(data_serial);
//pos(2,1);tampilhex(data_serial);
//data_serial=UDR;    
} 
#pragma savereg+

void tampil1(long int biner)
{
         long int ascii;

//         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}
void tampil2(long int biner)
{
         long int ascii;

//         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}
void tampil4(long int biner)
{
         long int ascii;

//         ascii=biner; ascii=(ascii/1000000000)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/1000000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/100000%10)|0x30; dataout(ascii,1);
//         ascii=biner; ascii=(ascii/10000%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii/1000%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}

void tampilhex8(long int biner)
{
         long int ascii;
 //        ascii=biner; ascii=kon((ascii/0x1000000000)%0x10); dataout(ascii,1);
 //        ascii=biner; ascii=kon((ascii/0x100000000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x10000000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x1000000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x100000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x10000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x1000)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x100)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
}
void tampilhex2(long int biner)
{
         long int ascii;
          ascii=biner; ascii=kon((ascii/0x10)%0x10); dataout(ascii,1);
         ascii=biner; ascii=kon(ascii%0x10); dataout(ascii,1);
}


interrupt [10] void timer0_overflow(void) 
{   
        #asm
        push r30
        push r31
        in   r30,SREG
        push r30
        #endasm  
        
         #asm
        pop r30
        out SREG,r30
        pop r31
        pop r30
        #endasm*
       
}      
interrupt [2] void external_int0(void) 
{
        #asm
        push r30
        push r31
        in   r30,SREG
        push r30
        #endasm        
          #asm
        pop r30
        out SREG,r30
        pop r31
        pop r30
        #endasm
}

/* Program Utama */
void main()
{
unsigned char data1,data2,data3,data4;   
unsigned int ms_1,detik_1;


         /* Inisialisasi */
        init_port();//inisialisasi port 
        initser();
        initlcd(); 

        kirimser(0x2A);delay_ms(100);
        kirimser(data1);delay_ms(100);
        kirimser(data2);delay_ms(100);
        kirimser(data3);delay_ms(100);
        kirimser(data4);delay_ms(100);
        kirimser(0x23);
        
cetak(1,1,"0123456789ABCDEF"); 
cetak(2,1,"abcdefghijklmnop");
cetak(3,1,"qrstuvwxyz012345");
cetak(4,1,"!@#$%^&*()_+=-{}?");
delay_ms(1000);

        kirimser(0x2A);delay_ms(100);
        kirimser(data1);delay_ms(100);
        kirimser(data2);delay_ms(100);
        kirimser(data3);delay_ms(100);
        kirimser(data4);delay_ms(100);
        kirimser(0x23);

busek();
cetak(1,1,"H A C K  A T O N");          
cetak(2,1,"   INDONESIA    ");          
//cetak(3,1,"    I D L E     ");          
//cetak(4,1," W E L C O M E  ");          


led=0;ms_1=0;detik_1=0;
do
{
pos(3,1);tampil1(ldr1);pos(3,3);tampil1(ldr2);pos(3,5);tampil1(ldr3);pos(3,7);tampil1(ldr4); 
 ms_1++;

if (ms_1>500)
        {ms_1=0;detik_1++;pos(4,1);tampil4(detik_1);
                if (led==0){led=1;}
                else {led=0;} 
        }    

//delay_ms(1000); 



if (detik_1>=5) 
        {
        
        data1=0x30+ldr1;data2=0x30+ldr2;data3=0x30+ldr3;data4=0x30+ldr4;
        kirimser(0x2A);delay_ms(100);
        kirimser(data1);delay_ms(100);
        kirimser(data2);delay_ms(100);
        kirimser(data3);delay_ms(100);
        kirimser(data4);delay_ms(100);
        kirimser(0x23);detik_1=0;}
}while(1);                       
}
