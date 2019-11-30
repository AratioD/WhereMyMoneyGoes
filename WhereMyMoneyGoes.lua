local open = io.open
local parsedData = {}

local function readFile(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then
        return nil
    end
    local content = file:read "*a" -- *a or *all reads the whole file
    --print(content)
    file:close()
    return content
end

local function lineByLine(file)
    for token in string.gmatch(file, "[^;]+") do
        -- print(token)
        -- if token == nil then
        --     print("tyhjä", token)
        -- end
        table.insert(parsedData, token)
    end
end

local fileContent = readFile("tiliTiedot.csv")
--print(fileContent)
lineByLine(fileContent)

print(#parsedData)

local lengthOflist = #parsedData

local debit = 0
local lengthOfVar = 0
for i = 1, lengthOflist, 1 do
    --print(i, " -- ", parsedData[i])

    if parsedData[i] == "KORTTIOSTO" then
        local temp = 0
        local temp1 = 0
        local temp2 = 0
        print(i, "transaktion hinta", parsedData[i - 1])
        lengthOfVar = #parsedData[i - 1]
        temp = string.sub(parsedData[i - 1], 2, lengthOfVar)
        temp2 = string.gsub(temp, ',', '.')
        temp1 = tonumber(temp2)
        debit = debit + temp1
    end
end

print("debit is", debit)

-- for i, v in ipairs(parsedData) do
--     print(i, v)

--     if v == "KORTTIOSTO" then
--         print(i - 1, "summa2", v)
--     end
-- end
