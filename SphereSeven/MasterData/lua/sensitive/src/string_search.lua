LibBan = require "Sensitive.test/ban"
StringUtil = {}
local function chsize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end
function StringUtil.utf8len( str )
    local len = 0
    local current = 1
    while current <= #str do
        local char = string.byte(str,currentIndex)
        current = current + chsize(char)
        len = len + 1
    end
    return len
end

function StringUtil.utf8sub(str,startChar,numChars)
    local startIndex = 1
    while startChar > 1 do
        local char = string.byte(str,startIndex)
        startIndex = startIndex + chsize(char)
        startChar = startChar - 1
    end

    local currentIndex = startIndex

    while numChars > 0 and currentIndex <= #str do
        local char = string.byte(str,currentIndex)
        currentIndex = currentIndex + chsize(char)
        numChars = numChars - 1
    end
    return str:sub(startIndex,currentIndex - 1)
end
function StringUtil.Split(str , strSplit)
    local tSplitStr = {}
    while true do
        local i  = string.find(str,strSplit)
        --字符串中没有找到切分的字符，直接返回原字符串
        if nil == i then
            tSplit[#tSplit + 1] = str
        end

        local subStr = string.sub(str,1,i - 1)
        tSplitStr[#tSplitStr + 1] = subStr
        str = string.sub(str,i + 1,#str)
    end
    return tSplitStr
end
function StringUtil.IsContainEmoji(str)
    local len = string.len(str)--得到的是字符占的字节数（有可能不是字符的个数）
    for i = 1,len do
        local char = string.byte(str,i)
        local size = chsize(char)
        i = i + size - 1
        if not((char == 0x00) or (char == 0x9) or
                (char == 0xA) or (char == 0xD) or
                ((char >= 0x20) and (char <= oxD7FF)) or
                ((char >= 0xE000) and (char <= 0xFFFD)) or
                ((char >= 0x10000) and (char <= 0x10FFFF))) then
            return true
        end
    end
    return false
end
function StringUtil.Contains(str, target)
    return nil ~= string.find(str,target)
end
--内部方法------------------
local function InitWordMap()
    local map ={}
    map.isLast = false
    map.map = {}
    return map
end
local ban ---默认只用一个词库，到时有分词库再说
local checkBan=function()
    if ban== nil then
        ban={}
        for i = 1,#LibBan  do
            local sban={}
            table.insert(ban,sban)
            local str = string.split(LibBan[i],',')
            for j = 1, #str do
                local wordItem = str[j]
                if wordItem ~= "" then
                    table.insert(sban,wordItem)
                end
            end
        end
    end
    return ban
end
--添加单个字符到过滤词树的结构中
local function  AddWordsChar(wordMap , word , charIdIndex)
    local map = wordMap.map
    local singleChar = StringUtil.utf8sub(word,charIdIndex , 1)
    local subWordMap = map[singleChar]
    if subWordMap  == nil then
        subWordMap = InitWordMap()
        map[singleChar] = subWordMap
    end
    --单个词条是最后一个字符，则是叶子节点
    local len = StringUtil.utf8len(word)
    if charIdIndex ==len  then
        subWordMap.isLast = true
    end
    if charIdIndex < len then
        AddWordsChar(subWordMap,word,charIdIndex + 1)
    end
end
--判断一个字符串是否有过滤词存在，并同时返回过滤词的字符个数
local function CheckWord(wordMap , word , beginIndex , filterCount)
    local map = wordMap.map
    local singleChar = StringUtil.utf8sub(word,beginIndex,1)
    if map[singleChar] ~= nil then
        filterCount = filterCount + 1
        if map[singleChar].isLast then
            return true,filterCount
        else
            if beginIndex > StringUtil.utf8len(word) then
                return false , 0
            else
                return CheckWord(map[singleChar],word,beginIndex + 1,filterCount)
            end
        end
    end
    return false,0
end
--主接口类
local StringSearch = {}
--根据过滤词库来初始化过滤词库群树结构
function StringSearch:InitWordFilter()
    if  self.wordMap==nil then
        local tb = checkBan()
        self.wordMap = InitWordMap()
        for i = 1,#tb  do
             for j = 1, #tb[i] do
                local wordItem = tb[i][j]
                if wordItem ~= "" then
                    AddWordsChar(self.wordMap , wordItem , 1)
                end
            end
        end
    end
end
--国为树结构产生非常多的对象 GC时会遍历这些对象，会卡，但是又不会回收，所以每次都会卡。这里丢掉引用让它回收。怎么让对象GC时不参加遍历，还要研究
function StringSearch:DisposeFilter()
    if  self.wordMap ~=nil then
        self.wordMap=nil
    end
end
----------------主要使用下面两个方法上面的都不要用
-- 判断一个字符串是否有过滤词存在
function StringSearch:IsContains(str)
    self:InitWordFilter()
    local len = StringUtil.utf8len(str)
    for i = 1,len do
        if CheckWord(self.wordMap,str,i,0) then
            return true
        end
    end
    self:DisposeFilter()
    return false
end
-- 将给过来的字符串中的所有的过滤词改为"***"
function StringSearch:Filter(str)
   local len = StringUtil.utf8len(str)
    for i=1,len,1  do
        local isFilter,filterCount = CheckWord(self.wordMap,str,i,0)
        if isFilter then
            local filterWord = ""
            for n = 1,filterCount do
                filterWord = filterWord .. "*"
            end
            str = string.gsub(str,StringUtil.utf8sub(str,i,filterCount),filterWord)
            i = i + filterCount - 1
        end
    end
    return str
end
return StringSearch