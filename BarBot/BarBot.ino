
#include <LiquidCrystal.h>

// these constants won't change.  But you can change the size of
// your LCD using them:
const int numRows = 2;
const int numCols = 16;

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

int adc_key_in  = 0;
#define btnRIGHT  0
#define btnUP     1
#define btnDOWN   2
#define btnLEFT   3
#define btnSELECT 4
#define btnNONE   5

int buttonState;             // the current reading from the input pin
int lastButtonState = LOW;   // the previous reading from the input pin
long lastDebounceTime = 0;  // the last time the output pin was toggled
long debounceDelay = 50;    // the debounce time; increase if the output flickers


/********************************
 * Setup executes once at start
 ********************************/
void setup() {
  Serial.begin(9600);      // open the serial port at 9600 bps:    
  // set up the LCD's number of columns and rows:
  lcd.begin(numCols, numRows); // start the library
  lcd.setCursor(0,0);
  lcd.print("Push the buttons"); // print a simple message
}// setup


/*************************************
 * loop is the 'main' program entry
 *************************************/
void loop() {
  
  lcd.setCursor(9,1);            // move cursor to second line "1" and 9 spaces over
  lcd.print(millis()/1000);      // display seconds elapsed since power-up
  lcd.setCursor(0,1);            // move to the begining of the second line
  int lcd_key = read_LCD_buttons();  // read the buttons
  if (lcd_key != lastButtonState) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  }

  if ((millis() - lastDebounceTime) > debounceDelay) {
    if (lcd_key != buttonState) {
      buttonState = lcd_key;
      switch (buttonState) {               // depending on which button was pushed, we perform an action
        case btnRIGHT:
         {
         lcd.print("RIGHT ");
         Serial.print("R\n");       // prints a label
         break;
         }
        case btnLEFT:
         {
         lcd.print("LEFT   ");
         Serial.print("L\n");       // prints a label
         break;
         }
        case btnUP:
         {
         lcd.print("UP    ");
         Serial.print("U\n");       // prints a label
         break;
         }
        case btnDOWN:
         {
         lcd.print("DOWN  ");
         Serial.print("D\n");       // prints a label
         break;
         }
        case btnSELECT:
         {
         lcd.print("SELECT");
         Serial.print("S\n");       // prints a label
         break;
         }
        case btnNONE:
         {
         lcd.print("NONE  ");
         break;
         }
      }//case
    }
  }

  

  
  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  lastButtonState = lcd_key;
}// loop


/***********************************************************
 * read_LCD_buttons returns an int based on the value read
 ***********************************************************/
int read_LCD_buttons()
{
 adc_key_in = analogRead(0);      // read the value from the sensor 
 // my buttons when read are centered at these valies: 0, 144, 329, 504, 741
 // we add approx 50 to those values and check to see if we are close
 if (adc_key_in > 1000) return btnNONE; // We make this the 1st option for speed reasons since it will be the most likely result
 // For V1.1 us this threshold
 if (adc_key_in < 50)   return btnRIGHT;  
 if (adc_key_in < 250)  return btnUP; 
 if (adc_key_in < 450)  return btnDOWN; 
 if (adc_key_in < 650)  return btnLEFT; 
 if (adc_key_in < 850)  return btnSELECT;  

 // For V1.0 comment the other threshold and use the one below:
/*
 if (adc_key_in < 50)   return btnRIGHT;  
 if (adc_key_in < 195)  return btnUP; 
 if (adc_key_in < 380)  return btnDOWN; 
 if (adc_key_in < 555)  return btnLEFT; 
 if (adc_key_in < 790)  return btnSELECT;   
*/

 return btnNONE;  // when all others fail, return this...
}// read_LCD_buttons
