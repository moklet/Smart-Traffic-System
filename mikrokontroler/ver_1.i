/* File include */
// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega8
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      // 16 bit access
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   // 16 bit access
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   // 16 bit access
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  // 16 bit access
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  // 16 bit access
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  // 16 bit access
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
// CodeVisionAVR C Compiler
// (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
void dataout(unsigned char data_LCD, char kode)
{
  unsigned char i;
  PORTC.2=0;
  for(i=0;i<8;i++)
  {
    PORTC.3 =(data_LCD & 0x1)==0x1 ? 1 : 0;
    delay_us(4);
    PORTC.2=1;
    delay_us(4);
    PORTC.2=0;
    data_LCD=data_LCD>>1;
  }
  PORTC.0=kode;
  delay_us(40);
  PORTC.1=1;
  delay_us(40);
  PORTC.1=0;
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
#asm
#asm
   .equ __i2c_port=0x18 ;PORTB
   .equ __sda_bit=2
   .equ __scl_bit=7
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
unsigned char read_EEPROM(unsigned char alamat)
{
     unsigned char datax;
     i2c_start();
     i2c_write(0xA0 );
     i2c_write(alamat);
     i2c_stop();
     i2c_start();
     i2c_write(0xA0  | 1);
     datax = i2c_read(0);
     i2c_stop();
     return datax;
}
void write_EEPROM(unsigned char alamat, unsigned char nilai)
{
     i2c_start();
     i2c_write(0xA0 );
     i2c_write(alamat);
     i2c_write(nilai);
     i2c_stop();
     delay_ms(10);
}
/* Pendefinisian */    
//pin 11,12,13,5
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
PORTB.7    =0;ms_1=0;detik_1=0;
do
{
pos(3,1);tampil1(PIND.5    );pos(3,3);tampil1(PIND.6    );pos(3,5);tampil1(PIND.7    );pos(3,7);tampil1(PIND.3    ); 
 ms_1++;
if (ms_1>500)
        {ms_1=0;detik_1++;pos(4,1);tampil4(detik_1);
                if (PORTB.7    ==0){PORTB.7    =1;}
                else {PORTB.7    =0;} 
        }    
//delay_ms(1000); 
if (detik_1>=5) 
        {
                data1=0x30+PIND.5    ;data2=0x30+PIND.6    ;data3=0x30+PIND.7    ;data4=0x30+PIND.3    ;
        kirimser(0x2A);delay_ms(100);
        kirimser(data1);delay_ms(100);
        kirimser(data2);delay_ms(100);
        kirimser(data3);delay_ms(100);
        kirimser(data4);delay_ms(100);
        kirimser(0x23);detik_1=0;}
}while(1);                       
}
