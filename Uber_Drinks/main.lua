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
local centerX = display.contentCenterX
local centerY = display.contentCenterY

-- references
local characterEnemy
local gameTitle
local scoreText
local score=0
local hitCharacter
local character
local lifeTxt
local life



-- pre load audio files 

local sndBlast = audio.loadSound("audio/Small_Burp_1.mp3")
local sndSmash = audio.loadSound("audio/Big_1.mp3") --audio from https://www.fesliyanstudios.com/
local sndLose = audio.loadSound()

local ambtSound = audio.loadStream("mix.wav",'audio')

-- function play screen
function createPlayScreen()
    
    local backGround = display.newImage("Images/backGround.png")
    --backGround.y = 130
    backGround.alpha = 0
    transition.to(backGround,{time=2000, alpha=1,xScale=0.9,yScale=0.9, y= centerY, x=centerX,});
    character= display.newImage("Images/1.png")
    character.x = centerX;
    character.y = display.contentHeight + 50
    character.alpha = 0

      
    local function showTitle()
        gameTitle = display.newImage("Images/title.png")
        gameTitle.x = centerX
        gameTitle.y = centerY
        gameTitle.alpha = 0
        gameTitle:scale(0.5,0.5)
        transition.to(gameTitle,{time=2000,alpha=1,xScale=0.3,yScale=0.3, }) 
        startGame()                
end
showTitle()
end
   

--Function Enemy

function characterEnemy()    
	if life > 0 then
        local enemy = display.newImage("Images/enemy_01.png");
        enemy:scale(0.3,0.3)
        enemy:addEventListener('tap', drinkSmash)
        if math.random(2)==1 then
            enemy.y = math.random(-100, -10)
        else
            enemy.x = math.random(display.contentWidth+10, display.contentWidth +100)
        end
        enemy.y = math.random(display.contentHeight)
        enemy.trans = transition.to(enemy,{ x= centerX, y= centerY, time=3500, onComplete=hitCharacter});
	end
        --Tem de levar as garrafas de água para dar vida

end



function removeLife(num)
    life = life - num
    lifeObj.text = life
end

function resetLife()
    life = 5
end


--Function Start the Game
function startGame()
    resetLife()
    local text = display.newText("Tap to start the game, avoid the drink bottles!",0,0,"Helvetica",20)
            text.x = centerX
            text.y = display.contentHeight-30
            text:setTextColor(154,214,245)
            local function goAway(event)
                display.remove(event.target)    
                text= nil
                display.remove(gameTitle)
                transition.to(character,{time=1000, alpha=1,xScale=0.2,yScale=0.2, y= centerY,onComplete=showTitle})                                   
                characterEnemy()
                --Score counter
                scoreText = display.newText('Score:',0,0,"Helvetica",20);
                scoreText.x = centerX
                scoreText.y = display.contentHeight-30
                score=0
                --Life counter                
                lifeTxt =  display.newText('Life:  ',0,0,"Helvetica",20);  
                lifeTxt.x = display.contentWidth-50
                lifeTxt.y = display.contentHeight-300               
                
                lifeObj = display.newText(tostring(life), 0,0,"Helvetica",20);
                lifeObj.x = lifeTxt.x + (lifeTxt.width/2)
                lifeObj.y = lifeTxt.y                                    
    end
    text:addEventListener('tap',goAway)     
end

--Function damage the character
function characterDamage()
    local function goAway(obj)
        character.xScale = 0.2
        character.yScale = 0.2
        chrtrLife()
    end
    transition.to(character,{ time=200, xScale= 0.5, yScale= 0.5,alpha=1, onComplete=goAway})     
end


--Function hit Character
function hitCharacter(obj)
    display.remove(obj)
    characterDamage()
    --audio.play(sndBlast)
    removeLife(1)
    characterEnemy()
end

--Function Smash Drinks
function drinkSmash(event)
    local obj = event.target
    display.remove(obj)
    --audio.play(sndSmash)
    transition.cancel(event.target.trans)
    score = score + 10
    scoreText.text = 'Score: '..score  
    characterEnemy()  
    return true
end

--function visible
function chrtrLife()	
	if life == 0 then
		stopGame()
	end
end

--function stop Game
function stopGame()	
	--audio.play(soundLose)
	local background = display.newImage("Images/gameOver.jpg")
	background.y = 0	
	transition.to(background, {time=1000, y=centerY,x=centerX , xScale=0.3,yScale=0.3})
	local text = display.newText( "Tap here to restart !!", 0, 0, "Helvetica", 24 )
    text.x = centerX
    text.y = display.contentHeight-30       
	text:addEventListener ( "tap", createPlayScreen)       
end

createPlayScreen()
