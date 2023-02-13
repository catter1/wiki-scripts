local test = {}

for k, v in pairs(arg) do
    if k > 0 then
        table.insert(test, k, tonumber(v))
    end
end

for k, v in pairs(test) do
    print(type(k), type(v))
    print(k ,v)
end