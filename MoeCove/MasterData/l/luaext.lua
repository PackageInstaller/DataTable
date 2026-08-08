-- lua扩展

if not osx then
    osx = {}
end

--local binaryFormat
--local system = io.popen("uname -s"):read("*l")
--if system == "Darwin" then
--    binaryFormat = "dylib"
--    osx.isMac = true
--    function osx.name()
--        return "MacOS"
--    end
--elseif system == "Linux" then
--    osx.isLinux = true
--    binaryFormat = "so"
--    function osx.name()
--        return "Linux"
--    end
--else
--    osx.isWin = true
--    binaryFormat = "dll"
--    function osx.name()
--        return "Windows"
--    end
--end

local binaryFormat = package.cpath:match("[\\|/]%?%.(%a+)")
if binaryFormat == "dll" then
    function osx.name()
        return "Windows"
    end
    osx.isWin = true
elseif binaryFormat == "so" then
    local system = ""
    if (GV and GV.IsServer) or (UnityEngine.Application.platform ~= UnityEngine.RuntimePlatform.WebGLPlayer and
       UnityEngine.Application.platform ~= UnityEngine.RuntimePlatform.OSXEditor) then
        system = io.popen("uname -s"):read("*l")
    end
    if system == "Darwin" then
        function osx.name()
            return "MacOS"
        end
        osx.isMac = true
    elseif system == "Linux" then
        function osx.name()
            return "Linux"
        end
        osx.isLinux = true
    end
elseif binaryFormat == "dylib" then
    function osx.name()
        return "MacOS"
    end
    osx.isMac = true
end

osx.binaryFormat = binaryFormat


-- 文件操作相关函数
filex = {}

-- table扩展
tablex = {}

-- 所有其他函数都放这里
luautil = {}

-- sql相关函数
sqlutil = {}

-- 返回table大小
tablex.size = function(t)
    if not t then
        return 0
    end

	local count = 0
	for _ in pairs(t) do
		count = count + 1
	end
	return count
end

tablex.next = function(t)
    if not t then
        return nil
    end
    for k, v in pairs(t) do
		return k, v
	end
    return nil
end

-- 返回table 索引大小（有时候因为用的proxy，无法直接通过#获得大小）
tablex.isize = function(t)
    if not t then
        return 0
    end

    local count = 0
    for _ in ipairs(t) do
        count = count + 1
    end
    return count
end

-- 判断table是否为空
tablex.empty = function(t)
    if not t then
        return true
    end

    -- 这是一个很有风险的改动，但不这么改，很多服务端因为用了metatable自动修改同步数据的table不能正确判断
    local isEmpty = not next(t)
    if isEmpty then
        local meta = getmetatable(t)
        if meta and meta.__index and type(meta.__index) == "table" then
            return not next(meta.__index)
        end
    end

    return isEmpty
end

-- 返回table索引列表
tablex.indices = function(t)
    local result = {}
    for k, v in pairs(t) do
        table.insert(result, k)
    end

    return result
end

-- 返回table值列表
tablex.values = function(t)
    local result = {}
    for k, v in pairs(t) do
        table.insert(result, v)
    end

    return result
end

-- 浅拷贝
---@generic T
---@param t T
---@param nometa boolean?
---@return T
tablex.clone = function(t, nometa)
    if not t then
        LuaLogger.es("not t")
        return {}
    end
    local result = {}
    if not nometa then
        setmetatable(result, getmetatable(t))
    end
    for k, v in pairs (t) do
        result[k] = v
    end
    return result
end

-- 深拷贝
---@generic T:table
---@param t T
---@param nometa boolean?
---@return T
tablex.copy = function(t, nometa)   
    local result = {}
    if not t then
        LuaLogger.es("tablex.copy nil table")
        return result
    end

    if not nometa then
        setmetatable(result, getmetatable(t))
    end

    for k, v in pairs(t) do
        if type(v) == "table" then
            result[k] = tablex.copy(v)
        else
            result[k] = v
        end
    end
    return result
end

-- 查找并插入元素
---@param tbl table
---@param element any
function tablex.findInsert(tbl, element)
    for _, value in ipairs(tbl) do
        if value == element then
            return
        end
    end
    table.insert(tbl, element)
end

tablex.merge = function(dest, src)
    for k, v in pairs(src) do
        dest[k] = v
    end
end

tablex.mergeArray = function(dest, src)
    for k, v in ipairs(src) do
        table.insert(dest, v)
    end
end

-- 衔接
---@generic T:table
---@param tb1 T
---@param tb2 T
---@return T
tablex.combine = function (tb1, tb2)
    local new_tb = {}
    local listIndex = 1
    if tb1 then
        for _, v in pairs(tb1) do
            new_tb[listIndex] = v
            listIndex = listIndex + 1
            -- table.insert(new_tb, v)
        end
    end
    if tb2 then
        for _, v in pairs(tb2) do
            new_tb[listIndex] = v
            listIndex = listIndex + 1
            -- table.insert(new_tb, v)
        end
    end
    return new_tb
end

-- ipairs衔接
---@generic T:table
---@param tb1 T
---@param tb2 T
---@return T
tablex.icombine = function (tb1, tb2)
    local new_tb = {}
    local listIndex = 1
    if tb1 then
        for _, v in ipairs(tb1) do
            new_tb[listIndex] = v
            listIndex = listIndex + 1
        end
    end
    if tb2 then
        for _, v in ipairs(tb2) do
            new_tb[listIndex] = v
            listIndex = listIndex + 1
        end
    end
    return new_tb
end

-- 分组
tablex.groupby = function (tb, key_cor)
    local new_tb = {}
    for _, v in pairs(tb) do
        local key = key_cor(v)
        if (not new_tb[key]) then
            new_tb[key] = {}
        end
        table.insert(new_tb[key], v)
    end
    return new_tb
end

-- 条件判断
tablex.any = function (tb, condition)
    if (condition == nil) then
        condition = true
    end
    for _, v in pairs(tb) do
        if (condition == true or condition(v)) then
            return true
        end
    end
    return false
end

-- 筛选
tablex.where = function (tb, condition)
    local new_tb = {}
    for _, v in pairs(tb) do
        if (condition(v)) then
            table.insert(new_tb, v)
        end
    end
    return new_tb
end

-- 条件判断全部
tablex.all = function (tb, condition)
    local match = true
    for _, v in pairs(tb) do
        if (not condition(v)) then
            match = false
        end
    end
    return match
end

---选择
---@param tb table
---@param select_value any
---@return table
tablex.select = function (tb, select_value)
    local new_tb = {}
    for _, v in pairs(tb) do
        local value = select_value(v)
        if (value) then
            table.insert(new_tb, value)
        end
    end
    return new_tb
end

-- 首位
tablex.first = function (tb, condition)
    if (condition == nil) then
        condition = true
    end
    for _, v in pairs(tb) do
        if (condition == true or condition(v)) then
            return v
        end
    end
    return nil
end

-- 最大
tablex.max = function (tb, param)
    local max = nil
    for _, v in pairs(tb) do
        local _param = param(v)
        if (max == nil) then
            max = _param
        else
            max = _param > max and _param or max
        end
    end
    return max
end

-- 最小
tablex.min = function (tb, param)
    local min = nil
    for _, v in pairs(tb) do
        local _param = param(v)
        if (min == nil) then
            min = _param
        else
            min = _param < min and _param or min
        end
    end
    return min
end

-- 相加
tablex.sum = function (tb, param)
    local sum = 0
    for _, v in pairs(tb) do
        local _param = param(v)
        sum = sum + _param
    end
    return sum
end

-- 判断表是否相等
tablex.equals = function (tb1, tb2)
    if (tablex.size(tb1) == tablex.size(tb2)) then
        for k, v in pairs(tb1) do
            if (not tb2[k] or v ~= tb2[k]) then
                return false
            end
        end
        return true
    end
    return false
end

-- 判断数组是否相等
tablex.arrayEquals = function (array1, array2)
    if (#array1 == #array2) then
        for k, v in ipairs(array1) do
            if (v ~= array2[k]) then
                return false
            end
        end
        return true
    end
    return false
end


---@generic T
---@param tb T[]
---@return T[]
function tablex.insertproxy(tb, v1, v2)
    local meta = getmetatable(tb)
    if meta and meta.__index and type(meta.__index) == "table" then
        local markDirty = meta.markDirty
        if markDirty then
            markDirty(meta.name, meta.firstKey)
        end
        if v2 then
            table.insert(meta.__index, v1, v2)
        else
            local len = tablex.size(meta.__index)
            tb[len+1] = v1
        end
    else
        if v2 then
            table.insert(tb, v1, v2)
        else
            table.insert(tb, v1)
        end
    end
end

---@param tb table
---@param idx integer
function tablex.removeproxy(tb, idx)
    local meta = getmetatable(tb)
    if meta and meta.__index and type(meta.__index) == "table" then
        table.remove(meta.__index, idx)
        local markDirty = meta.markDirty
        if markDirty then
            markDirty(meta.name, meta.firstKey)
        end
        return
    end

    table.remove(tb, idx)
end

function tablex.insertrange(tb, idx, values)
    if not values then
        values = idx
        idx = #tb + 1
    end

    if not values then
        return
    end

    for i,v in ipairs(values) do
        table.insert(tb, idx, v)
        idx = idx + 1
    end

    return tb
end

function tablex.removerange(tb, beg, last)
    local tbLen = #tb
    last = last or tbLen

    local cnt = last - beg + 1

    for i = 1, cnt do
        table.remove(tb, beg)
    end

    return tb
end

---@generic T:table
---@generic V
---@param tb T
---@param sort? fun(a:V, b:V):boolean
---@param filter? fun(V,...):boolean
---@return T
function tablex.toarray(tb, sort, filter, ...)
    local array = {}
    for k,v in pairs(tb) do
        if not filter or filter(v, ...) then
            table.insert(array, v)
        end
    end

    if sort then
        if isfunction(sort) then
            table.sort(array, sort)
        else
            table.sort(array)
        end 
    end

    return array
end

function tablex.toKeyArray(tb, sort, filter)
    local array = {}
    for k,v in pairs(tb) do
        if not filter or filter(k) then
            table.insert(array, k)
        end
    end

    if sort then
        if isfunction(sort) then
            table.sort(array, sort)
        else
            table.sort(array)
        end 
    end

    return array
end

function tablex.toKeyValueArray(tb, sort, filter)
    local array = {}
    for k,v in pairs(tb) do
        if not filter or filter(v) then
            table.insert(array, {key = k, value = v})
        end
    end

    if sort then
        if isfunction(sort) then
            table.sort(array, sort)
        else
            table.sort(array, function (a, b)
                return a.value < b.value
            end)
        end 
    end

    return array
end

function tablex.getOrAddTable(tb, key)
    local newTb = tb[key]
    if not newTb then
        newTb = {}
        tb[key] = newTb
    end

    return newTb
end

function tablex.setOrAddValue(tb, key, value)
    local oldValue = tb[key]
    local nowValue
    if oldValue then
        nowValue = oldValue + value
        tb[key] = nowValue
    else
        nowValue = value
        tb[key] = value
    end

    return nowValue
end

function tablex.insertKeyData(tb, key, data)
    local exist = tb[key]
    if not exist then
        exist = {}
        tb[key] = exist
    end

    table.insert(exist, data)
end

function tablex.reverse(tb)
    local array = {}
    for i,v in ipairs(tb) do
        table.insert(array, 1, v)
    end
    return array
end

function tablex.find(tb, e)
    for i,v in ipairs(tb) do
        if v == e then
            return true
        end
    end

    return false
end

function tablex.findMatch(tb, matchFunc, limitNum)
    local matches
    for i,v in ipairs(tb) do
        if matchFunc(v) then
            if not matches then
                matches = {}
            end

            table.insert(matches, v)

            if limitNum and #matches >= limitNum then
                break
            end
        end
    end

    return matches
end
---@generic T
---@param tb T[]
---@param matchFunc function(T):boolean
---@return T?
function tablex.findSingle(tb, matchFunc)
    for i,v in ipairs(tb) do
        if matchFunc(v) then
            return v
        end
    end

    return nil
end

function tablex.isArray(tb)
    return tablex.size(tb) == #tb
end

function tablex.copyTo(src, dest, exceptKeys, func)
    for k,v in pairs(src) do
        if (not func or func(k, v)) and (not exceptKeys or not tablex.find(exceptKeys, k)) then
            dest[k] = v
        end
    end

    return dest
end

function tablex.copyToByKey(src, dest, keys, func)
    for i, v in ipairs(keys) do
        if not func or func(v) then
            local value = src[v]
            if value then
                local meta = getmetatable(value)
                if meta and meta.__index then
                    dest[v] = clone(value)
                else
                    dest[v] = value
                end
            end
        end
    end

    return dest
end

function tablex.bbsort(tb, cmp)
    local cnt = #tb
    for i = 1, cnt - 1 do
        for j = 1, cnt - i do
            if cmp(tb[j + 1], tb[j]) then
                tb[j], tb[j + 1] = tb[j + 1], tb[j]
            end
        end
    end
end

function tablex.aremoveif(tb, func, ret)
    local tb2
    if ret then
        tb2 = {}
    end

    for i = #tb, 1, -1 do
        local ele = tb[i]
        if func(ele) then
            table.remove(tb, i)
            if tb2 then
                table.insert(tb2, ele)
            end
        end
    end

    if tb2 then
        local i, j = 1, #tb2
        while i < j do
            tb2[i], tb2[j] = tb2[j], tb2[i]
            i = i + 1
            j = j - 1
        end
    end

    return tb2
end

function tablex.aremoveObj(tb, obj)
    for i, v in ipairs(tb) do
        if v == obj then
            table.remove(tb, i)
            return true
        end
    end

    return false
end

function tablex.combineListByKey(src, dest, key, matchFunc)
    local tb = {}
    for i,v in ipairs(dest) do
        tb[v[key]] = v
    end

    for i,v in ipairs(src) do
        local keyData = v[key]
        local data = tb[keyData]
        if not matchFunc or matchFunc(keyData) then
            tablex.copyTo(v, data)
        end
    end

    return dest
end

function tablex.autoMark(instance, name, firstKey, level, storeMap, markFunc, levelLimit, allowRepeatMark)
    level = level or 0

    if name and storeMap and not storeMap[name] then
        return instance
    end

    if levelLimit and level >= levelLimit then
        return instance
    end

    local mt = {

        __index = instance,
        __newindex = function(tb, key, value)
            --LuaLogger.ws("---autoMark",instance, name, key, value, instance[key], level)
            if instance[key] ~= value or allowRepeatMark then
                if level == 0 then
                    markFunc(key, nil)
                elseif level == 1 then
                    markFunc(name, key)
                else
                    markFunc(name, firstKey)
                end
            end

            if type(value) == "table" then
                if instance[key] ~= value then
                    if level == 0 then
                        rawset(instance, key, tablex.autoMark(value, key, nil, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark))
                    elseif level == 1 then
                        rawset(instance, key, tablex.autoMark(value, name, key, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark))
                    else
                        rawset(instance, key, tablex.autoMark(value, name, firstKey, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark))
                    end
                end
            else
                rawset(instance, key, value)
            end
        end,

        -- tablex.removeproxy需要用到
        -- __metatable = false,

        __pairs = function()
            return next, instance, nil
        end,

        markDirty = function (key, value)
            markFunc(key, value)
        end,

        name = name,
        firstKey = firstKey,
    }

    -- setmetatable(instance, mt)
    local newTb = {}
    for k,v in pairs(instance) do
        if type(v) == "table" then
            if level == 0 then
                instance[k] = tablex.autoMark(v, k, nil, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark)
            elseif level == 1 then
                instance[k] = tablex.autoMark(v, name, k, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark)
            else
                instance[k] = tablex.autoMark(v, name, firstKey, level + 1, storeMap, markFunc, levelLimit, allowRepeatMark)
            end
        end
    end

    return setmetatable(newTb, mt)
end

--判断table中是否存在元素
---@param tb table
---@param element any
---@return boolean
function tablex.contains(tb, element)
    for i, v in pairs(tb) do
        if v == element then
            return true
        end
    end

    return false
end

--去重
---@generic T:table
---@param tb T
---@return T
function tablex.distinct(tb)
    local new_tb = {}
    for i, v in pairs(tb) do
        new_tb[v] = i
    end
    return tablex.indices(new_tb)
end

function tablex.indexof(tb, v)
    for index, value in ipairs(tb) do
        if v == value then
            return index
        end
    end
    return -1
end

--切片
---@generic T:table
---@param tb T
---@param start integer
---@param stop integer
function tablex.slice(tb, start, stop)
    local new_tb = {}
    for i = start, stop do
        table.insert(new_tb, tb[i])
    end
    return new_tb
end

---@param a1 table
---@param f integer
---@param e integer
---@param t integer
---@param a2 table
---@return table
function tablex.move(a1, f, e, t, a2)
    for i = f, e do
        a2[t + i - f] = a1[i]
    end
    return a2
end

-- local unitExpand = {"uid","index","camp"}
-- local rule = {
--     notExpandKeys = {},
--     expand = {
--         actor = unitExpand,
--         centerUnit = unitExpand,
--         targetUnit = unitExpand,
--     }
-- }

-- function dump(obj)
--     local getIndent, quoteStr, wrapKey, wrapVal, dumpObj
--     getIndent = function(level)
--         return string.rep("\t", level)
--     end
--     quoteStr = function(str)
--         return '"' .. string.gsub(str, '"', '\\"') .. '"'
--     end
--     wrapKey = function(val)
--         if type(val) == "number" then
--             return "[" .. val .. "]"
--         elseif type(val) == "string" then
--             return "[" .. quoteStr(val) .. "]"
--         else
--             return "[" .. tostring(val) .. "]"
--         end
--     end
--     wrapVal = function(val, level)
--         if type(val) == "table" then
--             return dumpObj(val, level)
--         elseif type(val) == "number" then
--             return val
--         elseif type(val) == "string" then
--             return quoteStr(val)
--         else
--             return tostring(val)
--         end
--     end
--     dumpObj = function(obj, level)
--         if type(obj) ~= "table" then
--             return wrapVal(obj)
--         end
--         level = level + 1
--         local tokens = {}
--         tokens[#tokens + 1] = "{"
--         for k, v in pairs(obj) do
--             tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. wrapVal(v, level) .. ","
--         end
--         tokens[#tokens + 1] = getIndent(level - 1) .. "}"
--         return table.concat(tokens, "\n")
--     end
--     return dumpObj(obj, 0)
-- end

local _dumpSetting = {}
tablex.dumpSetting = _dumpSetting

_dumpSetting.ShowIndex = true
_dumpSetting.ShowQuote = false
_dumpSetting.ShowValueQuote = true
_dumpSetting.EnumNoQuote = true -- 输出枚举时非字符串
_dumpSetting.EnumAddGE = true -- 输出枚举时加上GE
_dumpSetting.EnumMap = {}

function _dumpSetting.AddKeyEnumMap(key, enum)
    _dumpSetting.EnumMap[key] = enum
end

function _dumpSetting.RemoveKeyEnumMap(key, enum)
    _dumpSetting.EnumMap[key] = nil
end
--tablex.dumpShowQuote = false

local function _defaultKeySort(a, b)
    if type(a) == type(b) then
        return a < b
    else
        return tostring(a) < tostring(b)
    end
end

function tablex.dump(obj, maxLevel, rule)
    ---限制不输出日志时的调用，避免性能损耗。使用场景较多，不返回nil
    if LuaLogger and LuaLogger.Enabled == false then
        return "日志关闭"
    end
    if not obj then
        return "nil"
    end
    local dumpSetting = tablex.dumpSetting
    local getIndent, quoteStr, wrapKey, wrapVal, dumpObj
    local dumpShowIndex = dumpSetting.ShowIndex
    local dumpShowQuote = dumpSetting.ShowQuote
    local dumpShowValueQuote = dumpSetting.ShowValueQuote
    local dumpEnumNoQuote = dumpSetting.EnumNoQuote
    local showGE = dumpSetting.EnumAddGE
    local keyChain
    if rule and rule.firstKey then
        keyChain = {rule.firstKey}
    else
        keyChain = {}
    end

    local dumpVisited = {}

    maxLevel = maxLevel or 99999
    getIndent = function(level)
        return string.rep("\t", level)
    end
    quoteStr = function(str)
        local changed = string.gsub(str, '"', '\\"')
        return dumpShowValueQuote and '"' .. changed .. '"' or changed
    end
    wrapKey = function(val)
        if type(val) == "number" then
            return "[" .. val .. "]"
        elseif type(val) == "string" then
            return dumpShowQuote and "[" .. quoteStr(val) .. "]" or val
        else
            return "[" .. tostring(val) .. "]"
        end
    end
    wrapVal = function(key, val)
        -- if type(val) == "table" and level < maxLevel then
        --     return dumpObj(val, level)
        -- else
        -- if type(val) == "number" then
        --     return val
        -- else
        if type(val) == "string" then
            return quoteStr(val)
        else
            local ename = dumpSetting.EnumMap and dumpSetting.EnumMap[key]
            if ename then
                --dumpEnumNoQuote
                local enumStr = GF.GetEnumName(ename, val)
                if showGE then
                    enumStr = "GE." .. enumStr
                end

                if dumpEnumNoQuote then
                    return enumStr
                else
                    return quoteStr(enumStr)
                end
            end
            if type(val) == "number" and val == math.floor(val) then
                val = math.floor(val)
            end
            -- 检查循环引用
            if type(val) == "table" and dumpVisited[val] ~= nil then
                local tableName = dumpVisited[val] or "table"
                return string.format("%s@%p", tableName, val)
            end
            return tostring(val)    -- including table
        end
    end
    dumpObj = function(obj, level)
        local key = keyChain[#keyChain]

        if type(obj) ~= "table" then
            return wrapVal(key, obj)
        end

        -- 检测循环引用
        if dumpVisited[obj] ~= nil then
            local tableName = dumpVisited[obj] or "table"
            return string.format("%s@%p", tableName, obj)
        end
        dumpVisited[obj] = key or "root"

        local preKey = keyChain[#keyChain - 1]

        level = level + 1
        local tokens = {}
        tokens[#tokens + 1] = "{"

        local filter
        if not rule or not rule.expand or key and rule.expand[key] then
            filter = true
        end

        local keys
        if rule then
            keys = rule.expand and rule.expand[key] or 
                    key and rule.keySeq and rule.keySeq[key] or 
                    preKey and rule.preKeySeq and rule.preKeySeq[preKey]
        end

        if keys == nil or keys == true then
            keys = tablex.toKeyArray(obj)
            if rule then
                if rule.keySort and rule.keySort[key] then
                    local keySortInfo = rule.keySort[key]
                    if keySortInfo.ascend then
                        table.sort(keys)
                    end
                elseif rule.defaultKeySort then
                    table.sort(keys, _defaultKeySort)
                end
            end
        end

        for i, j in ipairs(keys) do
            local k = j
            local v = obj[j]

            if v ~= nil then
                local tbVal
                if not filter or not rule or rule.expand == nil or rule.expand[key] == true or tablex.find(rule.expand[key], k) then
                    if type(v) == "table" and level < maxLevel then
                        table.insert(keyChain, k)
                        tbVal = dumpObj(v, level)
                        table.remove(keyChain, #keyChain)
                    else
                        tbVal = wrapVal(k, v)
                    end

                    if not dumpShowIndex and tablex.isArray(obj) then
                        tokens[#tokens + 1] = getIndent(level) .. tbVal .. ","
                    else
                        tokens[#tokens + 1] = getIndent(level) .. wrapKey(k) .. " = " .. tbVal .. ","
                    end
                end
            end
        end
        tokens[#tokens + 1] = getIndent(level - 1) .. "}"
        dumpVisited[obj] = nil
        return table.concat(tokens, "\n")
    end
    return dumpObj(obj, 0)
end

local function _cmpKeyChain(keyChain, ignoreKeyChains)
    -- temp add
    for _, ignoreChain in ipairs(ignoreKeyChains) do
        local match = true
        for i, v in ipairs(ignoreChain) do
            local key1 = keyChain[i]
            if v ~= "*" then
                if v ~= key1 then
                    match = false
                    break
                end
            end
        end

        if match then
            return true
        end
    end

    return false
end

local function _isIgnore(rule, keyChain, key)
    local ignoreKeyChains = rule and rule.ignoreKeyChains
    local ignoreKeys = rule and rule.ignoreKeys

    return ignoreKeyChains and _cmpKeyChain(keyChain, ignoreKeyChains) or ignoreKeys and tablex.find(ignoreKeys, key)
end

-- 比较内容是否相同(包括顺序，比如{1,2} {2,1}是不同的)
-- 返回参数：是否相等，值不同的key链，不同的值1，不同的值2
function tablex.equal(ta, tb, rule, keyChain)
    if ta == tb then
        return true
    end

    local ignoreFunc = rule and rule.ignoreFunc
    local ignoreKeyChains = rule and rule.ignoreKeyChains
    local ignoreKeys = rule and rule.ignoreKeys
    if not keyChain then
        keyChain = {}
    end

    if not ta or not tb then
        --LuaLogger.ds(false, "not ta or not tb", ta, tb)
        return false, keyChain, ta, tb
    end

    --local probKeySeq = {}
    local function eqto1(suba, subb)
        if type(suba) ~= type(subb) or type(suba) ~= "table" then
            --LuaLogger.ds("type(suba) ~= type(subb)", type(suba), type(subb))
            return false, string.format("%s %s type(suba) ~= type(subb) or type(suba) ~= \"table\"", type(suba), type(subb)), suba, subb
        end

        for k,v in pairs(suba) do
            table.insert(keyChain, k)
            --table.insert(probKeySeq, k)
            if not _isIgnore(rule, keyChain, k) then
                local v2 = subb[k]
                if v2 == nil then
                    --LuaLogger.ds("not v2", false, k, v, v2)
                    return false, k, v, v2
                elseif v ~= v2 then
                    if type(v) == "table" and type(v2) == "table" then
                        local eq, keyTb, r1, r2 = tablex.equal(v, v2, rule, keyChain)
                        if not eq then
                            --LuaLogger.ds("not eq", eq, key, r1, r2)
                            --tablex.insertrange(probKeySeq, keyTb)
                            --return eq, probKeySeq, r1, r2
                            return eq, keyChain, r1, r2
                            --return eq, string.format("%s-%s", tostring(k), tostring(key)), r1, r2
                        end
                    elseif ignoreFunc and type(v) == "function" and type(v2) == "function" then
                        return true
                    else
                        --LuaLogger.ds("v ~= v2 else", false, k, v, v2)
                        return false, k, v, v2
                    end
                end
            end
            table.remove(keyChain, #keyChain)
        end

        return true
    end

    local function eqto2(suba, subb)
        if suba == subb then
            return true
        end

        for k,v in pairs(subb) do
            table.insert(keyChain, k)
            if suba[k] == nil then
                --LuaLogger.ds("eqto2", false, k, v, nil)
                if _isIgnore(rule, keyChain, k) then
                else
                    return false, k, nil, v
                end
            end
            table.remove(keyChain, #keyChain)
        end

        return true
    end

    local eq, key, r1, r2 = eqto1(ta, tb)
    if not eq then
        if istable(key) then
            return eq, key, r1, r2
        else
            return eq, {key}, r1, r2
        end
    end

    eq, key, r1, r2 = eqto2(ta, tb)
    if not eq then
        if istable(key) then
            return eq, key, r1, r2
        else
            return eq, {key}, r1, r2
        end
    end

    return true
end

function tablex.setReadOnly(t)
    local mt = {
        __index = function(t,k) return t[k] end,
        __newindex = function(t, k, v)
            error("attempt to update a read-only table!")
        end
    }
    setmetatable(t, mt)
    return t
end

function tablex.confirmKeyTable(t, key)
    local exist = true
    local v = t[key]
    if not v then
        v = {}
        t[key] = v
        exist = false
    end

    return v, exist
end

function tablex.clear(t)
    if not t then
        return
    end

    for k, v in pairs(t) do
        t[k] = nil
    end
end

function tablex.shuffle(t)
    if type(t) ~= "table" then 
        return 
    end
    local n = #t
    for i = n, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end



-- do
--     local _tostring = tostring
--     tostring = function(v)
--         if type(v) == 'table' then
--             return dump(v)
--         else
--             return _tostring(v)
--         end
--     end
-- end

-- string扩展

-- 下标运算
do
    local mt = getmetatable("")
    local _index = mt.__index

    mt.__index = function (s, ...)
        local k = ...
        if "number" == type(k) then
            return _index.sub(s, k, k)
        else
            return _index[k]
        end
    end
end

string.split = function(s, delim)
    local split = {}
    local pattern = "[^" .. delim .. "]+"
    string.gsub(s, pattern, function(v) table.insert(split, v) end)
    return split
end

string.ltrim = function(s, c)
    local pattern = "^" .. (c or "%s") .. "+"
    return (string.gsub(s, pattern, ""))
end

string.rtrim = function(s, c)
    local pattern = (c or "%s") .. "+" .. "$"
    return (string.gsub(s, pattern, ""))
end

string.trim = function(s, c)
    return string.rtrim(string.ltrim(s, c), c)
end

string.startswith = function(str, substr)
    if str == nil or substr == nil then
        return nil, "the string or the sub-stirng parameter is nil"
    end
    if string.find(str, substr, 1, true) ~= 1 then
        return false
    else
        return true
    end
end

string.endswith = function(str, substr)
    if str == nil or substr == nil then
        return nil, "the string or the sub-string parameter is nil"
    end
    local str_tmp = string.reverse(str)
    local substr_tmp = string.reverse(substr)
    if string.find(str_tmp, substr_tmp, 1, true) ~= 1 then
        return false
    else
        return true
    end
end

--- 获取utf8编码字符串正确长度的方法
-- @param str
-- @return number
string.utflen = function (str)
    local len = #str;
    local left = len;
    local cnt = 0;
    local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};

    while left ~= 0 do
        local tmp=string.byte(str,-left);
        local i=#arr;
        while arr[i] do
            if tmp>=arr[i] then left=left-i;break;end
            i=i-1;
        end
        cnt=cnt+1;
    end

    return cnt;
end

--- 获取utf8编码字符串正确长度的方法
-- @param str
-- @return number
string.utfchars = function (str)
    local len = #str;
    local left = len;
    local chars = {};
    local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};

    while left ~= 0 do
        local tmp=string.byte(str,-left);
        local i=#arr;
        while arr[i] do
            if tmp>=arr[i] then left=left-i;break;end
            i=i-1;
        end
        local char = string.sub(str, -left - i, -left-1)
        table.insert(chars, char)
    end

    return chars;
end

function split_string_by_upper_case(s)
	local res = {}
	--[[
	local pattern = "[a-z]+"
	table.insert(res, string.match(s, pattern))
	]]

	pattern = "[A-Z][^A-Z]+"
	string.gsub(s, pattern, function(v) table.insert(res, v) end)
	return res
	--[[
	local res = {}
	local pattern = "[A-Z][^A-Z]+"
	string.gsub(s, pattern, function(v) table.insert(res, v) end)
	return res
	]]
end

function string.lowerfirst(s)
	return string.lower(string.sub(s, 1, 1)) .. string.sub(s, 2)
end

function string.upperfirst(s)
	return string.upper(string.sub(s, 1, 1)) .. string.sub(s, 2)
end

stringx = {}

function stringx.urlEncode(str)
    if (str) then
        str = string.gsub (str, "\n", "\r\n")
        str = string.gsub (str, "([^%w ])",
                function (c) return string.format ("%%%02X", string.byte(c)) end)
        str = string.gsub (str, " ", "+")
    end
    return str
end

function stringx.urlDecode(str)
    str = string.gsub (str, "+", " ")
    str = string.gsub (str, "%%(%x%x)",
            function(h) return string.char(tonumber(h,16)) end)
    str = string.gsub (str, "\r\n", "\n")
    return str
end

-- 如果str不是4的倍数，加=到4的倍数长度
function stringx.ensureBase64Lenth(str)
    local delta = 4 - str:len() % 4
    if delta > 0 and delta ~= 4 then
        str = str .. string.rep("=", delta)
    end

    return str
end

-- email格式是否基本合法，如是否有@ .
function stringx.isEmailValid(email)
    if not email:find("@", 1, true) then
        return false
    end

    if not email:find(".", 1, true) then
        return false
    end

    return true
end

function stringx.isNilOrEmpty(str)
    return not str or str == ""
end

function stringx.toHexStr(str)
    local t = {}
    for i = 1, #str do
        local c = string.sub(str, i, i)
        local b = string.byte(c)
        table.insert(t, string.format("%02x", b))
    end

    return table.concat(t)
end

-- 只有字母和字符串
function stringx.isAlphaNum(str)
    return string.match(str,"[^%w]") == nil
end

-- 是中国大陆手机号
function stringx.isPhoneNumCn(phoneNum)
    return tonumber(phoneNum) and #phoneNum == 11
end

-- table序列化为无空格字符串
function stringx.tableToStr(tb)
    local origin = tablex.dumpSetting
    tablex.dumpSetting = {}
    tablex.dumpSetting.ShowIndex = false

    local str = tablex.dump(tb)
    str = str:gsub("\n", "")
    str = str:gsub("\t", "")
    str = str:gsub(" ", "")
    str = str:gsub(",}", "}")

    tablex.dumpSetting = origin

    return str
end

function stringx.getBirthdayByIdCard(str, format)
    if not str then
        return
    end

    local res = str:sub(7, 14)
    if #res ~= 8 then
        return
    end

    local year = res:sub(1, 4)
    local month = res:sub(5, 6)
    local day = res:sub(7, 8)

    if not format then
        if month:sub(1,1) == "0" then
            month = month:sub(2, 2)
        end

        if day:sub(1,1) == "0" then
            day = day:sub(2, 2)
        end
    end

    return string.format("%s-%s-%s", year, month, day)
end

function stringx.toIntStr(str)
    if not str then
        return
    end

    return string.format("%d", str)
end

local _specialTxt =
{
    "</richText>",
    "</size",
    "</color",
    "</b",
    "</i",
    "</a",
    "[世界]",
    "\n",
}

function stringx.hasRichText(str)
    for _, v in pairs(_specialTxt) do
        if str:find(v, 1, true) then
            return true
        end
    end

    return false
end

-- number 0-9 48-57
-- letter lower a-z 97-122
-- letter upper A-Z 65-90

-- 定义好一个固定数字m1[1-10000]，目标长度tn，以及字符串数组通得到table形式设置{m1=233,tn=6,chars={"0","a","A"}},目前chars中依次表示生成字符串有数字、小写字母、大写字母
-- 根据生成字符范围获得可生成字符的总数total，并按顺序排列范围组，优先级为"a">0>"A"
-- 现将原字符串转为ASCII码数组array
-- 1.如果数组长度大于给定长度tn
---- 初始i=1，结束条件#array==tn
---- 第i个数字和最后一个数字相加覆盖第i个数字,并删掉最后一个数字，i=min(++i,#array)
-- 2.如果数组长度小于给定长度tn
---- 初始i=1，结束条件#array==tn
---- 第i个数字和最后一个数字相加添加到数组末尾,i=min(++i,#array)
-- m1Sum为m1的各位数字之和，arraySum为array各位数字之和
-- 对数组的每个数字依次进行result=(v * m1 + i + tn + arraySum + m1Sum * (m1Sum % 10)) % total + 1,i为数字所在索引,根据result去范围内定位到字符

local _asciiRange = {
    ["a"] = {beg = 97, last = 122, prio = 20},
    ["0"] = {beg = 48, last = 57,  prio = 15},
    ["A"] = {beg = 65, last = 90,  prio = 10},
}

local _charKeys = {}
for k,v in pairs(_asciiRange) do
    table.insert(_charKeys, k)
end

local _genSortPrio = function (a, b)
    return a.prio > b.prio
end

-- 调用示例stringx.genFixedStr("abcd", {m1=334,tn=5,chars={"0","a","A"}})
function stringx.genFixedStr(str, setting)
    local m1 = setting.m1
    local tn = setting.tn
    local total = 0
    local ranges = {}
    for i,v in ipairs(setting.chars) do
        if tablex.find(_charKeys, v) then
            local range = _asciiRange[v]
            total = total + range.last - range.beg + 1
            table.insert(ranges, range)
        end
    end

    assert(total > 0, "no charsets found")

    table.sort(ranges, _genSortPrio)

    local arrayNum = #str
    local array = {}
    for i = 1, arrayNum do
        local r = str:sub(i,i)
        local ascii = string.byte(r)
        table.insert(array, ascii)
    end

    if arrayNum > tn then
        local i = 1
        while arrayNum > tn do
            array[i] = array[i] + array[arrayNum]
            table.remove(array, arrayNum)
            arrayNum = arrayNum - 1
            i = i + 1
            i = math.min(i, arrayNum)
        end
    elseif arrayNum < tn then
        local i = 1
        while arrayNum < tn do
            local newNum = array[i] + array[arrayNum]
            table.insert(array, newNum)
            arrayNum = arrayNum + 1
            i = i + 1
            i = math.min(i, arrayNum)
        end
    end

    local arraySum = 0
    for i,v in ipairs(array) do
        arraySum = arraySum + v
    end

    local m1Sum = 0
    local m1Tmp = m1
    while m1Tmp > 0 do
        m1Sum = m1Sum + m1Tmp % 10
        m1Tmp = math.floor(m1Tmp/10)
    end

    local strTb = {}
    for i,v in ipairs(array) do
        local tmp = (v * m1 + i + tn + arraySum + m1Sum * (m1Sum % 10)) % total + 1
        for i2,v2 in ipairs(ranges) do
            local rNum = v2.last - v2.beg + 1
            if tmp <= rNum then
                local ascii = v2.beg + tmp - 1
                table.insert(strTb, string.char(ascii))
                break
            else
                tmp = tmp - rNum
            end
        end
    end

    local result = table.concat(strTb)
    return result
end

-- 将字符串转换为正整数ID，用于分片键
function stringx.hash(s)
    local hash = 0
    local maxHash = 2147483647  -- 2^31 - 1
    for i = 1, #s do
        hash = (hash * 31 + string.byte(s, i)) % maxHash
    end

    return hash + 1 -- 确保返回正数（1 到 maxHash）
end

-- math扩展
do
	local _floor = math.floor
	math.floor = function(n, p)
		if p and p ~= 0 then
			local e = 10 ^ p
			return _floor(n * e) / e
		else
			return _floor(n)
		end
	end

    math.pow = math.pow or function(a, b)
        return a^b
    end
end

math.round = function(n, p)
    local e = 10 ^ (p or 0)
    return math.floor(n * e + 0.5) / e
end

math.roundNum = function(n, offsetNum)
    if n > 0 then
        return math.floor(n + offsetNum)
    end

    return math.ceil(n - offsetNum)
end

mathx = {}

mathx.EPSILON = 2^-52 -- = machine epsilon for "double", ~2.22E-16
-- if math.abs(1.1 - 1 - 0.1) > mathx.EPSILON then
   -- rounding error is above EPSILON, assume single precision
   mathx.EPSILON = 2^-23 -- = machine epsilon for "float", ~1.19E-07
-- end

function mathx.getDot(nNum, n)
    -- if type(nNum) ~= "number" then
    --     return nNum;
    -- end

    n = n or 0;
    n = math.floor(n)
    local fmt = '%.' .. n .. 'f'
    local nRet = tonumber(string.format(fmt, nNum))

    return nRet;
end

function mathx.sign(num)
    return num >= 0 and 1 or -1
end

function mathx.clamp(v, min, max)
    return math.min(math.max(v, min), max)
end

function mathx.between(v, min, max)
    return v >= min and v <= max
end

function mathx.bound(v, t, diff)
    return mathx.between(v, t - diff, t + diff)
end

function mathx.outbound(v, t, diff)
    return not mathx.bound(v, t, diff)
end

function mathx.almostEquals(actual, expected)
    return math.abs(expected - actual) <= mathx.EPSILON
end

function mathx.eq0(value)
    return value and mathx.almostEquals(value, 0)
end

function mathx.ne0(value)
    return value and not mathx.almostEquals(value, 0)
end

function mathx.lt0(value)
    if mathx.almostEquals(value, 0) then
        return false
    end

    return value <= 0
end

-- value 是否 <= 0
function mathx.le0(value)
    if value <= 0 then
        return true
    end

    if mathx.almostEquals(value, 0) then
        return true
    end

    return false
end

-- 是否大于0
function mathx.gt0(value)
    if mathx.almostEquals(value, 0) then
        return false
    end

    return value > 0
end

-- 
function mathx.adjustHp(v)
    if mathx.almostEquals(v, 0) then
        return 0
    end

    if v < 0 then
        return 0
    end

    if v > 0 then
        v = math.floor(v)
    end

    return v
end

function mathx.adjustInt(v)
    local temp
    if mathx.almostEquals(v, 0) then
        temp = 0
    elseif v > 0 then
        temp = math.ceil(v)
        if 1 - math.abs(temp - v) < 0.0001 then
            temp = math.floor(v)
        end
    else
        temp = math.floor(v)
        if 1 - math.abs(temp - v) < 0.0001 then
            temp = math.ceil(v)
        end
    end

    v = temp

    return v
end

-- do
--     local strformat = string.format
--     function string.format(format, ...)
--     local args = {...}
--     local match_no = 1
--     for pos, type in string.gmatch(format, "()%%.-(%a)") do
--         if type == 't' then
--             args[match_no] = tostring(args[match_no])
--         end
--         match_no = match_no + 1
--     end
--     return strformat(string.gsub(format, '%%t', '%%s'),
--             unpack(args,1,select('#',...)))
--     end
-- end


function mathx.Repeat(t, length)
	return t - (math.floor(t / length) * length)
end  



mathx.maxint = 2147483647

debugx = {}
----------------------------------------------------------------
-- 获得GetCallThisInfo所在的函数是在哪被调用的
function debugx.getCallThisInfo(num)
    local info = debug.getinfo(2 + num or 0)
    info.callline = debug.getinfo(3 + num or 0).currentline
    return info
end

-- -- 函数使用场景
-- local function abc()
--  local info = debugx.getCallThisInfo()
--  print(tablex.dump(info))
--  -- info.callline 下面abc()所在行数
--  -- info.name 本函数名(abc)
--  -- info.linedefined abc函数定义的开始行
--  -- info.lastlinedefined abc函数定义的结束行
--  -- info.namewhat
--      -- 如果abc是全局函数则为global
--      -- 如果abc是local函数，并且直接调用(不在其他函数中调用)，则为local -- e.g.1
--      -- 如果abc是local函数，并且在其他函数中调用，则为upvalue         -- e.g.2
--  -- info.currentline abc中debugx.getCallThisInfo()所在行
-- end

-- -- e.g.1
-- abc()

-- -- e.g.2
-- function gg()
--  abc()
-- end
-- gg()

function debugx.getCurrentFileName(hasExt)
    local filePath = debug.getinfo(2).short_src
    local ret = string.find(string.reverse(filePath), "/")
    if ret == nil then
        return filePath
    end

    local len = string.len(filePath) - ret + 1
    local fileName = string.sub(filePath, len + 1, string.len(filePath))
    if not hasExt then
        ret = string.find(string.reverse(fileName), ".", 1, true)
        if ret ~= nil then
            fileName = string.sub(fileName, 1, string.len(fileName) - ret)
        end
    end

    return fileName
end
----------------------------------------------------------------

-- function serialize(obj)
--     local lua = ""
--     local t = type(obj)
--     if t == "number" then
--         lua = lua .. obj
--     elseif t == "boolean" then
--         lua = lua .. tostring(obj)
--     elseif t == "string" then
--         lua = lua .. string.format("%q", obj)
--     elseif t == "table" then
--         lua = lua .. "{\n"
--         for k, v in pairs(obj) do
--             lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
--         end
--         --local metatable = getmetatable(obj)
--         -- if metatable ~= nil and type(metatable.__index) == "table" then
--         --     for k, v in pairs(metatable.__index) do
--         --         lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
--         --     end
--         -- end
--         lua = lua .. "}"
--     elseif t == "nil" then
--         return nil
--     else
--         -- error("can not serialize a " .. t .. " type.")
--     end
--     return lua
-- end
function serialize(obj)
    local t = type(obj)
    if t == "number" then
        return tostring(obj)
    elseif t == "boolean" then
        return tostring(obj)
    elseif t == "string" then
        return string.format("%q", obj)
    elseif t == "table" then
        local buffer = { "{\n" }
        for k, v in pairs(obj) do
            -- 优化 Key 的包裹逻辑，避免出现 ["\"key\""] 的双引号嵌套错误
            local k_str
            if type(k) == "string" then
                k_str = string.format("[%q]", k)
            else
                k_str = "[" .. serialize(k) .. "]"
            end
            
            table.insert(buffer, k_str .. "=" .. serialize(v) .. ",\n")
        end
        table.insert(buffer, "}")
        return table.concat(buffer)
    elseif t == "nil" then
        return "nil" -- 原逻辑返回 nil，但外层拼接需要字符串，建议保持返回字符串
    else
        return "" -- 保持原逻辑：不支持的类型返回空字符串
    end
end

luautil.serialize = serialize

function unserialize(lua)
    local t = type(lua)
    if t == "nil" or lua == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        lua = tostring(lua)
    else
        error("can not unserialize a " .. t .. " type.")
    end
    lua = "return " .. lua
    local func = loadstring(lua)
    if func == nil then return nil end
    return func()
end

luautil.unserialize = unserialize

function threshold(value, floorlimit, toplimit)
	if value > toplimit then
		value = toplimit
	end
	if value < floorlimit then
		value = floorlimit
	end
	return value
end

-- percent is in [0, 1]
function random_boolean(percent)
	math.randomseed(os.time())
	local r = math.random(0,100)
	return r <= percent * 100
end

function isnil(n)
    return type(n) == "nil"
end

function isnumber(n)
    return type(n) == "number"
end

function istable(n)
    return type(n) == "table"
end

function isstring(n)
    return type(n) == "string"
end

function isfunction(n)
    return type(n) == "function"
end

function isboolean(n)
    return type(n) == "boolean"
end

function copytable(src, dest)
    for k,v in pairs(dest) do
        src[k] = v
    end
end

function Require(moduleName)
    return require(moduleName)
end

function RequireDbg(moduleName)
    if GV.GlobalConfig and GV.GlobalConfig.RequireDbgReload then
        return ReloadModulex(moduleName)
    else
        local ok, res = pcall(require, moduleName)
        return ok and res or ok, res
    end
end

function ReloadModule(moduleName)
    -- LuaLogger.d("Reload %s", moduleName)
    package.loaded[moduleName] = nil
    return require (moduleName)
end

function ReloadModulex(moduleName)
    -- LuaLogger.d("Reload %s", moduleName)
    package.loaded[moduleName] = nil
    local ok, res = pcall(require, moduleName)
    if not ok then
        LuaLogger.e("ReloadModle failed:%s", res)
    end

    return ok and res or ok, res
end

function ReloadGlobalVar(moduleName)
    package.loaded[moduleName] = nil
    _G[moduleName] = require (moduleName)
    return _G[moduleName]
end

function InsertData(proto, key, data, bValue, getKeyFunc, saveValue)
    if not proto then
        return
    end
    if bValue then
        proto[key] = clone(data)
        if proto.valueSave and saveValue then
            local b = false
            for _, v in pairs(proto.valueSave) do
                if v == key then
                    b = true
                    break
                end
            end
            if not b then
                table.insert(proto.valueSave, key)
            end
        end
        return proto[key]
    end
    local array = proto[key]
    if not array then
        array = {}
        proto[key] = array
    end
    local cloneData = clone(data)
    if getKeyFunc and getKeyFunc(key) and not proto.canAdd then
        local arrayKey = getKeyFunc(key)
        local index = nil
        for i, v in pairs(array) do
            if v[arrayKey] and v[arrayKey] == cloneData[arrayKey] then
                index = i
                break
            end
        end
        if index then
            array[index] = cloneData
        else
            table.insert(array, cloneData)
        end
    else
        table.insert(array, cloneData)
    end

    return cloneData
end

function GetOrAddProto(protos, key)
    for i,v in ipairs(protos) do
        if v[1] == key then
            return v[2]
        end
    end

    local data = {}
    local proto = { key, data }
    table.insert(protos, proto)
    return data
end

function filex.getFileName(str)
    local idx = str:match(".+()%.%w+$")
    if(idx) then
        return str:sub(1, idx-1)
    else
        return str
    end
end

function filex.getFileExt(str)
    return str:match(".+(%.%w+)$") or ""    -- .txt
    -- return str:match(".+%.(%w+)$")       -- txt
end

function filex.isFileExist(filePath)
    local f = io.open(filePath, "r")
    return f ~= nil
end

function filex.getFileSize(filePath)
    local f = io.open(filePath, "a")
    if not f then
        return 0
    end

    local len = f:seek("end")
    f:close()
    return len
end

function filex.confirmDir(path)
    local code
    if osx.isWin then
        path = path:gsub("/", "\\")
        code = os.execute("mkdir " .. path)
    else
        path = path:gsub("\\", "/")
        code = os.execute("mkdir -p " .. path)
    end

    return code == 0
end

function filex.writeAllText(path, content)
    local file = io.open(path, "w")
    if not file then
        return false
    end

    local ok, res = file:write(content)
    if not ok then
        return ok, res
    end

    return file:close()
end

function filex.readAllText(path)
    local file = io.open(path, "r")
    if not file then
        return false
    end

    local content, res = file:read("*a")
    file:close()
    return content
end

-- options = {encoding = "gbk"}，目前只有windows上可用
-- encoding默认值为utf8
-- keys为数组，每个元素可以是简单的字符串，表示列名(即使用已有key作为列名)
-- 或者是table:{realKey = "原列名", showKey = "显示列名", showValueFunc = wayShowFunc},
-- showValueFunc可选，可对即将输出的值做转换，参数为原值
function filex.writeCsv(path, datas, keys, options)
    if not keys then
        return false
    end

    local isGbk = options and options.encoding == "gbk"
    local function writeText(f, text, isEnd)
        text = isstring(text) and text or tostring(text)
        if isGbk then
            local ok, lc = pcall(require, "lc") -- 目前只有windows上有
            if ok then
                text = lc.u2a(text)
            end
        end

        text = text:gsub("%z", "")
        f:write(text)
        if not isEnd then
            f:write(",")
        end
    end

    local idf = io.open(path, "w+")
    if not idf then
        LuaLogger.es("open file failed", path)
        return
    end

    local isKeysTable = istable(keys[1])
    for i,v in ipairs(keys) do
        if isKeysTable then
            writeText(idf, v.showKey or v.realKey, i == #keys)
        else
            writeText(idf, v, i == #keys)
        end
    end

    idf:write("\n")

    for i,v in ipairs(datas) do
        for j,k in ipairs(keys) do
            local showValue
            if isKeysTable then
                showValue = v[k.realKey]
            else
                showValue = v[k]
            end

            showValue = tonumber(showValue) or showValue
            if isKeysTable and k.showValueFunc then
                showValue = k.showValueFunc(showValue)
            end

            if not showValue then
                showValue = ""
            end

            writeText(idf, showValue, j == #keys)
        end

        idf:write("\n")
    end

    idf:close()
end

-- 随机调整tb中元素的顺序, allowSame!=true表示洗牌后任何元素一定不在原来的位置
function luautil.shuffle(tb, allowSame)
    if not tb or not istable(tb) or #tb == 1 then
        return tb
    end

    local len = #tb
    for i = 1, len - 1 do
        local newPos
        if allowSame then
            newPos = math.random(i, len)
        else
            newPos = math.random(i + 1, len)
        end

        tb[i], tb[newPos] = tb[newPos], tb[i]
    end

    return tb
end

function luautil.combineItems(items, addedItems)
    if not addedItems then
        return items
    end

    for j, v2 in ipairs(addedItems) do
        local added
        for i, v in ipairs(items) do
            if v.id == v2.id then
                v.num = v.num + v2.num
                added = true
                break
            end
        end

        if not added then
            table.insert(items, clone(v2))
        end
    end

    return items
end

-- items为table array
-- 每个item={id=xx,[weightKey]=xx}
function luautil.randomItems(items, weightKey, random, extraMult)
    local totalWeight = 0
    local randomPool = {}
    for i, v in ipairs(items) do
        local singleWeight = v[weightKey]
        if extraMult then
            singleWeight = singleWeight * extraMult
        end

        local idWeight = singleWeight * 1 -- 1份
        totalWeight = totalWeight + idWeight
        table.insert(randomPool, {id = v.id, weight = idWeight})
    end

    local randomWeight = random:range(1, totalWeight)
    local accuWeight = 0
    for i, v in ipairs(randomPool) do
        accuWeight = accuWeight + v.weight
        --LuaLogger.d("randomWeight:%d, accuWeight:%d, id:%d,weight:%d", randomWeight, accuWeight, v.id, v.weight)
        if randomWeight <= accuWeight then
            return items[i], i
        end
    end
end

-- 注意该函数会修改elements
function luautil.randomElements(elements, num, random)
    local ret = {}
    local eleNum = #elements
    local rdNum = 0
    elements = shallowclone(elements)

    while eleNum > 0 and rdNum < num do
        local index = random:range(1, eleNum)
        local r = elements[index]
        table.insert(ret, r)
        rdNum = rdNum + 1
        table.remove(elements, index)
        eleNum = eleNum - 1
    end

    return ret
end

function luautil.GetValueRangeInArray(arr, value)
    local index = 1
    for i, v in ipairs(arr) do
        if value < v then
            return math.max(1, i - 1)
        end

        index = i
    end

    return index
end

function luautil.elementInArray(ele, arr)
    for k, v in pairs(arr) do
        if v == ele then
            return true
        end
    end

    return false
end

-- tb一般为一个表的所有数据，找到在列名为columnKey的数据行中最大不超过value所在行的id(也可以用idKey指明别的列名)
function luautil.GetIdByColumnRange(tb, value, columnKey, idKey)
    idKey = idKey or "id"
    local lastId = 1
    for i, v in ipairs(tb) do
        if value < v[columnKey] then
            return lastId
        else
            lastId = v[idKey]
        end
    end

    return lastId
end

-- 获得本周周几(week)的日期结构以及对应时间戳，如果hour,min,sec不设置默认为0，如果stamp不设默认以当前
function luautil.getWdayOfThisWeek(week, hour, min, sec, stamp)
    week = week + 1

    hour = hour or 0
    min = min or 0
    sec = sec or 0

    local nowStamp = stamp or os.time()
    local nowDate = os.date('*t', nowStamp)
    local nowWeek = nowDate.wday
    if nowWeek == 1 then
        nowWeek = 8
    end

    --print("nowDate.wday", nowDate.wday)
    -- wday>/<week相同
    local weekStamp = nowStamp + (week - nowWeek) * 24 * 3600
    local weekDate = os.date('*t', weekStamp)
    weekDate.hour = hour
    weekDate.min = min
    weekDate.sec = sec
    return os.time(weekDate), weekDate
end

-- 类getWdayOfThisWeek，但得到的是下周的
function luautil.getWdayOfNextWeek(week, hour, min, sec, stamp)
    stamp = stamp or os.time()
    stamp = stamp + 7 * 24 * 3600
    return luautil.getWdayOfThisWeek(week, hour, min, sec, stamp)
end

-- 获取指定出生日期的周岁年龄
-- birthStr:2000-11-11
function luautil.getYearsOldByBirthStr(birthStr)
    local strs = birthStr:split("-")
    local birYear = tonumber(strs[1])
    local birMonth = tonumber(strs[2])
    local birDay = tonumber(strs[3])

    local t = os.date('*t')
    local year = t.year
    local month = t.month
    local day = t.day

    local yearDelta = year - birYear

    if month > birMonth or month == birMonth and day >= birDay then
        return yearDelta
    else
        return yearDelta - 1
    end
end

function luautil.getDbDatetime()
    return string.format("'%s'", luautil.getCommonDatetime())
end

local _daySeconds = 3600 * 24

function luautil.getYesterdayDateStr()
    local t = os.date('*t', os.time() - _daySeconds)
    return string.format("%04d-%02d-%02d", t.year, t.month, t.day)
end

function luautil.getDateFileStr()
    local t = os.date('*t')
    return string.format("%04d-%02d-%02d_%02d-%02d-%02d",
        t.year, t.month, t.day, t.hour, t.min, t.sec)
end

-- stamp:nil则获得今天的日期
function luautil.getDateStr(stamp, dayOffset)
    if stamp and dayOffset then
        stamp = stamp + dayOffset * _daySeconds
    end

    local t = os.date('*t', stamp)
    return string.format("%04d-%02d-%02d", t.year, t.month, t.day)
end

function luautil.getTomorrowDateStrByDateStr(dateStr)
    return luautil.getDateStr(luautil.getStampByDateStr(dateStr), 1)
end

function luautil.getDateStrByDateStr(dateStr, dayOffset)
    local stamp = luautil.getStampByDateStr(dateStr)
    return luautil.getDateStr(stamp, dayOffset)
end

function luautil.isDateStr(dateStr)
    local strs = dateStr:split("-")
    if #strs ~= 3 then
        return false
    end

    return luautil.getDateStrByDateStr(dateStr) ~= nil
end

-- 常规时间格式：2020-10-22 17:16:47
-- 如果有stamp则
function luautil.getCommonDatetime(stamp, isGmt)
    if stamp then
        if isGmt then
            local now = os.time()
            local diff = os.difftime(now, os.time(os.date("!*t")))
            stamp = stamp + diff
        end
    end

    local t = os.date('*t', stamp)
    return string.format("%04d-%02d-%02d %02d:%02d:%02d",
            t.year, t.month, t.day, t.hour, t.min, t.sec)
end

function luautil.getFileDatetime(stamp, isGmt)
    if stamp then
        if isGmt then
            local now = os.time()
            local diff = os.difftime(now, os.time(os.date("!*t")))
            stamp = stamp + diff
        end
    end

    local t = os.date('*t', stamp)
    return string.format("%04d-%02d-%02d_%02d-%02d-%02d",
            t.year, t.month, t.day, t.hour, t.min, t.sec)
end

function luautil.getDatetimeData(stamp, isGmt)
    if isGmt then
        if stamp then
            stamp = luautil.gmtStampToLocal(stamp)
        end
    end

    return os.date('*t', stamp)
end

function luautil.getTimeStructByDateStr(timeStr)
    if type(timeStr) ~= 'string' then LuaLogger.es("timeStr is not a string", timeStr) return nil end
    local fun = string.gmatch(timeStr, "%d+")
    local y = fun() or 0
    if y == 0 then print("year == 0") return nil end
    local m = fun() or 0
    if m == 0 then print("month == 0") return nil end
    local d = fun() or 0
    if d == 0 then print("day == 0") return nil end
    local H = fun() or 0
    -- if H == 0 then print("hour == 0") return nil end
    local M = fun() or 0
    -- if M == 0 then print("minute == 0") return nil end
    local S = fun() or 0
    -- if S == 0 then print("second == 0") return nil end
    return { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = tonumber(H), min = tonumber(M), sec = tonumber(S) }
end

function luautil.getStampByDateStr(timeStr)
    return os.time(luautil.getTimeStructByDateStr(timeStr))
end

function luautil.getGmtStampByDateStr(timeStr)
    return luautil.getGmtStamp(luautil.getStampByDateStr(timeStr))
end

-- 获得第二天0点的时间戳(返回的是本地时间戳),isGmt表示nowStamp为gmt时间
-- nowStamp如果为空，则使用当前本地时间
function luautil.getTomorrow0Stamp(nowStamp, isGmt)
    if not nowStamp then
        nowStamp = luautil.getLocalStamp()
    end

    if isGmt then
        nowStamp = luautil.gmtStampToLocal(nowStamp)
    end

    nowStamp = nowStamp + 24 * 3600
    local t = os.date('*t', nowStamp)
    t.hour = 0
    t.min = 0
    t.sec = 0
    return os.time(t)
end

-- 如果有timeStamp(本地时间戳)，得到本地时间戳对应的gmt时间戳
---@param timeStamp integer|nil
---@return integer
function luautil.getGmtStamp(timeStamp)
    if timeStamp then
        return timeStamp + luautil.getGmtStamp() - os.time()
    end

    return os.time(os.date("!*t"))
end

function luautil.getLocalStamp()
    return os.time()
end

function luautil.gmtStampToLocal(gmtStamp)
    local now = os.time()
    local diff = os.difftime(now, os.time(os.date("!*t")))
    local time = gmtStamp + diff
    return time
end

-- 比较两个时间是不是同一周(本地时间戳)，如果stamp2没有，则比较stamp1所在是不是当前周
function luautil.isStampSameWeek(stamp1, stamp2)
    stamp2 = stamp2 or os.time()

    local monday000000Stamp = luautil.getWdayOfThisWeek(1, 0, 0, 0, stamp1)
    local sunday235959Stamp = luautil.getWdayOfThisWeek(7, 23, 59, 59, stamp1)

    return mathx.between(stamp2, monday000000Stamp, sunday235959Stamp) 
end

-- 如果stamp2为空，则看stamp1是否与当前时间在同一个月
function luautil.isStampSameMonth(stamp1, stamp2)
    local date1 = os.date("*t", stamp1)
    local date2 = os.date("*t", stamp2 or os.time())
    return date1.year == date2.year and date1.month == date2.month
end

-- local time
function luautil.isStampSameDay(stamp1, stamp2)
    local date1 = os.date('*t', stamp1)
    local date2 = os.date('*t', stamp2)

    return date1.day == date2.day and
           date1.month == date2.month and
           date1.year == date2.year
end

-- isGmt为true，则将stamp视为gmtStamp并转化为本地时间
function luautil.isStampToday(stamp, isGmt)
    if isGmt then
        stamp = luautil.gmtStampToLocal(stamp)
    end

    return luautil.isStampSameDay(os.time(), stamp)
end

-- 获得今日已经经历的时间(单位秒)
function luautil.secondsToday()
    local t = os.date('*t')
    return t.hour * 3600 + t.min * 60 + t.sec
end

-- 距离今天结束还剩的时间
function luautil.secondsLeftToday()
    return 24 * 3600 - luautil.secondsToday()
end

function luautil.getStampDayDiff(longStamp, shortStamp)
    local diff = longStamp - shortStamp
    local ret = 0

    if longStamp and shortStamp then
        local longDate = os.date("*t", longStamp)
        local shortDate = os.date("*t", shortStamp)

        if longDate and shortDate then
            local num1 = os.time({ year = longDate.year, month = longDate.month, day = longDate.day })
            local num2 = os.time({ year = shortDate.year, month = shortDate.month, day = shortDate.day })
            if num1 and num2 then
                ret =  (num1 - num2) / (3600 * 24)
                ret = math.round(ret)
            end
        end
    end

    return ret
end

-- '2021-01-01'
function luautil.getDateStrDayDiff(longDateStr, shortDateStr)
    return luautil.getStampDayDiff(luautil.getStampByDateStr(longDateStr), luautil.getStampByDateStr(shortDateStr))
end

-- 获得形如{'2021-01-01','2021-01-30'}的从今天起往前30天内的范围
function luautil.getRecentMonthInterval()
    local today = luautil.getDateStr()
    local day_30 = luautil.getDateStrByDateStr(today, -29)
    return {day_30, today}
end

function luautil.getTimezone()
    return math.round(os.difftime(os.time(os.date("*t")), os.time(os.date("!*t"))) / 3600)
end
--------------------------------sql函数-------------------------------------
----------------------------------------------------------------------------
function sqlutil.genInsertKeysValuesByTb(tb)
    local keys = {}
    local values = {}

    for k,v in pairs(tb) do
        table.insert(keys, string.format("`%s`", k))

        local value = v
        if isstring(value) then
            value = string.format("'%s'", value)
        end

        table.insert(values, value)
    end

    return keys, values
end

function sqlutil.genInsertSqlByTb(tbName, tb)
    local keys, values = sqlutil.genInsertKeysValuesByTb(tb)
    local sql = string.format("insert into %s(%s) values(%s)", tbName, table.concat(keys, ","), table.concat(values, ","))
    return sql
end

-- json存数据库前的合法化
function sqlutil.jsonFilter(str)
    if not str then
        return
    end

    str = str:gsub("'", "''")
    str = str:gsub("\n", "\\\\n")
    return str
end

---贝塞尔曲线
---@param p0 Vector3 起点
---@param p1 Vector3 中间点
---@param p2 Vector3 终点
---@param t float
---@return Vector3
function luautil.getBezier(p0, p1, p2, t)
    local x1 = (1 - t) * (1 - t)
    local x2 = 2 * t * (1 - t)
    local x3 = t * t
    return p0 * x1 + p1 * x2 + p2 * x3
end

--多次贝赛尔曲线
--@param {position} point_table 起点+控制点+终点集合 至少要3个点才能构成贝赛尔曲线
--@param {number} time_index	进度 0~1 0在起始点 1在终点
--@return {position}
function luautil.getBezierMultiple(point_list, t)
	local result_table = {}
	--若目标点只有一个 则退出递归
	if #point_list <= 1 then
		return point_list[1]
	else
		--每次计算出n个点中n-1个点对应time_index的轨迹
		local max = #point_list - 1
		for i = 1,max,1 do
			local start_pos = point_list[i]
			local end_pos = point_list[i+1]
			result_table[i] = start_pos + (end_pos - start_pos) * t
		end
		return luautil.getBezierMultiple(result_table, t)
	end
end

--测试输出
function luautil.testOutput(t)
    local m = getmetatable(t)
    if not m then
        LuaLogger.ds("achieveList: 无元表，纯表")
    else
        LuaLogger.ds("L0 shell", t, "mt", m)
        local idx = m.__index
        LuaLogger.ds("L1 __index", idx, "type", type(idx))
        if type(idx) == "table" then
            local m2 = getmetatable(idx)
            LuaLogger.ds("getmetatable(__index)", m2)  -- 关键：非 nil 说明「真数组」这张表也被包了
            if m2 and m2.__index then
                LuaLogger.ds("L2 __index.__index", m2.__index)
                luautil.testOutput(m2.__index)
            end
        end
    end
end