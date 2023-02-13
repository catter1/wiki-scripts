-- damage * attackspeed

local p = {}

function Round(val)
    return math.floor(val*100)/100
end

function Calculate(Damage, DamageMin, DamageMax, Speed, SpeedMin, SpeedMax)
	local bitval = 0
    if Damage ~= 0 then bitval = bitval + 1 end
    if DamageMin ~= 0 then bitval = bitval + 2 end
    if DamageMax ~= 0 then bitval = bitval + 4 end
    if Speed ~= 0 then bitval = bitval + 8 end
    if SpeedMin ~= 0 then bitval = bitval + 16 end
    if SpeedMax ~= 0 then bitval = bitval + 32 end

    -- Single damage and single speed
    if bitval == 9 then
    	local dps = Damage / Speed
        return Round(dps)
    -- Single damage, range speed
    elseif bitval == 49 then
    	local dps1 = Damage / SpeedMin
    	local dps2 = Damage / SpeedMax
        return Round(dps1), Round(dps2)
    -- Range damage, single speed
    elseif bitval == 14 then
    	local dps1 = DamageMin / Speed
    	local dps2 = DamageMax / Speed
        return Round(dps1), Round(dps2)
    -- Range damage, range speed
    elseif bitval == 54 then
    	local dps1 = DamageMin / SpeedMin
    	local dps2 = DamageMax / SpeedMax
        return Round(dps1), Round(dps2)
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

	local dps1, dps2 = Calculate(table.unpack(clean_args))  --Getting an error here? change table.unpack to unpack!
	if not dps1 then
        return "Invalid input!"
    elseif dps2 then
    	return string.format("%s - %s", frame:expandTemplate{title="Health", args = {dps1}}, frame:expandTemplate{title="Health", args = {dps2}})
    else
    	return frame:expandTemplate{title="Health", args = {dps1}}
    end
end

return p

-- print(p.Calculate(arg))
-- print(Calculate(tonumber(arg[1]), tonumber(arg[2]), tonumber(arg[3]), tonumber(arg[4]), tonumber(arg[5]), tonumber(arg[6])))