StartState = Class{__includes = BaseState}

function StartState:init()
    -- if its one then highlight play, or highlight highscore
    self.highlight = 1

    

end

function StartState:update(dt)
    


    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        gSounds['paddle-hit']:stop()
        self.highlight = (self.highlight+1)%2
        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        if self.highlight == 1 then
            gSounds['confirm']:stop()
            gStateMachine:changeState('select')
            gSounds['confirm']:play()
        end
    end
end

function StartState:render()

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    
    -- instructions
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if self.highlight == 1 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)

    -- render option 2 blue if we're highlighting that one
    if self.highlight == 0 then
        love.graphics.setColor(103, 255, 255, 255)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)

    



end