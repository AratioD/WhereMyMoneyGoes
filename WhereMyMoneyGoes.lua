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

--Your local file what to read. Please note with these settings it is in the same folder with the script
local fileContent = readFile("tiliTiedot.csv")
--print(fileContent)
lineByLine(fileContent)

print(#parsedData)

local lengthOflist = #parsedData

local cardPurchase = 0
local eInvoice = 0
local paperInvoice = 0
local negativeAccoTrans = 0
local positiveAccoTrans = 0
local positiveAccoTrans = 0

local lengthOfTransaction = 0
local tempMoneyTransaction = 0
local purchaseId = ""
local temp = 0
local temp1 = 0
local temp2 = 0

local accountTransfer = {}

for i = 1, lengthOflist, 1 do
    print(i, " -- ", parsedData[i])

    if
        parsedData[i] == "TILISIIRTO" or parsedData[i] == "E-LASKU" or parsedData[i] == "VERKKOMAKSU" or
            parsedData[i] == "KORTTIOSTO"
     then
        --allocate a money transaction to temporary variable.
        tempMoneyTransaction = parsedData[i - 1]
        --How many characteristics is a one transaction... e.g -23,43 is 5 tokens.
        lengthOfTransaction = #tempMoneyTransaction
        --Is a transaction a positive or negative. This check is that "+" or "-"
        isPlusOrNegative = string.sub(tempMoneyTransaction, 1, 1)
        --which was the purchase target
        purchaseId = parsedData[i + 2]

        if isPlusOrNegative == "-" then
            --take money value out
            temp = string.sub(tempMoneyTransaction, 2, lengthOfTransaction)
            --change possible colon to dot
            temp2 = string.gsub(temp, ",", ".")
            --change string to numerical value
            temp1 = tonumber(temp2)
            if accountTransfer[purchaseId] ~= nil then
                --Table insert if there IS a previous value
                accountTransfer[purchaseId] = accountTransfer[purchaseId] - temp1
            else
                --Table insert if there is not a previous value
                accountTransfer[purchaseId] = -temp1
            end
        elseif isPlusOrNegative == "+" then
            --take money value out
            temp = string.sub(tempMoneyTransaction, 2, lengthOfTransaction)
            --change possible colon to dot
            temp2 = string.gsub(temp, ",", ".")
            --change string to numerical value
            temp1 = tonumber(temp2)
            --value allocation
            if accountTransfer[purchaseId] ~= nil then
                --Table insert if there IS a previous value
                accountTransfer[purchaseId] = accountTransfer[purchaseId] + temp1
            else
                --Table insert if there is not a previous value
                accountTransfer[purchaseId] = temp1
            end
        end
    end
end

--lengthOflist = #accountTransfer


for key,value in pairs(accountTransfer) do print(key,value) end