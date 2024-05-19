tortie = require('tortie')

FUEL_THRESHOLD = 64
SLEEP_TIME = 5

-- Baker Turtle
--   finds wheat chest, crafts bread, deposits bread, starts again
--
-- would be nice to have:
--   - pathfinding pos chest to chest
--
-- args:
--   'n', 1, 2, 3
local function bread(f, x, y, z)
    ctx = tortie.buildCtx(f, x, y, z)
    startCtx = tortie.buildCtx(f, x, y, z)
    run = true
    while run do
        -- refuel
        if turtle.getFuelLevel() < FUEL_THRESHOLD then
            tortie.turnLeft(ctx)
            tortie.turnLeft(ctx)
            while (turtle.getFuelLevel() < FUEL_THRESHOLD) do
                turtle.suck(1)
                turtle.refuel(1)
            end
            tortie.turnLeft(ctx)
            tortie.turnLeft(ctx)
        end
        -- pick wheat
        tortie.turnRight(ctx)
        tortie.forward(ctx, 1)
        not_enough_wheat = true
        bread_count = 0
        while not_enough_wheat do
            turtle.suck(64)
            details = turtle.getItemDetail()
            wheat = details.count
            leftover_wheat = details.count % 3
            bread_count = (wheat - leftover_wheat) / 3
            if (bread_count > 0) then
                not_enough_wheat = false
                turtle.drop(leftover_wheat)
            else
                turtle.drop(64)
                sleep(SLEEP_TIME)
            end
        end
        -- bread
        turtle.transferTo(2, bread_count)
        turtle.transferTo(3, bread_count)
        turtle.craft(bread_count)
        -- deposit
        tortie.turnLeft(ctx)
        tortie.turnLeft(ctx)
        tortie.forward(ctx, 1)
        tortie.turnRight(ctx)
        tortie.forward(ctx, 2)
        turtle.drop(64)
        -- back to station
        tortie.turnLeft(ctx)
        tortie.turnLeft(ctx)
        tortie.forward(ctx, 2)
        print('loop done')
        -- re-init
        if (ctx.x ~= startCtx.x) or (ctx.y ~= startCtx.y) or (ctx.z ~= startCtx.z) then
            run = false
        end
        while (ctx.facing ~= startCtx.facing) do
            tortie.turnLeft(ctx)
        end
    end
    print('end bread')
end

return {
    bread = bread
}