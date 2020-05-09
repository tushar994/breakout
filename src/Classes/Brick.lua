Brick = Class()

paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}

function Brick:init(x,y,tier,color)
    self.tier = tier
    self.color = color
    self.width = 32
    self.height = 16

    self.x = x
    self.y = y

    self.inPlay = true

end

function Brick:hit()
    gSounds['brick-hit-2']:stop()
    gSounds['brick-hit-2']:play()

    self.tier = self.tier - 1
    if self.tier==0 then
        self.inPlay = false
    end
end
function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'],gFrames['bricks'][(self.color-1)*4 + self.tier],
        self.x,self.y)
    end
end
