-- (4 + addition) * multiply

local p = {}

function Calculate(Add, AddMin, AddMax, Mult, MultMin, MultMax)
    if Add == 0 then Add = nil end
    if AddMin == 0 then AddMin = nil end
    if AddMax == 0 then AddMax = nil end
    if Mult == 0 then Mult = nil end
    if MultMin == 0 then MultMin = nil end
    if MultMax == 0 then MultMax = nil end

    -- Single addition and single multiply
    if Add and not AddMin and not AddMax and Mult and not MultMin and not MultMax then
    	local as = (4 + Add) * Mult
        return math.floor(as*100)/100, math.floor(1/as*100)/100
    -- Single addition, range multiply
    elseif Add and not AddMin and not AddMax and not Mult and MultMin and MultMax then
    	local as1 = (4 + Add) * MultMin
    	local as2 = (4 + Add) * MultMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Range addition, single multiply
    elseif not Add and AddMin and AddMax and Mult and not MultMin and not MultMax then
    	local as1 = (4 + AddMin) * Mult
    	local as2 = (4 + AddMax) * Mult
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Range addition, range multiply
    elseif not Add and AddMin and AddMax and not Mult and MultMin and MultMax then
    	local as1 = (4 + AddMin) * MultMin
    	local as2 = (4 + AddMax) * MultMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- No addition, single multiply
    elseif not Add and not AddMin and not AddMax and Mult and not MultMin and not MultMax then
    	local as = 4 * Mult
        return math.floor(as*100)/100, math.floor(1/as*100)/100
    -- No addition, range multiply
    elseif not Add and not AddMin and not AddMax and not Mult and MultMin and MultMax then
    	local as1 = 4 * MultMin
        local as2 = 4 * MultMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Single addition, no multiply
    elseif Add and not AddMin and not AddMax and not Mult and not MultMin and not MultMax then
    	local as = 4 + Add
        return math.floor(as*100)/100, math.floor(1/as*100)/100
    -- Range addition, no multiply
    elseif not Add and AddMin and AddMax and not Mult and not MultMin and not MultMax then
    	local as1 = 4 * AddMin
        local as2 = 4 * AddMax
        return math.floor(as1*100)/100, math.floor(as2*100)/100, math.floor(1/as1*100)/100, math.floor(1/as2*100)/100
    -- Bruh
    else
        return "Invalid input!", "Invalid Input!"
    end
end

p.Calculate = function(frame)
	local as1, as2, as3, as4 = Calculate(tonumber(frame.args[1]), tonumber(frame.args[2]), tonumber(frame.args[3]), tonumber(frame.args[4]), tonumber(frame.args[5]), tonumber(frame.args[6]))
	if as3 then
    	return string.format("{{InlineInfo|Text=%s|Inline text=%s strikes per second}} - {{InlineInfo|Text=%s|Inline text=%s strikes per second}}", as1, as3, as2, as4)
    else
    	return string.format("{{InlineInfo|Text=%s|Inline text=%s strikes per second}}", as1, as2)
    end
end

return p
-- print(Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6])))