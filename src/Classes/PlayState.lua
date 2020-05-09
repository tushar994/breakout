PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.level = 1

    self.paddle = Paddle()

    self.ball = Ball(math.random(1,7))

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    self.bricks = LevelMaker.CreateMap()
    self.health = MAX_HEALTH
    self.score =0
end



-- health, paddle, ball?, the environment, score
function PlayState:enter(list)
    if list then
        self.health = list['health']
        self.bricks = list['bricks']
        self.paddle = list['paddle']
        self.score = list['score']
        self.ball = list['ball']
        self.level = list['level']
    end

end



function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    for k,brick in pairs(self.bricks) do 
        if brick.inPlay and self.ball:collides(brick) then
            
            self.score = self.score + (10* brick.tier)
            brick:hit()
            

            -- so what we do here is, if the ball hits a brick, we find the necessarly shift for the ball.y and ball.x, choose the 
            -- minimum and acordingly cahnge the velocity of the ball

            local shift_y
            local shift_x

            if (self.ball.y + self.ball.height/2) < (brick.y + brick.height/2) then
                shift_y = brick.y - (self.ball.y + self.ball.height)
            else 
                shift_y = (brick.y+brick.height) - self.ball.y
            end

            if (self.ball.x + self.ball.width/2) < (brick.x+ brick.width/2) then
                shift_x = brick.x - (self.ball.x + self.ball.width)
            else
                shift_x = (brick.x + brick.width) - self.ball.x
            end

            if math.abs(shift_x) < math.abs(shift_y) then
                self.ball.x = self.ball.x + shift_x
                self.ball.dx = -self.ball.dx
            else
                self.ball.y = self.ball.y + shift_y
                self.ball.dy = -self.ball.dy
            end

            self.ball.dy = self.ball.dy*1.05
            self.ball.dx = self.ball.dx*1.05

        end
    end

    if self.ball:collides(self.paddle) then
        gSounds['paddle-hit']:stop()
        self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy
        gSounds['paddle-hit']:play()

        if (self.ball.x + self.ball.width/2)< (self.paddle.x+self.paddle.width/2) and self.paddle.dx < 0 then
            self.ball.dx =  -50 - 8*( (self.paddle.x + self.paddle.width/2) - (self.ball.x + self.ball.width/2)) 
        elseif (self.ball.x + self.ball.width/2) > (self.paddle.x+self.paddle.width/2) and self.paddle.dx > 0 then
            self.ball.dx =  50 - 8*( (self.paddle.x + self.paddle.width/2) - (self.ball.x + self.ball.width/2)) 
        end

    end

    -- here we have to pass the relevent things
    if self.ball.y>VIRTUAL_HEIGHT then
        self.health = self.health -1
        if self.health > 0 then
            gStateMachine:changeState('serve',{
                ['health'] = self.health,
                ['score'] = self.score,
                ['bricks'] = self.bricks,
                ['paddle'] = self.paddle,
                ['level'] = self.level,
            })
        else
            gStateMachine:changeState('gameover',{
                ['score'] = self.score,
            })
        end
    end

    if self:checkifdone() then
        gStateMachine:changeState('victory',{
            ['health'] = self.health,
            ['score'] = self.score,
            ['bricks'] = self.bricks,
            ['paddle'] = self.paddle,
            ['level'] = self.level,
        })

    end
end

function PlayState:render()
    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            brick:render()
        end
    end 
    -- for k, brick in pairs(self.bricks) do
        -- brick:renderParticles()
    -- end

    renderScore(self.score)
    renderHealth(self.health)
    self.paddle:render() 
    self.ball:render()
end

function PlayState:checkifdone()
    for k,brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end