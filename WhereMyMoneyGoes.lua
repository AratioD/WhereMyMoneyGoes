--  local accountFile = require "tiliTiedot.csv"
-- -- local m = accountFile = require "tiliTiedot.csv"
-- -- .read('tiliTiedot.csv') -- read file csv1.txt to matrix m
-- -- print(m[2][3])                       -- display element in row 2 column 3 (102)
-- -- -- m[1][3] = 'changed'                  -- change element in row 1 column 3
-- -- -- m[2][3] = 123.45                     -- change element in row 2 column 3
-- -- -- csvfile.write('./csv2.txt', m)    

-- local citylist = {}
-- for line in io.lines(accountFile) do
--     local city, region, coalition, coordinate_x, coordinate_y = line:match("%s*(.-),%s*(.-),%s*(.-),%s*(.-),%s*(.-)")
--     citylist[#citylist + 1] = { city = city, region = region, coalition = coalition, coordinate_x = coordinate_x, coordinate_y = coordinate_y }
-- end
local open = io.open

local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local fileContent = read_file("tiliTiedot.csv");
print (fileContent);