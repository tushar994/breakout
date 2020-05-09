SelectState = Class{__includes = BaseState}

function SelectState:init()
    self.whichone  = 0

    self.ball = Ball(math.random(1,7))

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
end

function SelectState:update(dt)

    if love.keyboard.wasPressed('right') then
        self.whichone = (self.whichone+1)%16
    elseif love.keyboard.wasPressed('left') then
        self.whichone = (self.whichone-1)%16
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:changeState('start')
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:changeState('serve',{
            ['paddle'] = Paddle(self.whichone+1),
            ['health'] = MAX_HEALTH,
            ['score'] = 0,
            ['bricks'] = LevelMaker.CreateMap(),
            ['ball'] = self.ball,
            ['level'] = 1
        })
    end
end

function SelectState:render()

    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][1], 10, VIRTUAL_HEIGHT/2 - gTextures['arrows']:getHeight()/2 )


    love.graphics.draw(gTextures['arrows'], gFrames['arrows'][2], VIRTUAL_WIDTH -10 - (gTextures['arrows']:getWidth()/2) , VIRTUAL_HEIGHT/2 - gTextures['arrows']:getHeight()/2 )

end