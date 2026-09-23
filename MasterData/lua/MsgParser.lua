local MsgParser = {
    inited = false
}

local utf8 = require("utf8")

local strLen = utf8.len
local strGsub = utf8.sub
local strSub = string.sub
local strLen = string.len
local strByte = string.byte
local strGsub = string.gsub

local _tree = {}

local function _word2Tree(root, word)
    if strLen(word) == 0 then
        return
    end

    local function _byte2Tree(r, ch, tail)
        if tail then
            if type(r[ch]) == 'table' then
                r[ch].isTail = true
            else
                r[ch] = true
            end
        else
            if r[ch] == true then
                r[ch] = {
                    isTail = true
                }
            else
                r[ch] = r[ch] or {}
            end
        end
        return r[ch]
    end

    local tmpparent = root
    local len = strLen(word)
    for i = 1, len do
        if tmpparent == true then
            tmpparent = {
                isTail = true
            }
        end
        tmpparent = _byte2Tree(tmpparent, strSub(word, i, i), i == len)
    end
end

local function _detect(parent, word, idx)
    local len = strLen(word)

    local ch = strSub(word, 1, 1)
    local child = parent[ch]

    if not child then
    elseif type(child) == 'table' then
        if len > 1 then
            if child.isTail then
                return _detect(child, strSub(word, 2), idx + 1) or idx
            else
                return _detect(child, strSub(word, 2), idx + 1)
            end
        elseif len == 1 then
            if child.isTail == true then
                return idx
            end
        end
    elseif (child == true) then
        return idx
    end
    return false
end

function MsgParser:getString(s)
    self:init()

    if type(s) ~= 'string' then
        return
    end
    local i = 1
    local len = strLen(s)
    local word, idx, tmps
    while true do
        word = strSub(s, i)
        idx = _detect(_tree, word, i)
        if idx then
            -- 每个字都替换
            -- tmps = strSub(s, 1, i-1)
            -- for j=1, idx-i+1 do
            -- 	tmps = tmps .. '*'
            -- end
            -- s = tmps .. strSub(s, idx+1)
            -- i = idx+1
            -- 词替换
            tmps = strSub(s, 1, i - 1)
            tmps = tmps .. '***'
            s = tmps .. strSub(s, idx + 1)
            i = 4
            len = len - (idx - 3)
        else
            i = i + 1
        end
        if i > len then
            break
        end
    end
    return s
end

function MsgParser:CheckContain(s)
    self:init()

    if type(s) ~= 'string' then
        return
    end
    local i = 1
    local len = strLen(s)
    local word, idx, tmps

    while true do
        word = strSub(s, i)
        idx = _detect(_tree, word, i)

        if idx then
            return true
        else
            i = i + 1
        end
        if i > len then
            break
        end
    end
    if (self:CheckContain2(s)) then
        return true
    end
    return false
end

function MsgParser:init()
    if self.inited then
        return
    end

    local cfgs = Cfgs.CfgSensitiveWord:GetAll()
    for _, v in pairs(cfgs) do
        _word2Tree(_tree, v.key)
    end

    self.inited = true
    -- package.loaded["ChatLayer/SensitiveCfg"] = nil
end

-- 判断同音字 是否包含
function MsgParser:CheckContain2(str)
    local len = GLogicCheck:GetStringLen(str)
    local cfgs = Cfgs.CfgSensitiveWordPhrase:GetAll()
    for k, v in pairs(cfgs) do
        if (len >= v.num) then
            local count = 0
            for n,m in pairs(v.word) do
                local wordCfg = Cfgs.CfgSensitiveWordDefine:GetByID(m)
                if (self:ContainsString(wordCfg.word, str)) then
                    count = count + 1
                end
                if (count >= v.num) then
                    return true
                end
            end
        end
    end
    return false
end

-- 字符串是否包含arr中的某个字
function MsgParser:ContainsString(arr, str)
    for i = 1, #arr do
        if string.find(str, arr[i]) then
            return true
        end
    end
    return false
end

return MsgParser
