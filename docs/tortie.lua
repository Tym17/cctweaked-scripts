
local function startTortieContext(facing, x, y, z)
    return {
        facing,
        x,
        y,
        z
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
        end
    end
    return ret
end

local function down(ctx, count)
    local ret = true
    while (count > 0) do
        if turtle.up() ~= true then
            count = 0
            ret = false
        else
            count = count - 1
            ctx.y = ctx.y - 1
        end
    end
    return ret
end

return {
    startTortieContext = startTortieContext,
    up = up,
    down = down
}