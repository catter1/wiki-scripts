-- (4 + addition) * multiply

local p = {}

function Round(val)
    return math.floor(val*100)/100
end

function Calculate(Add, AddMin, AddMax, Mult, MultMin, MultMax)
    local bitval = 0
    if Add ~= 0 then bitval = bitval + 1 end
    if AddMin ~= 0 then bitval = bitval + 2 end
    if AddMax ~= 0 then bitval = bitval + 4 end
    if Mult ~= 0 then bitval = bitval + 8 end
    if MultMin ~= 0 then bitval = bitval + 16 end
    if MultMax ~= 0 then bitval = bitval + 32 end

    -- Single addition and single multiply
    if bitval == 9 then
    	local as = (4 + Add) * Mult
        return Round(as), Round(1/as)
    -- Single addition, range multiply
    elseif bitval == 49 then
    	local as1 = (4 + Add) * MultMin
    	local as2 = (4 + Add) * MultMax
        return Round(as1), Round(1/as1), Round(as2), Round(1/as2)
    -- Range addition, single multiply
    elseif bitval == 14 then
    	local as1 = (4 + AddMin) * Mult
    	local as2 = (4 + AddMax) * Mult
        return Round(as1), Round(1/as1), Round(as2), Round(1/as2)
    -- Range addition, range multiply
    elseif bitval == 54 then
    	local as1 = (4 + AddMin) * MultMin
    	local as2 = (4 + AddMax) * MultMax
        return Round(as1), Round(1/as1), Round(as2), Round(1/as2)
    -- No addition, single multiply
    elseif bitval == 8 then
    	local as = 4 * Mult
        return Round(as), Round(1/as)
    -- No addition, range multiply
    elseif bitval == 48 then
    	local as1 = 4 * MultMin
        local as2 = 4 * MultMax
        return Round(as1), Round(1/as1), Round(as2), Round(1/as2)
    -- Single addition, no multiply
    elseif bitval == 1 then
    	local as = 4 + Add
        return Round(as), Round(1/as)
    -- Range addition, no multiply
    elseif bitval == 6 then
    	local as1 = 4 * AddMin
        local as2 = 4 * AddMax
        return Round(as1), Round(1/as1), Round(as2), Round(1/as2)
    -- Bruh
    else
        return nil
    end
end

p.Calculate = function(frame)
    local clean_args = {}
    for k, v in pairs(frame.args) do
        if k > 0 then
            table.insert(clean_args, k, tonumber(v))
        end
    end

	local as1, as2, as3, as4 = Calculate(table.unpack(clean_args)) --Getting an error here? change table.unpack to unpack!
    if not as1 then
        return "Invalid input!"
    elseif as3 then
    	return string.format("%s - %s", frame:callParserFunction("#tip-text", as1, string.format("%s strikes per second", as3)), frame:callParserFunction("#tip-text", as2, string.format("%s strikes per second", as4)))
    else
    	return frame:callParserFunction("#tip-text", as1, string.format("%s seconds per strike", as2))
    end
end

return p

-- print(p.Calculate(arg))
-- print(Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6])))