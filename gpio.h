#ifndef _gpio_h
#define _gpio_h
#define input 1
#define output 0
#define reg_trisa *((volatile unit_8t *) (0x85))
#define reg_trisb *((volatile unit_8t *) (0x86))
#define reg_trisc *((volatile unit_8t *) (0x87))
#define reg_trisd *((volatile unit_8t *) (0x88))

#define reg_trise *((volatile unit_8t *) (0x89))


#define reg_porta *((volatile unit_8t *) (0x05))
#define reg_portb *((volatile unit_8t *) (0x06))
#define reg_portc *((volatile unit_8t *) (0x07))
#define reg_portd *((volatile unit_8t *) (0x08))
#define reg_porteS *((volatile unit_8t *) (0x09))
#endif