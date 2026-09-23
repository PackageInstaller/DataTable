local this = {};

-- 是否为空
function this:IsEmpty(s)
    return s == nil or s == "";
end

-- 切割字符串
function this:split(str, reps)
    if (self:IsEmpty(str)) then
        return "", ""
    end
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+', function(w)
        table.insert(resultStrList, w)
    end)
    return resultStrList
end

-- 用字符串切割
function this:Split(str, reps)
    local result = {}
    local start_index = 1
    local end_index = string.find(str, reps)

    while end_index do
        local part = string.sub(str, start_index, end_index - 1)
        table.insert(result, part)

        start_index = end_index + string.len(reps)
        end_index = string.find(str, reps, start_index)
    end

    local last_part = string.sub(str, start_index)
    table.insert(result, last_part)

    return result
end

-- 默认黑色
function this:SetColorByName(txt, str, colorName)
    if (txt == nil) then
        return
    end
    colorName = colorName or "000000"
    str = string.format("<color=#%s>%s</color>", colorName, str)
    CSAPI.SetText(txt, str)
end

function this:SetColor(_str, _type)
    local _color = ""
    if (_type == nil or _type == "" or _type == "white") then
        _color = "<color=#ffffff>"
    elseif (_type == "red") then
        _color = "<color=#FF0909>"
    elseif (_type == "green") then
        _color = "<color=#00FF78>"
    elseif (_type == "black") then
        _color = "<color=#000000>"
    elseif (_type == "blue") then
        _color = "<color=#12BEEE>"
    elseif (_type == "purple") then
        _color = "<color=#783CE1>"
    elseif (_type == "orange") then
        _color = "<color=#FD7704>"
    elseif (_type == "yellow") then
        _color = "<color=#FABE00>"
    elseif (_type == "gray") then
        _color = "<color=#919193>"
    end
    return string.format("%s%s%s", _color, _str, "</color>")
end

function this:SetScale(_str, _scale)
    local scale = _scale or 30
    return string.format("<size=%s>%s</size>", scale, _str)
end

function this:SetByColor(_str, _color)
    return string.format("<color=#%s>%s%s", _color, _str, "</color>")
end

-- len 限制长度，长出部分用replace代替 replace为nil是由 ... 代替
function this:SetStringByLen(str, len, replace)
    if (len == nil or len == 0) then
        return str
    end
    local length, chars = GLogicCheck:GetStringLen(str)
    if (chars == nil) then
        return ""
    elseif (len >= #chars) then
        return str
    else
        local newStr = ""
        for i, v in ipairs(chars) do
            if (i <= len) then
                newStr = newStr .. v
            end
        end
        replace = replace == nil and "..." or replace
        return newStr .. replace
    end
end

-- 返回某个字符在字符串中出现的次数
function this:GetCharNum(str, char)
    local num = 0;
    for k, v in string.gmatch(str, char) do
        num = num + 1;
    end
    return num;
end

-- 通过字符来限制显示长度
function this:SetStringByChats(str, len, replace)
    if not str or type(str) ~= "string" or #str <= 0 then
        return ""
    end
    local chars = {}
    local length = 0
    local i = 1
    while (true) do
        local curByte = string.byte(str, i)
        local byteCount = 1
        if (curByte > 239) then
            byteCount = 4
        elseif (curByte > 223) then
            byteCount = 3
        elseif (curByte > 128) then
            byteCount = 2
        else
            byteCount = 1
        end
        length = length + byteCount
        if (length > len) then
            length = length - byteCount
            break
        end
        local char = string.sub(str, i, i + byteCount - 1)
        table.insert(chars, char)
        i = i + byteCount
        if i > #str then
            break
        end
    end
    local newStr = table.concat(chars)
    if (length > len) then
        replace = replace == nil and "..." or replace
    else
        replace = ""
    end
    return newStr .. replace
end

-- 根据分辨率对字符串分行
function this:SetStringByWidth(inputStr, size, width)
    if not inputStr or type(inputStr) ~= "string" or #inputStr <= 0 then
        return ""
    end

end

-- 替换字符串 
function this:StrReplace(sourceStr, old, new, count)
    if (self:IsEmpty(sourceStr)) then
        return ""
    end
    count = count or 1
    return string.gsub(sourceStr, old, new, count)
end

-- 解决空格换行问题，count：替换几次
function this:ReplaceSpace(sourceStr, count)
    if (self:IsEmpty(sourceStr)) then
        return ""
    end
    return self:StrReplace(sourceStr, " ", "<color=#00000000>.</color>", count)
end

-- 将字符串切割成长度一致的若干个字符串 disRichText：为true时去掉富文本标签
function this:SubStrByLength(str, length, disRichText)
    local ret = {};
    if disRichText then
        str = string.gsub(str, "(<[%p%w]->)", "");
    end
    length = length * 3;
    local strs = self:split(str, "\n");
    for _, _str in ipairs(strs) do
        if #_str > length then
            local s = {};
            local index = 1;
            local currNum = 0;
            while (index <= #_str) do
                local curByte = string.byte(_str, index)
                local byteCount = 1;
                if curByte < 192 then
                    byteCount = 1
                elseif curByte < 224 then
                    byteCount = 2
                elseif curByte < 240 then
                    byteCount = 3
                elseif curByte < 248 then
                    byteCount = 4
                elseif curByte < 252 then
                    byteCount = 5
                end
                if currNum + byteCount > length then
                    table.insert(ret, table.concat(s));
                    s = {};
                    local _s = string.sub(_str, index, index + byteCount - 1);
                    table.insert(s, _s);
                    currNum = 0;
                elseif currNum + byteCount == length or index + byteCount - 1 == #_str then
                    local _s = string.sub(_str, index, index + byteCount - 1);
                    table.insert(s, _s);
                    table.insert(ret, table.concat(s));
                    s = {};
                    currNum = 0;
                else
                    local _s = string.sub(_str, index, index + byteCount - 1);
                    table.insert(s, _s);
                end
                index = index + byteCount;
                currNum = currNum + byteCount;
            end
        else
            table.insert(ret, _str);
        end
    end
    return ret;
end

-- 获取字符串中的中英文和数字
function this:FilterChar(s)
    if CSAPI.IsADV() then
        return self:FilterChar2(s);
    else
        local ss = {}
        local k = 1
        while true do
            if k > #s then
                break
            end
            local c = string.byte(s, k)
            if not c then
                break
            end
            if c < 192 then
                if (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122) then
                    table.insert(ss, string.char(c))
                end
                k = k + 1
            elseif c < 224 then
                k = k + 2
            elseif c < 240 then
                if c >= 228 and c <= 233 then
                    local c1 = string.byte(s, k + 1)
                    local c2 = string.byte(s, k + 2)
                    if c1 and c2 then
                        local a1, a2, a3, a4 = 128, 191, 128, 191
                        if c == 228 then
                            a1 = 184
                        elseif c == 233 then
                            a2, a4 = 190, c1 ~= 190 and 191 or 165
                        end
                        if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
                            table.insert(ss, string.char(c, c1, c2))
                        end
                    end
                end
                k = k + 3
            elseif c < 248 then
                k = k + 4
            elseif c < 252 then
                k = k + 5
            elseif c < 254 then
                k = k + 6
            end
        end
        return table.concat(ss)
    end
end

-- 获取字符串中的简体中文(不含标点符号)
function this:GetSimplifiedChinese(s)
    local ss = {}
    for k = 1, #s do
        local c = string.byte(s, k)
        if not c then
            break
        end
        if c >= 228 and c <= 233 then -- 匹配中文
            local c1 = string.byte(s, k + 1)
            local c2 = string.byte(s, k + 2)
            if c1 and c2 then
                local a1, a2, a3, a4 = 128, 191, 128, 191
                if c == 228 then
                    a1 = 184
                elseif c == 233 then
                    a2, a4 = 190, 165
                end
                if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
                    k = k + 2
                    table.insert(ss, string.char(c, c1, c2))
                end
            end
        end
    end
    return table.concat(ss)
end

-- 返回替换后的技能描述字符串和特效配置信息
function this:SkillDescFormat(str)
    local tempStr = str;
    local cfgs = {};
    -- for s in string.gmatch(str, "<skillEff=[^%p%c]->") do --非标点和控制符匹配
    if str == nil or str == "" then
        return tempStr, cfgs;
    end
    for s in string.gmatch(str, "<skillEff=[^%c]->") do -- 非控制符匹配
        local param = {}
        string.gsub(s, "[^<=>']+", function(w)
            table.insert(param, w);
        end);
        if param ~= nil and param[1] == "skillEff" and param[2] then
            local cfg = Cfgs.SkillEffDesc:GetByKey(param[2]);
            if cfg then
                local colorCfg = Cfgs.CfgUIColorEnum:GetByID(cfg.color);
                local name = string.format("<color=%s>%s</color>", colorCfg and colorCfg.sCode or "FFFFFF", cfg.sName);
                tempStr = string.gsub(tempStr, "<skillEff=[^%c]->", name, 1);
                local isHas = false;
                for k, v in ipairs(cfgs) do
                    if v.id == cfg.id then
                        isHas = true;
                        break
                    end
                end
                if isHas == false then
                    table.insert(cfgs, cfg);
                end
            end
        end
    end
    return tempStr, cfgs;
end

-- 判断字符所占字节数
function this:ByteNumber(coding)
    if 127 >= coding then
        return 1
    elseif coding < 192 then
        return 0
    elseif coding < 224 then
        return 2
    elseif coding < 240 then
        return 3
    elseif coding < 248 then
        return 4
    elseif coding < 252 then
        return 5
    else
        return 6
    end
end

-- 获取字符串长度
function this:Utf8Len(s)
    if s ~= nil then
        if tostring(type(s)) == "string" then
            local index = 0
            for i = 1, #s do
                local coding = string.byte(s, i)
                if coding >= 128 and coding < 192 then
                else
                    index = index + 1
                end
            end
            return index
        end
    else
        return nil
    end
end

-- 截取从n到le的字符串
function this:Utf8Sub(s, n, le)
    if s ~= nil then
        if tostring(type(s)) == "string" then
            if n == nil then
                n = 1
            else
                if tostring(type(n)) ~= "number" or n < 1 then
                    n = 1
                end
            end
            if le == nil then
                le = 1
            else
                if tostring(type(le)) ~= "number" or le < 1 then
                    le = 1
                end
            end
            local index = 0
            local startIndex = 0
            local endIndex = 0
            for i = 1, #s do

                local coding = string.byte(s, i)
                if coding >= 128 and coding < 192 then
                else
                    index = index + 1
                    if index == n then
                        startIndex = i
                    end
                    if index == le then
                        endIndex = i + self:ByteNumber(coding) - 1
                    end

                end
            end
            return string.sub(s, startIndex, endIndex)
        end
    else
        return nil
    end
end

-- 返回unicode字节码之和
function this:GetUnicodeNum(str)
    local num = 0;
    if str then
        for i = 1, #str do
            local coding = string.byte(str, i)
            num = num + coding;
        end
    end
    return num;
end

-- 取数字 
function this:GetStrNum(str)
    local num = str:gsub("%D+", "")
    if (not self:IsEmpty(num)) then
        num = tonumber(num)
    end
    return num
end

function this:ContainStr(str, char)
    if string.find(str, char) then
        return true
    end
    return false
end

-- 返回大于10w的数量的短描述
function this:GetShortNumStr(num)
    if num and type(num) == "number" then
        local str=tostring(num);
        for k, v in ipairs(Cfgs.CfgNumConvert:GetAll()) do
            if num>=v.num then
                str=string.format("%s%s",math.floor(num/v.unit),v.showStr);
            end
        end
        return str;
    else
        return tostring(num);
    end
end

local hzUnit = {"十", "百", "千", "万", "亿"}
local hzNum = {"一", "二", "三", "四", "五", "六", "七", "八", "九"}
local hzZero = {"零"}
-- 数字转中文
function this:NumberToString(szNum)
    local iLen = 0
    local str = ''

    if nil == tonumber(szNum) then
        return tostring(szNum)
    end

    iLen = string.len(szNum)
    -- 0~9
    if iLen == 1 then
        if szNum == 0 then
            str = hzZero[1]
        elseif szNum > 0 then
            str = hzNum[szNum]
        end
    end

    -- 10~99
    if iLen == 2 then
        iNum = tonumber(string.sub(szNum, 1, 1))
        iNum2 = tonumber(string.sub(szNum, 2, 2))
        if iNum == 1 then
            if iNum2 == 0 then
                str = hzUnit[1]
            elseif iNum2 > 0 then
                str = hzUnit[1] .. hzNum[iNum2]
            end
        elseif iNum >= 2 and iNum <= 9 then
            if iNum2 == 0 then
                str = hzNum[iNum] .. hzUnit[1]
            elseif iNum2 > 0 then
                str = hzNum[iNum] .. hzUnit[1] .. hzNum[iNum2]
            end
        end
    end

    -- 100~999
    if iLen == 3 then
        iNum = tonumber(string.sub(szNum, 1, 1))
        iNum2 = tonumber(string.sub(szNum, 2, 2))
        iNum3 = tonumber(string.sub(szNum, 3, 3))
        if iNum2 == 0 and iNum3 == 0 then -- 100,200,...900
            str = hzNum[iNum] .. hzUnit[2]
        elseif iNum2 == 0 then
            str = hzNum[iNum] .. hzUnit[2] .. hzZero[1] .. hzNum[iNum3]
        elseif iNum2 >= 0 and iNum3 == 0 then
            str = hzNum[iNum] .. hzUnit[2] .. hzNum[iNum2] .. hzUnit[1]
        elseif iNum2 >= 0 and iNum3 > 0 then
            str = hzNum[iNum] .. hzUnit[2] .. hzNum[iNum2] .. hzUnit[1] .. hzNum[iNum3]
        end
    end
    -- 1000~9999
    if iLen == 4 then
        iNum = tonumber(string.sub(szNum, 1, 1))
        iNum2 = tonumber(string.sub(szNum, 2, 2))
        iNum3 = tonumber(string.sub(szNum, 3, 3))
        iNum4 = tonumber(string.sub(szNum, 4, 4))
        if iNum2 == 0 and iNum3 == 0 and iNum4 == 0 then -- 1000,2000,...9000
            str = hzNum[iNum] .. hzUnit[3]
        elseif iNum2 == 0 and iNum3 == 0 then -- 1001 ... 1009
            str = hzNum[iNum] .. hzUnit[3] .. hzZero[1] .. hzNum[iNum4]
        elseif iNum2 == 0 and iNum3 > 0 then -- 1010 ...1099
            if iNum4 == 0 then
                str = hzNum[iNum] .. hzUnit[3] .. hzZero[1] .. hzNum[iNum3] .. hzUnit[1]
            else
                str = hzNum[iNum] .. hzUnit[3] .. hzZero[1] .. hzNum[iNum3] .. hzUnit[1] .. hzNum[iNum4]
            end
        elseif iNum2 > 0 and iNum3 == 0 and iNum4 == 0 then -- 1100
            str = hzNum[iNum] .. hzUnit[3] .. hzNum[iNum2] .. hzUnit[2]
        elseif iNum2 > 0 and iNum3 == 0 and iNum4 > 0 then -- 1101 .. 1109
            str = hzNum[iNum] .. hzUnit[3] .. hzNum[iNum2] .. hzUnit[2] .. hzZero[1] .. hzNum[iNum4]
        elseif iNum2 > 0 and iNum3 > 0 and iNum4 == 0 then -- 1110 ..
            str = hzNum[iNum] .. hzUnit[3] .. hzNum[iNum2] .. hzUnit[2] .. hzNum[iNum3] .. hzUnit[1]
        elseif iNum2 > 0 and iNum3 > 0 and iNum4 > 0 then -- 1111 ..
            str = hzNum[iNum] .. hzUnit[3] .. hzNum[iNum2] .. hzUnit[2] .. hzNum[iNum3] .. hzUnit[1] .. hzNum[iNum4]
        end
    end
    return str
end

-- 替换字符串中不定的%s，replacements为table
function this:ReplacePlaceholders(str, replacements)
    return str:gsub("%%s", function()
        local value = replacements[1]
        table.remove(replacements, 1)
        return tostring(value)
    end)
end

---首行缩进 
---@param str 文本
---@param isLine 包含换行
function this:IndentFirstLine(str, isLine)
    if str and str ~= "" then
        str = "\u{3000}\u{3000}" .. str
        if isLine then
            str = str:gsub("\n", "\n\u{3000}\u{3000}")
        end
    end
    return str
end

--- 替换空格为不换行空格(解决Text组件英文分词问题)
---@param str 文本
function this:ReplaceSpace(str)
    if str and str ~= "" then
        str = str:gsub(" ", "\u{00A0}")
    end
    return str
end

-- 只包含中文、繁体中文、注音、日文、韩文、英文和数字
function this:CheckPassStr(str)
    local pattern =
        "^[\u{4e00}-\u{9fff}\u{3400}-\u{4dbf}\u{3040}-\u{309f}\u{ac00}-\u{d7af}\z{IsHiragana}\z{IsKatakana}a-zA-Z0-9]*$"
    return string.match(str, pattern)
end

-- 匹配非特殊字符的文本 --支持空格 
local regex = CS.System.Text.RegularExpressions.Regex("[^\\p{L}\\p{N}\\s+]+")
local regex2 = CS.System.Text.RegularExpressions.Regex("[\\r?\\n|\\r\\t+]+")
function this:FilterChar2(str)
    local result = ""
    if str ~= "" and str ~= nil then
        result = regex:Replace(str, "");
        result = regex2:Replace(result, "") -- 剔除tab
        -- result = result:gsub("^%s*(.-)%s*$", "%1") --去掉前后空格
    end
    return result;
end

-- 根据数字获取罗马数字
function this:IntToRoman(num)
    if num <= 0 or num >= 4000 then
        return "Invalid number"
    end

    local romanNumeral = ""
    local romanNumerals = {{1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"}, {100, "C"}, {90, "XC"}, {50, "L"},
                           {40, "XL"}, {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}}

    for _, v in ipairs(romanNumerals) do
        while num >= v[1] do
            romanNumeral = romanNumeral .. v[2]
            num = num - v[1]
        end
    end

    return romanNumeral
end

local units = {"ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE"}
local teens = {"TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN",
               "NINETEEN"}
local tens = {"", "TEN", "TWENTY", "THIRTY", "FORTY", "FIFTY", "SIXTY", "SEVENTY", "EIGHTY", "NINETY"}

-- 数字转英文单词 --只支持1000以下
function this:NumberToWords(num)
    if num < 10 then
        return units[num + 1] -- Lua数组从1开始
    elseif num < 20 then
        return teens[num - 10 + 1]
    elseif num < 100 then
        local ten = math.floor(num / 10)
        local unit = num % 10
        if unit == 0 then
            return tens[ten + 1]
        else
            return tens[ten + 1] .. "-" .. units[unit + 1]
        end
    elseif num < 1000 then
        local hundred = math.floor(num / 100)
        local remainder = num % 100
        if remainder == 0 then
            return units[hundred + 1] .. " hundred"
        else
            return units[hundred + 1] .. " hundred and " .. NumberToWords(remainder)
        end
    else
        return "number too large"
    end
end

-- 返回固定位数的数字文本，max：最大位数
function this:GetScoreNumStr(num, max)
    if not num or not (type(num) == "number") or not max or not (type(max) == "number") then
        return
    end
    local cur = 0
    local count = 1
    if num > 0 then
        for i = 1, max do
            if num >= count then
                count = count * 10
                cur = cur + 1
            else
                break
            end
        end
    end
    local zeroStr = ""
    if max > cur then
        for i = 1, max - cur do
            zeroStr = zeroStr .. "0"
        end
    end
    return zeroStr .. num
end

-- 拆分整数为数字数组 12345 -> {1,2,3,4,5}
function this:SplitNumber(num)
    local arr = {}
    if num == 0 then
        table.insert(arr, 0)
        return arr
    end
    
    -- 从低位往高位取
    while num > 0 do
        table.insert(arr, 1, num % 10)
        num = math.floor(num / 10)
    end
    return arr
end

return this;
