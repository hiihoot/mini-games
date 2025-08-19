
--[[

    ###Tic Tac Teo###
    # Note:
    This is the first Game :) I Made from a challenge of 49 mini games 
    I learnd a lot (disipline ajmi), good luck for me on the next one
    ps: ( it lucks ugly, probably i will get back polishing all of them one day who knows)

    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    ## Next Game is: Memory Puzzle
    --hihoot
]]--

local winCells
local turn
local tie
local resetTimer


local grid = {
    {"", "", ""},
    {"", "", ""},
    {"", "", ""}
}

local function resetGame() 
    grid = {
        {"", "", ""},
        {"", "", ""},
        {"", "", ""}
    }
    winCells = {}
    tie = false
    turn = "X"
    resetTimer = nil
end

local function switchTurn()
    turn = (turn == "X") and "O" or "X"
end

function checkGameState()
    winCells = {}

    -- check rows
    for y = 1, #grid do
        if grid[y][1] ~= "" and grid[y][1] == grid[y][2] and grid[y][1] == grid[y][3] then
            table.insert(winCells, {px = 1, py = y})
            table.insert(winCells, {px = 2, py = y})
            table.insert(winCells, {px = 3, py = y})
            return true
        end
    end

    -- check cols
    for x = 1, #grid do
        if grid[1][x] ~= "" and grid[1][x] == grid[2][x] and grid[2][x] == grid[3][x] then
            table.insert(winCells, {px = x, py = 1})
            table.insert(winCells, {px = x, py = 2})
            table.insert(winCells, {px = x, py = 3})
            return true
        end
    end


    if grid[1][1] ~= "" and grid[1][1] == grid[2][2] and grid[1][1] == grid[3][3] then
        table.insert(winCells, {px=1, py=1})
        table.insert(winCells, {px=2, py=2})
        table.insert(winCells, {px=3, py=3})
        return true
    end

    if grid[1][3] ~= "" and grid[1][3] == grid[2][2] and grid[1][3] == grid[3][1] then
        table.insert(winCells, {px=3, py=1})
        table.insert(winCells, {px=2, py=2})
        table.insert(winCells, {px=1, py=3})
        return true
    end

    for y = 1, 3 do
        for x = 1, 3 do
            if grid[y][x] == "" then
                return nil
            end
        end
    end
    tie = true
    return "tie"
end

function love.mousepressed(x, y, button, istouch, presses)
    if button ~= 1 or winCells[1] then return end

        local col = math.floor(y / 200) + 1
        local row = math.floor(x / 200) + 1
        -- draw on empty cells
        if grid[col][row] == "" then
            grid[col][row] = turn
            local state = checkGameState()

            if not state then
                switchTurn()
            else
                resetTimer = 2
            end
        end
end

function drawGrid()
    love.graphics.setLineWidth(10)

    for y = 1, #grid do
        for x = 1, #grid[y] do
                love.graphics.rectangle("line",
                (x - 1) * 200,
                (y - 1) * 200, 
                200, 
                200)
        end
    end 

    for y = 1, #grid do
        for x = 1, #grid[y] do
            if grid[y][x] ~= "" then
                local isWin = false

                for _, cell in ipairs(winCells) do
                    if cell.px == x and cell.py == y then isWin = true end
                end

                if isWin then
                    love.graphics.setColor(0, 1, 0, 0.6) -- green
                    love.graphics.rectangle("fill",
                        (x - 1) * 200,
                        (y - 1) * 200,
                        200, 200)
                end

                love.graphics.setColor(1, 1, 1)
                love.graphics.printf(grid[y][x],
                (x - 1) * 200,
                (y - 1) * 200, 
                200, 
                "center")
            end
        end
    end
 end

function love.load()
    love.graphics.setFont(love.graphics.newFont(200))
    resetGame()
end

function love.update(dt)
    if resetTimer then
        resetTimer = resetTimer - dt
        if resetTimer <= 0 then resetGame() end
    end
end

function love.draw()
    drawGrid()
end