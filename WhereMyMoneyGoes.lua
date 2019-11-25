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
        table.insert(parsedData, token)
    end
end

local fileContent = readFile("tiliTiedot.csv")
--print(fileContent)
lineByLine(fileContent)
print(parsedData)
