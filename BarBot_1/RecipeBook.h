#ifndef __RECIPEBOOK_H_INCLUDED__   // if recipebook.h hasn't been included yet...
#define __RECIPEBOOK_H_INCLUDED__   //   #define this so the compiler knows it has been included
#include <Arduino.h>



/***
 * A flavor isjust the mapping of flavorname and arduino pin
 */
class Flavor
{
public:
  Flavor(String flavorName, int pin);  //
  String  flavorName;
  int flavorPin;
};



/***
 * A recipe is a list of ingredients and a correcponding list of pour durations
 */
class Recipe
{
public:
  Recipe(Flavor flavors[], float pourTimes[]);
  int getNumFlavors();
  Flavor getFlavor(int index);
  float getPourDuration(int index);
private:
  Flavor* flavors;
  float* pourTimes;
};



/***
 * The recipebook class is where all the recipes are kept together and mapped
 */
class RecipeBook
{
public:
  RecipeBook();
  Recipe getRecipe(int index);
private:
  Recipe* recipes;
};

#endif 
