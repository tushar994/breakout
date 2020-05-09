VictoryState = Class{__includes = BaseState}

function VictoryState:enter(list)

    self.health = list['health']
    self.bricks = list['bricks']
    self.paddle = list['paddle']
    self.score = list['score']
    self.ball = Ball(math.random(1,7))
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)
    self.level = list['level']

end

function VictoryState:update(dt)

    self.paddle:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:changeState('play',{
            ['health'] = self.health,
            ['score'] = self.score,
            ['bricks'] = self.bricks,
            ['paddle'] = self.paddle,
            ['ball'] = self.ball,
            ['level'] = self.level+1,
        })
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:changeState('start')
    end

end

function VictoryState:render()

    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            brick:render()
        end
    end 
    self.paddle:render() 
    self.ball:render()

    renderScore(self.score)
    renderHealth(self.health)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to go to next level!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')



end