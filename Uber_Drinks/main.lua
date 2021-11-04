-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Game Development for the discipline SE, Embebed Systems - Ismat 2021
--Student : Helder Oliveira
--Teacher : Francisco Melo Pereira

--Game Title : Uber Drinks, the originals!
--Game goals: Avoid drinking too many alcoholic drinks, if drinking water regains sanity, or else go to the hospital :D

--stuff

display.setStatusBar(display.HiddenStatusBar);

local centerX = display.contentCenterX;
local centerY = display.contentCenterY;

-- references

-- pre load audio files 

-- create plan screen
local backGround = display.newImage("backGround.png");
backGround.x = centerX;
backGround.y = centerY;



--