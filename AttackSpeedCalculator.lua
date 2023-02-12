-- (4 + addition) * multiply

local p = {}

function Calculate(AdditionalAttackSpeed, AdditionalAttackSpeedMin, AdditionalAttackSpeedMax, MultiplyAttackSpeed, MultiplyAttackSpeedMin, MultiplyAttackSpeedMax)
    -- Single addition and multiply
    if AdditionalAttackSpeed ~= 0 and MultiplyAttackSpeed ~= 0 then
    	local as = (4 + AdditionalAttackSpeed) * MultiplyAttackSpeed
        return math.floor(as*100)/100, math.floor(1/as*100)/100
    -- Single addition, range multiply
    elseif AdditionalAttackSpeed ~= 0 and MultiplyAttackSpeedMin ~= 0 and MultiplyAttackSpeedMax ~= 0 then
    	local as1 = (4 + AdditionalAttackSpeed) * MultiplyAttackSpeedMin
    	local as2 = (4 + AdditionalAttackSpeed) * MultiplyAttackSpeedMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Range addition, single multiply
    elseif MultiplyAttackSpeed ~= 0 and AdditionalAttackSpeedMin ~= 0 and AdditionalAttackSpeedMax ~= 0 then
    	local as1 = (4 + AdditionalAttackSpeedMin) * MultiplyAttackSpeed
    	local as2 = (4 + AdditionalAttackSpeedMax) * MultiplyAttackSpeed
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Range addition and multiply
    elseif AdditionalAttackSpeedMin ~= 0 and AdditionalAttackSpeedMax ~= 0 and MultiplyAttackSpeedMin ~= 0 and MultiplyAttackSpeedMax ~= 0 then
    	local as1 = (4 + AdditionalAttackSpeedMin) * MultiplyAttackSpeedMin
    	local as2 = (4 + AdditionalAttackSpeedMax) * MultiplyAttackSpeedMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Bruh
    else
        return "Invalid input!", "Invalid input!"
    end
end

p.Calculate = function(frame)
	local as1, as2, as3, as4 = Calculate(tonumber(frame.args[1]), tonumber(frame.args[2]), tonumber(frame.args[3]), tonumber(frame.args[4]), tonumber(frame.args[5]), tonumber(frame.args[6]))
	if as3 then
    	return string.format("{{#tip-text: %s | %s strikes per second}} - {{#tip-text: %s | %s strikes per second}}", as1, as3, as2, as4)
    else
    	return string.format("{{#tip-text: %s | %s strikes per second}}", as1, as2)
    end
end

return p
-- print(Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6])))
