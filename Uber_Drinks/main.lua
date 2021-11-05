-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--Game Development for the discipline SE-Embebed Systems - Ismat 2021
--Teacher : Francisco Melo Pereira
--Student : Helder Oliveira


--Game Title : Uber Drinks! the original game
--Game goals: Avoid drinking too many alcoholic drinks, if drinking water regains sanity, or else go to the hospital :D

--stuff

display.setStatusBar(display.HiddenStatusBar);

local centerX = display.contentCenterX;
local centerY = display.contentCenterY;

-- references
local enemy

-- pre load audio files 

local ambSound = audio.loadSound();
local sndSmash = audio.loadSound();
local sndLose = audio.loadSound();

-- Function play screen
function createPlayScreen()

    local backGround = display.newImage("Images/backGround.png");
    backGround.y = 130
    backGround.alpha = 0

--local character = display.newImage("Images/title.png");
--character.x = centerX;
--character.y = display.contentHeight + 50


--Inner Function Title 
function showTitle()
    local gameTitle = display.newImage("Images/title.png")
    gameTitle.x = centerX
    gameTitle.y = centerY
    gameTitle.alpha = 0
    gameTitle:scale(0.5,0.5)
    transition.to(gameTitle,{time=2000,alpha=1,xScale=0.3,yScale=0.3}) 
    characterEnemy()
end

transition.to(backGround,{time=2000, alpha=1,xScale=0.7,yScale=0.7, y= centerY, x=centerX,onComplete=showTitle()});

end
--transition.to(character,{time=2000,alpha=1 ,xScale=0.4,yScale=0.4,y=centerY});   

--Function Enemy
function characterEnemy()
    enemy = display.newImage("Images/enemy_01.png");
    enemy.x = math.random(20, display.contentWidth-20);
    enemy.y = math.random(20, display.contentHeight-20);
    enemy:scale(0.3,0.3)
    enemy:addEventListener("tap", drinkSmash)
end

--Function Start the Game
local function startGame()
  
end

--Function Smash Drinks
function drinkSmash(event)
    local obj = event.target
    display.remove(obj);
    return true
end



createPlayScreen()
startGame()
