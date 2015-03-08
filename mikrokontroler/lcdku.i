void dataout(unsigned char data_LCD, char kode)
{
  unsigned char i;
  PORTB.2=0;
  for(i=0;i<8;i++)
  {
    PORTB.3=(data_LCD & 0x1)==0x1 ? 1 : 0;
    delay_us(4);
    PORTB.2=1;
    delay_us(4);
    PORTB.2=0;
    data_LCD=data_LCD>>1;
  }
  PORTB.0=kode;
  delay_us(40);
  PORTB.1=1;
  delay_us(40);
  PORTB.1=0;
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
  else;
}
void busek()
{
        dataout(0x01,0);
        delay_ms(2);
}
void initlcd()
{
        delay_ms(2000);
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
