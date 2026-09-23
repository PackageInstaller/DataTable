Loader:Require("ConfigChecker")

if IS_CLIENT then

    -- table转字符串, 带美化格式
    function table.tostring(t)
        if type(t) ~= 'table' then
            return tostring(t)
        end
        -- LogTrace()
        local mark = {}
        local assign = {}
        local function ser_table(tbl, parent, deep)
            mark[tbl] = parent
            local tmp = {}
            local head = ''
            if deep > 0 then
                for i = 1, (deep - 1) * 4 do
                    head = ' ' .. head
                end
            end

            for k, v in pairs(tbl) do
                local key = type(k) == 'number' and '[' .. k .. ']' or '[' .. string.format('%q', k) .. ']' -- k为function时报错
                key = head .. '    ' .. key

                if type(v) == 'table' then
                    local dotkey = parent .. key
                    if mark[v] then
                        table.insert(assign, dotkey .. "='" .. mark[v] .. "'")
                    else
                        table.insert(tmp, key .. '=' .. ser_table(v, dotkey, deep + 1))
                    end
                elseif type(v) == 'string' then
                    table.insert(tmp, key .. '=' .. string.format('%q', v))
                elseif type(v) == 'number' or type(v) == 'boolean' then
                    table.insert(tmp, key .. '=' .. tostring(v))
                end
            end
            return '\n' .. head .. '{\n' .. table.concat(tmp, ',\n') .. '\n' .. head .. '}'
        end
        return ser_table(t, 'ret', 1) .. table.concat(assign, ' ')
    end

    function assert(c, str)
        if c then return end
        if str then LogError(str) end
        -- LuaLog(debug.traceback())
        assertfun() --故意写错的, 就是要在这里报错
    end

    if _G.debug_model then
        LuaLog = LuaLog or print
        Log = Log or table.print
        LogTrace = LogTrace or function ( ... )
            LuaLog(...)
            LuaLog(debug.traceback())
        end

        LogDebug = LogDebug or function (s,  ... )
            LuaLog(string.format(s, ...))
        end
        LogDebugEx = LogDebugEx or function ( ... )
            LuaLog(...)
        end
        LogTable = LogTable or function (t, key)
            LuaLog(key, t)
        end
        DT = LogTable
        LogInfo = function(s, ... )
            LuaLog(string.format(s, ...))
        end

        OPENDEBUG = OPENDEBUG or function () end
    else
        LogTrace = function() end
        LogDebug = function() end
        LogDebugEx = function() end 
        LogTable = function() end 
        LogInfo = function() end 
        DT = function() end 
        OPENDEBUG = function() end 
    end

    local arr = 
    {
        "1","2","3","4","5","6","7","8","9","0",
        "a","b","c","d","e","f","g",
        "h","i","j","k","l","m","n",
        "o","p","q","r","s","t",
        "u","v","w","x","y","z"
    }
    local len = #arr
    function UUID(w)
        w = w or 16
        local str = ""
        for i=1,w do
            local r = math.random(len)
            str = str .. arr[r]
        end
        return str
    end

    -- 判定表是否为空
    function table.empty(t)
        if type(t) ~= "table" then
            ASSERT()
            return
        end
        for k,v in pairs(t) do
            return
        end
        return true
    end

    function table.Decode(str)
        if not str or str == "" then
            return
        end
        --print("table.Decode =", str)
        local fun = loadstring("local s=" .. str .. " return s")
        -- local fun = loadstring(str)
        if not fun then
            LogError("table.Decode str: %s", str)
            return
        end
        return fun()
    end

    -- 转json格式(去掉空table以减小字符串长度)
    function table.Encode(t)
        -- LogTable(t, "table size="..#t)
        if not t then
            return nil
        end

        local function ser_table(tbl, deep)
            local rettree = {}
            
            local k,v = next(tbl)
            -- 数组部分
            -- print("11数组部分",k,v)
            if #tbl > 0 and k == 1 then
                for i=1,#tbl do
                    if type(v) == "number" then
                        table.insert(rettree, v)
                    elseif type(v) == "string" then
                        table.insert(rettree, string.format("%q", v))
                    elseif type(v) == "table" then
                        if not table.empty(v) then
                            table.insert(rettree, ser_table(v, deep + 1))
                        else
                            table.insert(rettree, "{}") -- 数组不能为空, 否则下标会变
                        end
                    elseif type(v) == "boolean" then
                        table.insert(rettree, tostring(v))
                    end

                    k,v = next(tbl, k)
                    -- print("11数组部分",#tbl, i, k, v)
                    -- lua本身的bug, #号取数组长度, 凡是2的n次方上面有数字, 就算中间断了也是返回n
                    -- 所以到这里就断了
                    if k ~= i+1 then break end
                end
            end

            -- print("k = ", k)
            -- map部分
            while k do
                local key = type(k) == "number" and "[" .. k .. "]" or k --"[".. string.format("%q", k) .."]"
                if type(v) == "number" then
                    table.insert(rettree, key .. "=" .. v)
                elseif type(v) == "string" then
                    table.insert(rettree, key .. "=" .. string.format("%q", v))
                elseif type(v) == "table" then
                    if not table.empty(v) then
                        table.insert(rettree, key .. "=" .. ser_table(v, deep + 1))
                    end
                elseif type(v) == "boolean" then
                    table.insert(rettree, key .. "=" .. tostring(v))
                end
                k,v = next(tbl, k)
                -- print("map部分",k,v)
            end
            return "{"..table.concat(rettree, ",").."}"
        end
        
        return ser_table(t, 1)
        -- return "local s=" ..ser_table(t, 1) .. " return s"
    end

    function SplipLine(str, p1)
        local r = {}

        if str == nil then return r end

        if p1 == nil then p1 = "\t" end
        local index = 1

        local str1 = str
        while str1 do
            local str2 = str1

            local n = string.find(str2, p1)
            if n == nil then r[index] = str2 return r end

            r[index] = string.sub(str2, 1, n-1)
            str1 = string.sub(str2, n+1, #str2)

            index = index + 1
        end

        return r
    end

    function LineParser(line)
        
        if not line then return end

        -- linux 不用\r结尾
        line = string.gsub(line, "\r", "")
        return SplipLine(line)
    end
    
    function Trim(s)
        return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
    end
    -------------------------------------------------
    -- 算法

    local SortFunDesc = function(a, b, attr)
        return a[attr] > b[attr]
    end

    -- 排序并返回前num个列表(降序)
    function SortRankDesc(arr, attr, num, sortfun)
        local list = {}

        num = num or #arr
        if num > #arr then 
            num = #arr
        end

        sortfun = sortfun or SortFunDesc

        for i=1,num do
            for j=#arr,i+1,-1 do
                if sortfun(arr[j], arr[j-1], attr) then
                    tmp = arr[j]
                    arr[j] = arr[j-1]
                    arr[j-1] = tmp
                end
            end
            table.insert(list, arr[i])
        end
        return list
    end

    -- 排序并返回前num个列表(升序)
    function SortRankAsc(arr, attr, num, sortfun)
        local list = {}

        num = num or #arr
        if num > #arr then 
            num = #arr
        end

        sortfun = sortfun or SortFunDesc

        for i=1,num do
            for j=#arr,i+1,-1 do
                if sortfun(arr[j-1], arr[j], attr) then
                    tmp = arr[j]
                    arr[j] = arr[j-1]
                    arr[j-1] = tmp
                end
            end
            table.insert(list, arr[i])
        end
        return list
    end
    
    --暂停
    function Pause()
        LogTrace()
    end


    StatsMgr = {}
    function StatsMgr:AddLogRecord()
    end
else
    --暂停
    function Pause(str)
        LogDebug(str)
        LogTrace()
        return os.execute("pause")
    end
end

OPENDEBUG(false)

function table.ReadOnly(t)
    t = t or {}
    local mt = {
        __index = function(t,k) 
            local val = rawget(t, k)
            if type(val) == "table" then
                return table.copy(val)
            end
            return val
        end,
        __newindex = function(t, k, v)
            error("attempt to update a read-only table!")
        end
    }

    setmetatable(t, mt)
    return t
end

-- table 拷贝
function table.copy(src, cpy)

    if type(src) ~= "table" then
        return nil
    end

    cpy = cpy or {}

    for i,v in pairs(src) do
        local vtyp = type(v)
        if (vtyp == "table") then
            cpy[i] = table.copy(v)
        else
            cpy[i] = v
        end
    end
    return cpy
end

-- table长度
function table.size(o)
    if not o then
        return nil
    end

    local k,v
    local ret = 0
    while true do
        k, v = next(o, k)
        if k == nil then break end
        ret = ret + 1
    end

    return ret
end

-- 弱引用表
function WeakTable()
    local t = {}
    setmetatable(t, {__mode = "kv"})
    return t
end

------------------------------------------------------------------------------------------------
-- 弱引用表

-- 使用示例
-- LogInfo("Test weak table")
-- local tbA = {}
-- local tbB = {}
-- local TestWeakTableFun = function()
--     local tmbA = { 1, 2, 3, 4, 5}
--     local tmbB = { 1, 2, 3, 4, 5, fbFun = function() LogInfo("fun or tmbB") end}

--     tbA = tmbA
--     tbB = WeakObjTable(tmbB)
    
--     tbB:fbFun()
-- end

-- TestWeakTableFun()

-- collectgarbage('collect')

-- LogTable(tbA, "tbA:")
-- LogTable(tbB, "tbB:")

-- 结果： 回收资源后，tmbB 被回收，所以 tbB 里面的 回收资源后，tmbB 被自动删除， 但是 tbA 保持引用
-- [16:29:13][INFO] Test weak table
-- [16:29:13][INFO] fun or tmbB
-- [16:29:13][DEBUG] tbA:
--     {
--         [ 1 ]n = [ 1 ]f
--         [ 2 ]n = [ 2 ]f
--         [ 3 ]n = [ 3 ]f
--         [ 4 ]n = [ 4 ]f
--         [ 5 ]n = [ 5 ]f
--     }
-- [16:29:13][DEBUG] tbB:
--     {

--     }

function WeakObjTable(tb)
    -- t : 为代理table
    local t = {
        Obj = function()
            return t[1]
        end
    }

    -- 将 t 设置为一个弱表，那么 tb 引用为0的时候，会自动从 t 里面移除
    setmetatable(t, {
        __mode = "kv",
        __index = function (self, k)
            -- 索引变量与函数的时候，转给 tb
            local obj = self[1]
            return obj[k]
        end,
        __newindex = function (self, k, v)
            -- 新建变量时转给 tb
            local obj = self[1]
            obj[k] = v
        end
    })
    
    -- 将 tb 保存到 t 的第一个位置
    table.insert(t, tb)

    return t
end

mapDebugTable = {}
function table.CreateDebug(t)
    local res = {table = t, debug = {}}
    mapDebugTable[res] = res

    local mt = 
    {
        __index = 
        function (t, k)
            local data = mapDebugTable[t]
            local real = data.table
            return real[k]
        end,
        __newindex = 
        function (t, k, v)
            local data = mapDebugTable[t]
            local real = data.table
            if not k then return end
            if data.debug[k] then 
                if IST(v) or IST(real[k]) then
                    LogTable(v, "debug["..k.."].v = ")
                    LogTable(real[k], "debug["..k.."].oldv = ")
                    LogError("debuging----"..k)
                else
                    LogError("debug[%s] = %s: old val = %s", k, v, real[k])
                end
            end
            real[k] = v
        end,
    }

    setmetatable(res, mt)

    function res:Debug(key)
        res.debug[key] = true 
    end
    return res
end

function table.Debug(res, key)

    if not mapDebugTable[res] then 
        assert(nil, "need to call table.CreateDebug(table)")
        return 
    end

    mapDebugTable[res].debug[key] = true 
    
    return t
end

-- ipairs循环, 若其中有移除操作的话, 会导致循环少了一次, 导致出现bug
-- 此处对循环体做了优化
function SafeIpairs(tab, fun)
    if #tab == 0 then return end
    local t = {}
    for i,v in ipairs(tab) do
        table.insert(t, v)
    end
    for i,v in ipairs(t) do
        fun(i,v)
    end
end

-- 复制ipairs列表保证ipairs循环完整正确
function CopyIpairs(tab)
    local t = {}
    for i,v in ipairs(tab) do
        table.insert(t, v)
    end
    return t
end

-- 标准化 a限定在[0,1]之间
function Normalization(a)
    return LimitNum(a,0,1)
end

--a限定在[limitdown, limitup]之间
function LimitNum(a, limitdown, limitup)
    if a >= limitup then return limitup end
    if a <= limitdown then return limitdown end
    return a
end

local arr = 
{
    "1","2","3","4","5","6","7","8","9","0",
    "a","b","c","d","e","f","g",
    "h","i","j","k","l","m","n",
    "o","p","q","r","s","t",
    "u","v","w","x","y","z"
}
local len = #arr
function UID(w)
    local str = ""
    for i=1,w do
        local r = math.random(len)
        str = str .. arr[r]
    end
    return str
end

-- 格式化字符串
function STR(...)
    return string.format(...);
end

L = STR