/*
 * lcd_nav_keypad.ino - Example code using the menu system library
 *
 * This example shows using the menu system with a 16x2 LCD display and keypad
 * (controled over serial).
 *
 * Copyright (c) 2015 arduino-menusystem
 * Licensed under the MIT license (see LICENSE)
 */

#include <MenuSystem.h>
#include <LiquidCrystal.h>
#include "RecipeBook.h"

//#define DEBUG
#define NUM_KEYS 5
#define Key_Pin 0 // LCD key pad analog pin
int adc_key_val[5] ={50,250,450,650,850};
int adc_key_in;
int key=-1;
int oldkey=-1;

// Menu variables
MenuSystem ms;
Menu message("How may I serve?");
Menu mix("Mix Drinks");
MenuItem mix_screwdriver("* Screwdriver");
Menu config_menu("Config Setttings");
MenuItem config_mi("NONE YET");

/*
The LCD circuit:
 * LCD RS pin to digital pin 8
 * LCD Enable pin to digital pin 9
 * LCD D4 pin to digital pin 4
 * LCD D5 pin to digital pin 5
 * LCD D6 pin to digital pin 6
 * LCD D7 pin to digital pin 7
 * LCD R/W pin to ground
 */
// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);

// Menu callback function
// In this example all menu items use the same callback.

void on_item1_selected(MenuItem* p_menu_item)
{
  lcd.setCursor(0,2);
  lcd.print("Item1 Selected  ");
  Serial.println("Item1 Selected  ");
  delay(1500); // so we can look the result on the LCD
}

void on_item2_selected(MenuItem* p_menu_item)
{
  lcd.setCursor(0,2);
  lcd.print("Item2 Selected  ");
  Serial.println("Item2 Selected  ");
  delay(1500); // so we can look the result on the LCD
}

void mix_selected(MenuItem* p_menu_item)
{
  lcd.setCursor(0,2);
  lcd.print("mix Selected  ");
  Serial.println("mix Selected  ");
  delay(1500); // so we can look the result on the LCD
}

// Standard arduino functions

void setup()
{
  Serial.begin(9600);
  lcd.begin(20, 4);
  
  serialPrintHelp();
  Serial.println("Setting up the menu.");
  
  /*
  Menu Structure:
   -message: How may I serve?
   -mix: Mix Drinks
   --mix_mi1: * Screwdriver
   -mu2: Config Setttings-
   --mu2_mi2: NONE YET   
   */
   
  message.add_menu(&mix);
  mix.add_item(&mix_screwdriver, &mix_selected);
  message.add_menu(&config_menu);
  config_menu.add_item(&config_mi, &on_item2_selected);
  ms.set_root_menu(&message);
  Serial.println("Menu setted.");
  displayMenu();
}

void loop()
{
  // Handle serial commands
  serialHandler();

  // Wait for two seconds so the output is viewable
//  delay(2000);
}

void displayMenu() {
  lcd.clear();
  lcd.setCursor(0,0);
  // Display the menu
  Menu const* cp_menu = ms.get_current_menu();

  //lcd.print("Current menu name: ");
  lcd.print(cp_menu->get_name());
  
  lcd.setCursor(0,1);
  
  lcd.print(cp_menu->get_selected()->get_name());
}

void serialHandler() {
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  adc_key_in = analogRead(Key_Pin);    // Read the value of the pulsation
  key = get_key(adc_key_in);    // We get the button pressed

  if (key != oldkey)   // if keypress is detected
  {
    delay(50);  // Expected to avoid bouncing pulsations
    adc_key_in = analogRead(Key_Pin);    // Read the value of the pulsation
    key = get_key(adc_key_in);    // We get the button pressed
//    if (key != oldkey) 
  oldkey = key;
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


if (key == 1){
      ms.prev();
      displayMenu();
      #ifdef DEBUG
      Serial.print("key- ");Serial.println(key);
      #endif
}
if (key == 2)   { 
      ms.next();
      displayMenu();
#ifdef DEBUG
      Serial.print("key- ");Serial.println(key);
      #endif
}
if (key == 3){
      ms.back();
      displayMenu();
#ifdef DEBUG
      Serial.print("key- ");Serial.println(key);
      #endif
}
if (key == 4)
      ms.select();
      displayMenu();
#ifdef DEBUG
      Serial.print("key- ");Serial.println(key);
      #endif
}
if (key == 0)
      serialPrintHelp();
#ifdef DEBUG
      Serial.print("key- ");Serial.println(key);
      #endif
}




//}
void serialPrintHelp() {
  Serial.println("***************");
  Serial.println("w: go to previus item (up)");
  Serial.println("s: go to next item (down)");
  Serial.println("a: go back (right)");
  Serial.println("d: select \"selected\" item");
  Serial.println("?: print this help");
  Serial.println("h: print this help");
  Serial.println("***************");

}
// Convert the analog value read in a number of button pressed
int get_key(unsigned int input) {
  int k;
  for (k = 0; k < NUM_KEYS; k++)  {
    if (input < adc_key_val[k])    {
      return k;
    }
  }
  if (k >= NUM_KEYS) k = -1;  // Error in reading.
  return k;
}
