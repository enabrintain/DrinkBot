#include <Arduino.h>
#include "Recipes.h"



/********************************************************************************
 * FLAVOR 
 ********************************************************************************/
Flavor::Flavor(String name, int pin)//(String name, int pin)
{
  this->flavorName = name;
  this->flavorPin = pin;
}// Flavor constructor



/********************************************************************************
 * RECIPE 
 ********************************************************************************/
Recipe::Recipe(Flavor flavors[], float pourTimes[])
{
  this->flavors = flavors;
  this->pourTimes = pourTimes;
}// Recipe constructor

Flavor Recipe::getFlavor(int index)
{
  return flavors[index];
}// getFlavor

float Recipe::getPourDuration(int index)
{
  return pourTimes[index];
}// getPourDuration



/********************************************************************************
 * RECIPEBOOX
 ********************************************************************************/
RecipeBook::RecipeBook()
{
  
}// RecipeBook constructor
 
Recipe RecipeBook::getRecipe(int index)
{
  return recipes[index];
}// getRecipe


