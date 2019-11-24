local open = io.open

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
    for i in string.gmatch(file, "%S+") do
        if string.match(i, "Oyj") then
            print(i)
            print("enterprise found")
        else
            print("The word tiger was not found.")
        end
    end
end

local fileContent = readFile("tiliTiedot.csv")
--print(fileContent)
lineByLine(fileContent)
