local inspect = require("inspect")

-- Scaling factor for all recipes, time required, and ingredients
factor = 50

-- Big Furnace prototype definition
require("prototypes.bigfurnace")

-- Big Assembly prototype definition
require("prototypes.bigassembly")

-- Creates 50x versions of each recipe from selected categories
require("scripts.recipeSetup")

-- Create the item groups for these new recipes
require("scripts.itemGroupSetup")

-- Adds 50x recipes versions to each technology
require("scripts.techSetup")