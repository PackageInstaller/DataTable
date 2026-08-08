-- HttpCrypt
local HttpCrypt = class("HttpCrypt")
local cjson = require "cjson"
local crypt = require "crypt"

local HttpCrypt = {}

function HttpCrypt:ctor()

end

--- 特殊字符编码 与  url.QueryEscape 一致
function HttpCrypt:urlEncode(str)
    if not str then
        return ""
    end
    -- 将所有非字母数字字符编码为 %XX 格式
    str = string.gsub(str, "([^%w%-%.~_])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    -- 将空格编码为 %20
    str = string.gsub(str, " ", "%%20")
    return str
end

--- 递归排序和编码表
function HttpCrypt:sortAndEncodeTable(t)
    if type(t) ~= "table" then
        return t
    end

    local keys = {}
    for key in pairs(t) do
        table.insert(keys, key)
    end
    table.sort(keys)

    local result = {}
    for _, key in ipairs(keys) do
        local value = t[key]
        if value ~= nil then
            result[key] = HttpCrypt.sortAndEncodeTable(value)
        end
    end

    return result
end

--- table 参数字典排序后&拼接
function HttpCrypt:stringify(data)
    if type(data) ~= "table" then
        return data
    end

    -- 递归排序和编码表
    data = HttpCrypt:sortAndEncodeTable(data)

    local keys = {}
    for key, _ in pairs(data) do
        table.insert(keys, key)
    end
    table.sort(keys)

    -- 组合成 key=value 形式的字符串
    local encodedParams = {}
    for _, key in ipairs(keys) do
        local value = data[key]
        if value ~= nil then
            local encodedValue = ""
            if type(value) == "table" then
                encodedValue = self:urlEncode(cjson.encode(value))
            else
                encodedValue = self:urlEncode(value)
            end

            table.insert(encodedParams, self:urlEncode(key) .. "=" .. encodedValue)
        end
    end

    -- 用 & 连接
    return table.concat(encodedParams, "&")
end

--- 生成签名
function HttpCrypt:generateSignature(method, path, params, secret, channelStr)
    if not secret then
        return ""
    end
    method = string.upper(method)
    if not params then
        params = {}
    end
	    --- 生成签名
    local sortedEncodedParams = self:stringify(params)
    local message = string.format("%s\n%s\n%s\n%s", method, path, channelStr, sortedEncodedParams)
    return crypt.base64encode(crypt.hmac_sha1(secret, message))
end

return HttpCrypt
