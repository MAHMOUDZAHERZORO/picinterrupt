#line 1 "E:/lap_interrupt/lap_interrupt.c"
#line 1 "e:/lap_interrupt/typedef.h"


 typedef unsigned char unit_8t;
 typedef unsigned int unit_16t;
#line 1 "e:/lap_interrupt/gpio.h"
#line 1 "e:/lap_interrupt/lcd.h"


sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD7_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D4 at RD4_bit;


sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD4_bit;
#line 4 "E:/lap_interrupt/lap_interrupt.c"
int value,m;
char txt[7];
void main() {
void interrupt_init();
TRISC&=~(1<<0);
PORTC&=~(1<<0);
Lcd_Init();
ADC_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,2,"temperature is : ");
while(1){
 value=ADC_Read(0);
 value=((value*500)/1023);
 IntToStr(value,txt);
Lcd_Out(2,2,txt);
}
}
void interrupt_init(){
 INTCON|=(1<<7);
 INTCON|=(1<<6);
 INTCON|=(1<<5);
 INTCON|=(1<<4);
}
void interrupt(void){
 if((INTCON & (1<<1))==0x02){
 PORTC|=(1<<0);
 delay_ms(1000);
 INTCON&=~(1<<1);
 }

}
