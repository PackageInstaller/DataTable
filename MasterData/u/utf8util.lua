local utf8 = require "lua-utf8"

local utf8util = setmetatable({}, { __index = utf8 })

-- 名称可用符号（不包含空格，半角0x20与全角0x3000都不放开）
-- 仅放开：. - _
local NAME_LEGAL_SYMBOLS = {
    [0x2E] = true, -- .
    [0x2D] = true, -- -
    [0x5F] = true, -- _
}

function utf8util.runeLen(r)
    local surrogateMin = 55296 --0xD800
    local surrogateMax =57343 -- 0xDFFF
    local rune1Max = 127 --1<<7 - 1
    local rune2Max = 2047 -- 1<<11 - 1
    local rune3Max =65535 -- 1<<16 - 1
    local MaxRune  = 1114111-- "\U0010FFFF" -- Maximum valid Unicode code point.

    if r < 0 then
        return -1
    elseif r <= rune1Max then
        return 1
    elseif r <= rune2Max then
        return 2
    elseif surrogateMin <= r and r <= surrogateMax then
        return -1
    elseif r <= rune3Max then
        return 3
    elseif r <= MaxRune then
        return 4
    else
        return -1
    end
end

function utf8util.hasSymbolChar(str)
    for p, c in utf8util.codes(str) do
        if utf8util.runeLen(c) > 2 then
            return true
        end
    end

    return false
end

function utf8util.hasEmoji(str)
    for p, c in utf8util.codes(str) do
        if utf8util.runeLen(c) >= 4 then
            return true
        end
    end

    return false
end

function utf8util.replaceEmojiWith(str, rep)
    local tb = {}
    for p, c in utf8util.codes(str) do
        if utf8util.runeLen(c) >= 4 then
            if rep then
                table.insert(tb, rep)
            end
        else
            table.insert(tb, utf8util.char(c))
        end
    end

    return table.concat(tb)
end

function utf8util.filterEmoji(str)
    if not utf8util.hasEmoji(str) then
        return str
    end

    return utf8util.replaceEmojiWith(str, " ")
end

function utf8util.isOnlyChinese(word)
    for i = 1, utf8util.len(word) do
        local bt = utf8util.byte(word, i)
        if bt < 0x4e00 then
            if bt ~= 0x3400 and bt ~= 0x4DB5 then
                return false
            end
        end

        if bt > 0x9fa5 then
            return false
        end
    end

    return true
end

function utf8util.isNameLegal(word)
    for i = 1, utf8util.len(word) do
        local bt = utf8util.byte(word, i)
        local valid = false
        if bt >= 0x4e00 and bt <= 0x9FFF then
            valid = true
        elseif bt >= 0x3400 and bt <= 0x4DBF then
            valid = true
        elseif bt >= 0x20000 and bt <= 0x2A6DF then
            valid = true
        elseif bt >= 0x30 and bt <= 0x39 then
            valid = true
        elseif bt >= 0x61 and bt <= 0x7a then
            valid = true
        elseif bt >= 0x41 and bt <= 0x5a then
            valid = true
        elseif NAME_LEGAL_SYMBOLS[bt] then
            valid = true
        end
        if not valid then
            return false
        end
    end

    return true
end

return utf8util