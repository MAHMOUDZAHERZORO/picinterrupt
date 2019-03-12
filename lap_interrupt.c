#include "typedef.h"
#include "gpio.h"
#include "lcd.h"
int value;
char txt[7];
void interrupt_init();
void main() {
interrupt_init();
TRISC&=~(1<<7);
PORTC&=~(1<<7);
Lcd_Init();
ADC_Init();
Lcd_Cmd(_LCD_CURSOR_OFF);
Lcd_Out(1,2,"temperature is : ");
while(1){
 value=ADC_Read(0);
 value=((value*500.0)/1023.0);
 IntToStr(value,txt);
Lcd_Out(2,2,txt);
 if(value>=12){
  PORTC|=(1<<7);
 }
}
}
void interrupt_init(){
  INTCON|=(1<<7); //Global Interrupt Enable bit
  INTCON|=(1<<6);//Peripheral Interrupt Enable bit
  INTCON|=(1<<5);//TMR0 Overflow Interrupt Enable bit
  INTCON|=(1<<4);//RB0/INT External Interrupt Enable bit
}
void interrupt(void){
  if((INTCON & (1<<1))==0x02){
  INTCON&=~(1<<1);
  PORTC|=(1<<0);

  }

}

