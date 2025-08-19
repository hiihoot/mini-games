
local grid = {
    {"", "", ""},
    {"", "", ""},
    {"", "", ""}
}
local winCells = {}
local turn = "X" 
local tie = false
local timer = 2

function drawGrid()
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
                    if cell.px == x and cell.py == y then
                        isWin = true
                        break
                    end
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

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if #winCells <= 0 then
            local col = math.floor(y / 200) + 1
            local row = math.floor(x / 200) + 1
        -- draw on empty cells
            if grid[col][row] == "" then
                grid[col][row] = turn
            -- switch up 
                if turn == "X" then
                    turn = "O"
                else
                    turn = "X"
                end
            end
        end
        checkWin()
    end
end

function checkWin()
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

    return nil
end

function reSet(dt)
    for y = 1, 3 do
        for x = 1, 3 do
            if grid[y][x] ~= "" then
                tie = true
            else
                tie = false
            end
        end
    end

    if tie or checkWin() then
        timer = timer - dt
        if timer <= 0 then 
            grid = {
                {"", "", ""},
                {"", "", ""},
                {"", "", ""}
            }
            winCells = {}
            timer = 2
            tie = false
        end
    end
end


function love.load()
    love.graphics.setFont(love.graphics.newFont(200))
end

function love.update(dt)
        reSet(dt)
end

function love.draw()
    love.graphics.setLineWidth(10)
    drawGrid()
end