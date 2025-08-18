
local grid = {
    {"", "", ""},
    {"", "", "X"},
    {"", "", "X"}
}
local turn = "X" 

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
        local col = math.floor(y / 200) + 1
        local row = math.floor(x / 200) + 1
        grid[col][row] = turn

        if turn == "X" then
            turn = "O"
        else
            turn = "X"
        end
        checkWin()
    elseif button == 2 then
        grid = {
            {"", "", ""},
            {"", "", ""},
            {"", "", ""}
        }
    end
end

function checkWin()
    for y = 1, #grid do
        for x = 1, #grid[y] do
            if grid[y][x] ~= "" and grid[y][1] == grid[y][2] and grid[y][1] == grid[y][3] then
                print(grid[y][x] .. " Won")
            end
        end
    end

    for x = 1, #grid do
        if grid[1][x] ~= "" and grid[1][x] == grid[2][x] and grid[2][x] == grid[3][x] then
            print(grid[1][x] .. " Won")
        end
    end
end

function love.load()
    love.graphics.setFont(love.graphics.newFont(200))
end

function love.update(dt)

end

function love.draw()
    drawGrid()
end