-- (4 + addition) * multiply

local p = {}

function Calculate(AdditionalAttackSpeed, AdditionalAttackSpeedMin, AdditionalAttackSpeedMax, MultiplyAttackSpeed, MultiplyAttackSpeedMin, MultiplyAttackSpeedMax)
    -- Single addition and multiply
    if AdditionalAttackSpeed ~= 0 and MultiplyAttackSpeed ~= 0 then
        return string.format("%s", (4 + AdditionalAttackSpeed) * MultiplyAttackSpeed)
    -- Single addition, range multiply
    elseif AdditionalAttackSpeed ~= 0 and MultiplyAttackSpeedMin ~= 0 and MultiplyAttackSpeedMax ~= 0 then
        return string.format("%s - %s", (4 + AdditionalAttackSpeed) * MultiplyAttackSpeedMin, (4 + AdditionalAttackSpeed) * MultiplyAttackSpeedMax)
    -- Range addition, single multiply
    elseif MultiplyAttackSpeed ~= 0 and AdditionalAttackSpeedMin ~= 0 and AdditionalAttackSpeedMax ~= 0 then
        return string.format("%s - %s", (4 + AdditionalAttackSpeedMin) * MultiplyAttackSpeed, (4 + AdditionalAttackSpeedMax) * MultiplyAttackSpeed)
    -- Range addition and multiply
    elseif AdditionalAttackSpeedMin ~= 0 and AdditionalAttackSpeedMax ~= 0 and MultiplyAttackSpeedMin ~= 0 and MultiplyAttackSpeedMax ~= 0 then
        return string.format("%s - %s", (4 + AdditionalAttackSpeedMin) * MultiplyAttackSpeedMin, (4 + AdditionalAttackSpeedMax) * MultiplyAttackSpeedMax)
    -- Bruh
    else
        return "Invalid input!"
    end
end

p.Calculate = function()
    return Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6]))
end

return p
-- print(Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6])))