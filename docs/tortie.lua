-- utils lib
--   in-memory geolocalization

local function buildCtx(facing, x, y, z)
    return {
        facing = facing,
        x = x,
        y = y,
        z = z
    }
end

local function up(ctx, count)
    local ret = true
    while (count > 0) do
        if turtle.up() ~= true then
            count = 0
            ret = false
        else
            count = count - 1
            ctx.y = ctx.y + 1
            sleep(1)
        end
    end
    return ret
end

local function down(ctx, count)
    local ret = true
    while (count > 0) do
        if turtle.down() ~= true then
            count = 0
            ret = false
        else
            count = count - 1
            ctx.y = ctx.y - 1
            sleep(1)
        end
    end
    return ret
end

local function forward(ctx, count)
    local ret = true
    while (count > 0) do
        if turtle.forward() ~= true then
            count = 0
            ret = false
        else
            sleep(1)
            if (ctx.facing == 'n') then
                ctx.z = ctx.z - 1
            elseif (ctx.facing == 's') then
                ctx.z = ctx.z + 1
            elseif (ctx.facing == 'w') then
                ctx.x = ctx.x - 1
            elseif (ctx.facing == 'e') then
                ctx.x = ctx.x + 1
            end
        end
    end
    return ret
end

local function back(ctx, count)
    local ret = true
    while (count > 0) do
        if turtle.back() ~= true then
            count = 0
            ret = false
        else
            sleep(1)
            if (ctx.facing == 'n') then
                ctx.z = ctx.z - 1
            elseif (ctx.facing == 's') then
                ctx.z = ctx.z + 1
            elseif (ctx.facing == 'w') then
                ctx.x = ctx.x - 1
            elseif (ctx.facing == 'e') then
                ctx.x = ctx.x + 1
            end
        end
    end
    return ret
end

local function turnLeft(ctx)
    turtle.turnLeft()
    if (ctx.facing == 'n') then
        ctx.facing = 'e'
    elseif (ctx.facing == 'e') then
        ctx.facing = 's'
    elseif (ctx.facing == 's' ) then
        ctx.facing = 'w'
    elseif (ctx.facing == 'w') then
        ctx.facing = 'n'
    end
end

local function turnRight(ctx)
    turtle.turnRight()
    if (ctx.facing == 'n') then
        ctx.facing = 'w'
    elseif (ctx.facing == 'e') then
        ctx.facing = 'n'
    elseif (ctx.facing == 's' ) then
        ctx.facing = 'e'
    elseif (ctx.facing == 'w') then
        ctx.facing = 's'
    end
end

return {
    buildCtx = buildCtx,
    up = up,
    down = down,
    forward = forward,
    back = back,
    turnRight = turnRight,
    turnLeft = turnLeft
}