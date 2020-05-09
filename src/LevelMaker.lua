LevelMaker = Class{}

function LevelMaker.CreateMap()

    local bricks = {}

    -- local numRows = math.random(1,5)
    -- we will set numRows to 5, and if it is to be skipped then so be it
    local numRows = 5
    -- for debug
        -- numRows = 1
    local numCols = math.random(7,13)
    -- for debug
        -- numcols = 7

    local skip = {}
    local emptyRow = {}
    local alternate = {}

    local count=0
    -- do we know which rows are empty, have skips and alternate
    

    -- we want atleast one row to be there.
    -- if count == 5 then
        -- emptyRow[1]= false
    -- end


    numCols =  numCols%2==0 and numCols+1 or numCols

    for y=1, numRows do

        local toskip = math.random(1,2)==1 and true or false
        local toalt  = math.random(1,2)==1 and true or false
        local toleave = math.random(1,2)==1 and true or false

        local skipvar = math.random(1,2)==1 and true or false
        local altvar =true
        local tile1tier = math.random(1,4)
        local tile1color = ((math.random(1,5)))
        local tile2tier = math.random(1,4)
        local tile2color = ((math.random(1,5)))

        if alternate[y] and tile1color==tile2color then
            tile2color= tile1color+1==6 and tile1color-1 or tile1color+1
        end
        -- if the row is not being skipped
        if not toleave then
            for x =1 , numCols do
                local tier = nil
                local color = nil
                local b = nil
                if toskip and skipvar then

                else

                    if toalt and altvar then
                        tier = tile2tier
                        color = tile2color
                    else
                        tier = tile1tier
                        color = tile1color
                    end
                    b = Brick((x-1)*32 + 8 + (13-numCols)*16, y*16, tier,color)
                end
                
                skipvar = not skipvar
                altvar = not altvar

                if b then
                    table.insert(bricks,b)
                end
            end
        end
    end
    return bricks

end