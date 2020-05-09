function GenerateQuads(atlas,QuadWidth,QuadHeight)

    local sheetWidth = atlas:getWidth()/QuadWidth
    local sheetHeight = atlas:getHeight()/QuadHeight

    local counter = 1
    local spritesheet = {}
    for y= 0, sheetHeight-1 do
        for x= 0,sheetWidth-1 do
            spritesheet[counter] =
            love.graphics.newQuad(x*QuadWidth, y*QuadHeight, QuadWidth, QuadHeight,
            atlas:getDimensions())
            counter = counter +1
        end
    end
    return spritesheet
end

function GenerateArrows(atlas)
    local list = {}
    local width = atlas:getWidth()
    local height = atlas:getHeight()
    list[1] = love.graphics.newQuad(0,0,width/2,height,atlas:getDimensions())
    list[2] = love.graphics.newQuad(width/2,0,width/2,height,atlas:getDimensions())
    return list
end

function table.slice(tbl,first,last,step)
    sliced = {}
    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end

function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- smallest
        quads[counter] = love.graphics.newQuad(x, y, 32, 16,
            atlas:getDimensions())
        counter = counter + 1
        -- medium
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16,
            atlas:getDimensions())
        counter = counter + 1
        -- large
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16,
            atlas:getDimensions())
        counter = counter + 1
        -- huge
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16,
            atlas:getDimensions())
        counter = counter + 1

        -- prepare X and Y for the next set of paddles
        x = 0
        y = y + 32
    end

    return quads
end

function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    return quads
end

function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
end