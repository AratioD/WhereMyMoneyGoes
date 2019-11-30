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

for i = 1, lengthOflist, 1 do
    print(i, " -- ", parsedData[i])

    if parsedData[i] == "KORTTIOSTO" then
        print(i, "transaktion hinta", parsedData[i - 1])
    end
end

-- for i, v in ipairs(parsedData) do
--     print(i, v)

--     if v == "KORTTIOSTO" then
--         print(i - 1, "summa2", v)
--     end
-- end
