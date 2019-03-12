
_main:

;lap_interrupt.c,6 :: 		void main() {
;lap_interrupt.c,8 :: 		TRISC&=~(1<<0);
	BCF        TRISC+0, 0
;lap_interrupt.c,9 :: 		PORTC&=~(1<<0);
	BCF        PORTC+0, 0
;lap_interrupt.c,10 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;lap_interrupt.c,11 :: 		ADC_Init();
	CALL       _ADC_Init+0
;lap_interrupt.c,12 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;lap_interrupt.c,13 :: 		Lcd_Out(1,2,"temperature is : ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_lap_interrupt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lap_interrupt.c,14 :: 		while(1){
L_main0:
;lap_interrupt.c,15 :: 		value=ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;lap_interrupt.c,16 :: 		value=((value*500)/1023);
	MOVLW      244
	MOVWF      R4+0
	MOVLW      1
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _value+0
	MOVF       R0+1, 0
	MOVWF      _value+1
;lap_interrupt.c,17 :: 		IntToStr(value,txt);
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;lap_interrupt.c,18 :: 		Lcd_Out(2,2,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;lap_interrupt.c,19 :: 		}
	GOTO       L_main0
;lap_interrupt.c,20 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt_init:

;lap_interrupt.c,21 :: 		void interrupt_init(){
;lap_interrupt.c,22 :: 		INTCON|=(1<<7); //Global Interrupt Enable bit
	BSF        INTCON+0, 7
;lap_interrupt.c,23 :: 		INTCON|=(1<<6);//Peripheral Interrupt Enable bit
	BSF        INTCON+0, 6
;lap_interrupt.c,24 :: 		INTCON|=(1<<5);//TMR0 Overflow Interrupt Enable bit
	BSF        INTCON+0, 5
;lap_interrupt.c,25 :: 		INTCON|=(1<<4);//RB0/INT External Interrupt Enable bit
	BSF        INTCON+0, 4
;lap_interrupt.c,26 :: 		}
L_end_interrupt_init:
	RETURN
; end of _interrupt_init

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;lap_interrupt.c,27 :: 		void interrupt(void){
;lap_interrupt.c,28 :: 		if((INTCON & (1<<1))==0x02){
	MOVLW      2
	ANDWF      INTCON+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt2
;lap_interrupt.c,29 :: 		PORTC|=(1<<0);
	BSF        PORTC+0, 0
;lap_interrupt.c,30 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt3:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt3
	DECFSZ     R12+0, 1
	GOTO       L_interrupt3
	DECFSZ     R11+0, 1
	GOTO       L_interrupt3
	NOP
	NOP
;lap_interrupt.c,31 :: 		INTCON&=~(1<<1);
	BCF        INTCON+0, 1
;lap_interrupt.c,32 :: 		}
L_interrupt2:
;lap_interrupt.c,34 :: 		}
L_end_interrupt:
L__interrupt7:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
