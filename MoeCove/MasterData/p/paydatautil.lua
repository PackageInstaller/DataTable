
--编码
--@param {string} data
--@param {boolean} flag
--@retrun {array} array  {number} lens
local function getByte(data, flag)
    local array = {}
    local lens = string.len(data)
    if (flag == false) then
        for i = 1, lens do
            array[i] = string.byte(data, i)
        end
        return array
    else
        for i = 1, lens do
            array[i-1] = string.byte(data, i)
        end
    end
    return array, lens
end

--字符串替换
--@param {string} str
--@param {string} reps
--@retrun {table} resultStrList
local function stringSplit(str, reps)
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList, w)
    end)
    return resultStrList
end

-- 解密
--@param {string} data
--@param {string} keys
--@retrun {string} result
local function decryptData(data, keys)
    local result = ""
    local dataArr = stringSplit(data, '@')
    local keyArr, keyLen = getByte(keys, true)
    local results = {}
    for index, value in pairs(dataArr) do
        local bytes =  tonumber(value) - (0xFF and keyArr[(index-1) % keyLen])
        table.insert(results, string.char(bytes))
    end
    local result = table.concat(results)
    return result
end

-- 加密
--@param {string} data
--@param {string} keys
--@retrun {string} result
local function encryptData(data, keys)
    local result = ""
    local dataArr = getByte(data, false)
    local keyArr, keyLen = getByte(keys, true)
    local results = {}
    for index, value in pairs(dataArr) do
        table.insert(results, "@")
        table.insert(results, tostring((0xFF and value) + (0xFF and keyArr[(index-1) % keyLen])))
    end
    local result = table.concat(results)
    return result
end


local util = {}

local keys = "QlFLzorvq7wnqNjHxtiUw2T9oymktf7J"

local crypt = require "crypt"

function util.encryptPayData(data)
    local data1 = encryptData(data, keys)
    local data2 = crypt.base64encode(data1)
    return data2
end

function util.decryptPayData(data)
    local data1 = crypt.base64decode(data)
    local data2 = decryptData(data1, keys)
    return data2
end

return util