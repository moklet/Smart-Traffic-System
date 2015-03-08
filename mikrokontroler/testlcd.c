/* File include */
#include <mega8535.h>
#include <delay.h>    
#include "lcdku.c"
//#include "i2c.c"


/* Pendefinisian */




/* Inisialisasi variabel global */
unsigned char b;
long int ;
unsigned int i,suhu;
bit t;
//flash int konstanta_timing[25]={1,666,333,111,167,133,112,96,84,74,66,60,56,52,48,44,42,40,38,36,34,32,30,28,28};

/*Inisialisasi input output */
void init_port()
{
        DDRC=0b00000011;
        DDRB=0b00001111;
        DDRD=0b11000010; 
        DDRA=0b00000000;
        //scld=1;sdad=1;  
} 

void init_ADC()
{
        /* Referensi AVcc*/
        SFIOR=SFIOR&0x0f;
        ADMUX=0x40;
        ADCSRA=0x02;
}
void initser()
{
     UBRRL=25;
     UBRRH=0;                     
     UCSRA=0x80;//aslinya 0
     UCSRB=0x98; //Txd,Rxd Enabled aslinya 18
     UCSRC=0x86; //8 bit data  
}

unsigned char terimaser()
{
     while((UCSRA & 0x80) == 0x00);
     return UDR;
}        

void kirimser(char TxData)
{
     while((UCSRA & 0x20) == 0x00);
     //while ( !( UCSRA & (1<<UDRE)) );
     UDR = TxData;   
     delay_ms(10);                   
} 
void kirimtext(flash char *text)
{
        
        while(*text)
        {
                kirimser(*text++);
        }
}     
unsigned int konversi(unsigned char channel)
{ 
        unsigned char high,low;
        int data_konversi;
        
        /* pilih channel dengan referensi AVcc */
        ADMUX=(ADMUX&0xe0)|channel;      
        
         /* Nyalakan ADC dan Start Konversi */
        ADCSRA=ADCSRA|0b11000000;       
        
        /* tunggu proses konversi selesai */
        while((ADCSRA&0b00010000)!=0x10);    
        
        /* matikan ADC, reset ADIF */
        ADCSRA=(ADCSRA|0b00010000)&0b01111111;    
        
        /* data hasil konversi */
        delay_ms(1);
        low=ADCL;
        high=ADCH&0x03;
        data_konversi=(high%2)*256;
        high/=2;
        data_konversi=(data_konversi+((high%2)*512))+low;    
        return data_konversi;
}        
/*inisialisasi timer 1*/
void init_timer1()
{
        /* Timer ini akan digunakan triger CDI */
        /* frekuensi clock 2 MHz */
        TCCR1A=0x00;
        TCCR1B=0x08;
        //TIMSK=TIMSK|0x10;
        OCR1AH=0xff;
        OCR1AL=0xff;
        TCNT1H=0;
        TCNT1L=0;
}


void init_timer2()
{       
        /* Timer ini akan digunakan sebagai penghitung kecepatan */
        /* Mode yang digunakan adalah normal */
        TCCR2=0x07;
        TIMSK=TIMSK|0x40;     
        TIFR=TIFR|0x40;
        TCNT2=-39;
        //TCNT2H=0xf0;
        //TCNT2L=0xbe;
        //TCNT1L=0;
}

void init_ext_interrupt()
{
        /* Set untuk interupt 0 rising edge */
        MCUCR=0x03;
        GICR=GICR|0x40;
}




void kon(long int n)
{
	int ascii;
	 ascii=n/1000+0x30;
	 if(ascii==0x30) dataout(' ',1);
	 else dataout(ascii,1);
         ascii=n/100%10+48; dataout(ascii,1);
         ascii=n/10%10+48; dataout(ascii,1); 
         dataout(',',1);
         ascii=n%10+48; dataout(ascii,1);
}


void tampil_angka_bulat_5digit(long int biner)
{
         long int ascii;

         ascii=biner; ascii=(ascii/10000)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii/1000)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}

void tampil(unsigned int biner)
{
         long int ascii;

       //  ascii=biner; ascii=(ascii/10000)|0x30; dataout(ascii,1);
        // ascii=biner; ascii=(ascii/1000)|0x30; dataout(ascii,1);
         //ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}
void tampilsuhu(unsigned int biner)
{
         long int ascii;

       //  ascii=biner; ascii=(ascii/10000)|0x30; dataout(ascii,1);
         ascii=biner; ascii=(ascii/1000)|0x30; dataout(ascii,1);
         ascii=biner; ascii=((ascii/100)%10)|0x30; dataout(ascii,1); 
         dataout(',',1); 
         ascii=biner; ascii=((ascii/10)%10)|0x30; dataout(ascii,1);
         //ascii=biner; ascii=(ascii%10)|0x30; dataout(ascii,1);
}

/* Turn registers saving off */
#pragma savereg-
/* interrupt handler */
interrupt [5] void timer2_overflow(void) 
{   
        #asm
        push r30
        push r31
        in   r30,SREG
        push r30
        #endasm
      //  pengali++;
      //b=0;    
      TCNT2=-39;
      TIFR=TIFR|0x40;
     
        #asm
        pop r30
        out SREG,r30
        pop r31
        pop r30
        #endasm*
}
/* re-enable register saving for the other interrupts */
#pragma savereg+


/* Turn registers saving off */
#pragma savereg-
/* interrupt handler */
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
#pragma savereg+  
#pragma savereg-
/* interrupt handler */
interrupt [12] void interuptrx(void) 
{       
         
     while((UCSRA & 0x80) == 0x00);
     //if(UDR=='a')trx=1;   
      
} 
#pragma savereg+
unsigned int loopkonv(unsigned char ch,unsigned char n)
{
        unsigned int a1;
        unsigned long int a; 
        a=0;
        for(i=0;i<n;i++)
        {
        a1=konversi(ch); 
        a=a+a1;
        } 
        a=a/n;
        return(a);      
        
}                                       
unsigned int loopsuhu(unsigned char ch)
{
        unsigned int a1;
        unsigned long int a; 
        a=0;
        for(i=0;i<100;i++)
        {
        a1=konversi(ch); 
        a=a+a1;
        } 
        a=a/2;
        return(a);      
        
}                 

/* Program Utama */
void main()
{  
               
        /* Inisialisasi */
        init_port();
        //init_timer1();
        //init_timer2();
        //init_ext_interrupt();
        initlcd();
        init_ADC(); 
        //initser();
        
        #asm("sei")
        delay_ms(50);
        cetak(1,1,"Kelelahan");

        {   

        }while(1);                       
}
