Paddle = Class{}

function Paddle:init(whichone)

    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT -32
    self.dx = 0


    self.width = 64
    self.height = 16


    -- skin * size gives the quad we need to draw
    self.skin = whichone
end

function Paddle:update(dt)
    if love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    elseif love.keyboard.isDown('left') then
        self.dx = - PADDLE_SPEED
    else
        self.dx= 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx*dt)
    elseif self.dx > 0 then
        self.x = math.min(VIRTUAL_WIDTH-self.width, self.x + self.dx*dt)
    end 
end

function Paddle:render()
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.skin],self.x,self.y)
end