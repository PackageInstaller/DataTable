Loader:Require('SvnVersion')
Loader:AddReplaceFile('SvnVersion')

Loader:Require('GEnum')
Loader:Require('GComLogicCheck')

local CfgBase = Loader:Require('CfgBase')

-------------------------------------------------
-- 配置表处理
local os = require('os')

Cfgs = {}
ConfigParser = {
    m_mapConfigList = {},
    m_mapTableInfo = {}
    -- 配置表对应的文件名信息
}

function ConfigParser:SplipLine(str, p1)
    local r = {}

    if str == nil then
        return r
    end

    if p1 == nil then
        p1 = '\t'
    end
    local index = 1

    local str1 = str
    while str1 do
        local str2 = str1

        local n = string.find(str2, p1)
        if n == nil then
            r[index] = str2
            return r
        end

        r[index] = string.sub(str2, 1, n - 1)
        str1 = string.sub(str2, n + 1, #str2)

        index = index + 1
    end

    return r
end

function ConfigParser:LineParser(line)
    if not line then
        return
    end

    -- linux 不用\r结尾
    line = string.gsub(line, '\r', '')
    return self:SplipLine(line)
end

-- 格式化数值
function ConfigParser:FormatValue(val, typ)
    -- print("FormatValue", val, typ)
    -- LogDebug("##%s##", val)
    if typ == 'int' then
        if not val or val == '' then
            return
        end
        if not tonumber(val) then
            print('int val is illegality :' .. val)
            assert()
            return
        end
        return math.floor(tonumber(val))
    elseif typ == 'float' then
        return tonumber(val)
    elseif typ == 'string' then
        if val == '' then
            return nil
        end
        return val
    elseif typ == 'text' then
        if val == '' then
            return nil
        end
        return val
    elseif typ == 'bool' then
        if not val or val == '0' or val == 0 or val == '' then
            return false
        else
            return true
        end
    elseif typ == 'json' then
        -- val = "{"..val.."}"
        -- print(val)
        if val == '' then
            return nil
        end
        return Json.Decode(val)
    else
        -- 处理数组
        local n = string.find(typ, '[]', 1, true)
        if n ~= nil then
            if val == '' then
                return nil
            end
            local arrtyp = string.sub(typ, 1, n - 1)
            local arr = self:SplipLine(val, ',')

            for i, v in ipairs(arr) do
                arr[i] = self:FormatValue(v, arrtyp)
            end

            return arr
        else
            print('FormatValue', val, typ)
            LogDebug('unkown type of ' .. typ .. ', val = ' .. val)
            LogTrace()
            assert()
        end
    end
end

function ConfigParser:FormatTable(config, row, col, colnum)
    -- LogDebugEx("FormatTable", row, col, colnum)
    ASSERT(config.types[col + colnum], '二维数组表格列数大于实际列数')
    local tablelen = #config.data
    local ret = {}
    local rownum = 0

    for i = row + 1, tablelen do
        local val = config.data[i][col + 1]
        if not val or val == '' then
            break
        end
        rownum = rownum + 1
    end

    -- if config.sheetname == "礼物" then
    --     LogTable(config, "CfgGifts: colnum:" .. colnum .. " rownum:" .. rownum)
    -- end

    for i = row + 1, row + rownum do
        local data = config.data[i]
        local key = self:FormatValue(data[col + 1], config.types[col + 1])
        ret[key] = {}
        for j = col + 1, col + colnum do
            local name = config.names[j]
            local typ = config.types[j]

            -- if config.sheetname == "礼物" then
            --     print("key:", key, "j:", j, "name:", name, "typ:", typ)
            -- end

            ret[key][name] = self:FormatValue(data[j], typ)

            -- if config.sheetname == "礼物" then
            --     LogTable(ret, "Ret:")
            -- end
        end
    end
    -- DT(ret, "FormatTable "..rownum)
    return rownum, ret
end

function ConfigParser:GetTableSize(typ)
    local n = string.find(typ, 'table', 1, true)
    if n ~= nil then
        -- 读取子表
        local t = self:SplipLine(typ, '#')
        return tonumber(t[2])
    end
end

-- 合成表
function ConfigParser:Union()
    -- _G[filename]
    -- 表联合配置
    for k, v in pairs(ConfigUnion) do
        LogDebugEx('合成 ' .. v.name .. '=>' .. v.sUnionName)

        local unionTb = {}

        local allNames = {}
        local mapTb = {arrUnion = {}, sheetname = v.sUnionName, names = {}}
        self.m_mapTableInfo[v.sUnionName] = mapTb

        for _, item in ipairs(v.item) do
            -- LogDebugEx("--"..item.sCfgName..":"..item.sCfgKey)
            local cfgName = item.sCfgKey
            local cfgs = _G[cfgName]
            if cfgs then
                for _, cfg in pairs(cfgs) do
                    -- ASSERT(not _unionTb[key], "重复的id"..key)
                    if unionTb[cfg.id] then
                        ASSERT(false, string.format('配置表:%s, 的id:%s, 重复', cfgName, cfg.id))
                    end
                    unionTb[cfg.id] = cfg
                end

                _G[cfgName] = nil

                self.m_mapConfigList[cfgName] = nil

                local tmpCfgStructInfo = self.m_mapTableInfo[cfgName]
                table.insert(mapTb.arrUnion, tmpCfgStructInfo)
                mapTb.filename = tmpCfgStructInfo.filename

                -- 记录字段名字
                for _, name in ipairs(tmpCfgStructInfo.names) do
                    allNames[name] = 1
                end
            end
        end

        for name, _ in pairs(allNames) do
            table.insert(mapTb.names, name)
        end

        _G[v.sUnionName] = unionTb
        self.m_mapConfigList[v.sUnionName] = v.sUnionName
    end
end

function ConfigParser:PrintByCar(char, charCnt, val)
    LogInfo(string.rep(char, charCnt) .. val)
end

function ConfigParser:SimpleShowTable(tb, title, deep)
    deep = deep or 1
    local charLen = deep * 4
    self:PrintByCar(' ', charLen, title)
    self:PrintByCar(' ', charLen, '{')
    for k, v in pairs(tb) do
        local vType = type(v)
        if vType == 'table' then
            self:SimpleShowTable(v, k, deep + 1)
        else
            self:PrintByCar(' ', charLen + 4, k .. ':' .. v .. '[' .. vType .. ']')
        end
    end
    self:PrintByCar(' ', charLen, '}')
end

-- 读取配置表到内存
function ConfigParser:ReadOneConfig(filename)
    local fullfileName = 'cfg' .. filename
    package.loaded[fullfileName] = nil
    local config = require(fullfileName)

    -- Loader:AddReplaceFile(filename)
    LogInfo("Read[ " .. fullfileName .. " ]from[ " .. config.filename .. " ]->[ " .. config.sheetname .. "]")
    local takeColInfo = {}
    if config then
        self.m_mapTableInfo[filename] = {
            filename = config.filename,
            sheetname = config.sheetname,
            names = config.names,
            types = config.types
        }

        local newCfgs = {}

        local currrow = 0
        for k, data in ipairs(config.data) do
            local function TmpXpcallCB(msg, ...)
                LogInfo('-------------------配置表出错---------------------')
                LogInfo(config.filename .. '的 ' .. config.sheetname .. ' 第' .. (k + 5) .. '行')
                self:SimpleShowTable(takeColInfo, '报错的列信息:')
                LogInfo('LUA ERROR: ' .. tostring(msg) .. '\n')
                LogInfo(debug.traceback())
                self:SimpleShowTable({...}, 'TmpXpcallCB:')
                LogInfo('----------------------------------------')
            end

            local tmpRetOnLineFun = function()
                -- 导表工具，xpcall 只接受一个回调函数
                currrow = self:ReadOneLineLuaConfig(filename, newCfgs, config, currrow, k, data, takeColInfo)
            end

            local isCallOk = xpcall(tmpRetOnLineFun, TmpXpcallCB)
            if not isCallOk then
                ASSERT(false, config.filename .. '的 ' .. config.sheetname .. ' 第' .. (k + 5) .. '行')
            end
        end

        _G[filename] = newCfgs
        _G[fullfileName] = nil
    end

    package.loaded[fullfileName] = nil
    -- LogInfo("loaded %s", fullfileName)
    -- table.print(_G[filename])
    ASSERT(_G[filename])
end

-- 读取配置表到内存
function ConfigParser:ReadLuaConfig()
    for k, filename in pairs(self.m_mapConfigList) do
        -- local t = os.clock()
        ConfigParser:ReadOneConfig(filename)
        -- local t2=(os.clock() - t)
        -- if t2>0.1 then
        --     print("读取"..filename.."耗时"..t2)
        -- end
    end
end

function ConfigParser:ReadOneLineLuaConfig(filename, newCfgs, config, currrow, k, data, takeColInfo)
    if currrow >= k then
        -- 跳过二级table表结构的行
        -- print("ignore sub item ", k)
        return currrow
    end

    local tableRowNum = 0
    local t = {}
    local currcol = 0
    for i, name in ipairs(config.names) do
        if currcol >= i then
        else
            currcol = i
            local typ = config.types[i]

            takeColInfo['列名: '] = name
            takeColInfo['列类型: '] = typ

            if typ ~= '' then
                local num = self:GetTableSize(typ)
                if num and num > 0 then
                    local rownum, ret = self:FormatTable(config, k, i, num)
                    if rownum > 0 then
                        t[name] = ret
                        currcol = i + num
                        tableRowNum = tableRowNum < rownum and rownum or tableRowNum
                    else
                        t[name] = {}
                    end
                else
                    t[name] = self:FormatValue(data[i], config.types[i])
                end
            end
        end
    end

    currrow = k + tableRowNum

    if not t.key then
        t.key = t.id
    end

    if not t.id then
        LogTable(t, "ReadOneLineLuaConfig not id row data:")
    end

    if newCfgs[t.id] then
        LogTable(t, 't:')
        LogTable(newCfgs, 'newCfgs:')

        local info = self.m_mapTableInfo[filename]
        ASSERT(false, info.filename .. '-[' .. info.sheetname .. ']表中存在重复的id:' .. t.id)
    else
        newCfgs[t.id] = t
    end

    return currrow
end


function ConfigParser:SetGolble()
    -- 代码移动到，ConfigChecker:global_setting(cfgs)
    if IS_CLIENT then
        -- 导表工具
        if IS_CLIENT_TOOL then
            ConfigChecker:global_setting(_G["global_setting"])
            ConfigChecker:CfgEquipSkill(_G["CfgEquipSkill"])
            ConfigChecker:CfgDupDropCntAdd(_G["CfgDupDropCntAdd"])
            ConfigChecker:CfgFriendConst(_G["CfgFriendConst"])

            return
        end

        -- 做loading延迟, 这里集中处理加载配置表
        local count = 0
        local size = table.size(self.listClientConfig)
        if size <= 0 then size = 1 end
        local laodfunlist = {}

        for i,v in ipairs(self.listClientConfig) do
            local fun = function ()
                LoadOneConfig(v)
                count = count + 1 
                local p = math.ceil((count/size)*50)
                print("ClientConfig", count, size,p)
                EventMgr.Dispatch(EventType.Read_Cfg_Progress,p);
                if count == size then 
                    -- 读取所有配置表完成, 设置全局变量和生成客户端所需的配置格式
                    -- EventMgr.Dispatch(EventType.Read_Cfg_Complete);
                    ConfigChecker:global_setting(_G["global_setting"])
                    ConfigChecker:CfgEquipSkill(_G["CfgEquipSkill"])
                    ConfigChecker:CfgDupDropCntAdd(_G["CfgDupDropCntAdd"])
                    ConfigChecker:CfgFriendConst(_G["CfgFriendConst"])
                    self:ClientConfig3()
                end
            end

            table.insert(laodfunlist, fun)
        end

        function OnTimer()

            if #laodfunlist == 0 then return end  
            local c = 50 
            if #laodfunlist < c then 
                c=#laodfunlist
            end

            for i=1,c do
                laodfunlist[1]()
                table.remove(laodfunlist, 1)
            end

            if #laodfunlist > 0 then 
                FuncUtil:Call(OnTimer,nil,1);
            end
        end

        FuncUtil:Call(OnTimer,nil,1);


        -- ConfigChecker:global_setting(_G["global_setting"])
        -- ConfigChecker:CfgEquipSkill(_G["CfgEquipSkill"])
        -- ConfigChecker:CfgDupDropCntAdd(_G["CfgDupDropCntAdd"])
        -- ConfigChecker:CfgFriendConst(_G["CfgFriendConst"])
    end
end

function ConfigParser:GenCfgList(ConfigList)
    -- 真正有效的配置表
    self.m_mapConfigList = {}
    for k, v in pairs(ConfigList) do
        self.m_mapConfigList[v] = v
    end
end

function ConfigParser:GetCfgSheetName(cfgName)
    -- LogTable(self.m_mapTableInfo[cfgName], 'm_mapTableInfo')
    -- LogTable(self.m_mapConfigList[cfgName], 'm_mapConfigList')
    local cfgStructInfo = self.m_mapTableInfo[cfgName]
    return cfgStructInfo.sheetname
end

function ConfigParser:ClientConfig()
    -- local this = {};
    -- _G.CfgBase = Loader:Require('CfgBase');
    -- print("--------ClientConfig---------------")
    -- local count = 0
    -- local size = table.size(self.m_mapConfigList)
    -- if size <= 0 then size = 1 end

    for k, v in pairs(self.m_mapConfigList) do
        LogDebugEx('load config:' .. k)
        local initData = _G[k]
        if initData then
            Cfgs[k] = CfgBase:New(k)
            Cfgs[k]:Init(_G[k])
            -- count = count + 1 
            -- if IS_CLIENT then
            --     local p = math.ceil(count/size)
            --     LogDebugEx("ClientConfig", count)
            --     EventMgr.Dispatch(EventType.Read_Cfg_Progress,p);
            -- end

            -- if _G[k][1] and _G[k][1].group then
            --     LogDebug(k)
            -- end
        else
            if LogError then
                LogError('ConfigParser:ClientConfig()' .. k .. 'get nil')
            else
                print('ConfigParser:ClientConfig() ', k, 'get nil')
            end
        end
    end

    -- if IS_CLIENT then
    --     EventMgr.Dispatch(EventType.Read_Cfg_Complete);
    -- -- ASSERT()
    -- end

    -- 需要全部配置检查完才检查的配置，key为表名，value随便配的
    local FinallyCheckConfig = {
        AvatarFrame = 1
        , CfgAvatar = 1
        , CfgShopPage = 1
        , CfgReturningActivity = 1
        , MainLine = 1
        , CfgMenuBg = 1
        , CfgItemPool = 1
        , CfgIconTitle = 1
        , CfgIconEmote = 1
        , CfgDormPet = 1
        , CfgRoleTrainGuide = 1 -- v 5.6 角色培养引导
    }

    -- 检查/特殊处理以及设为只读
    for cfgName, _ in pairs(self.m_mapConfigList) do
        if ConfigChecker[cfgName] and not FinallyCheckConfig[cfgName] then
            local result, errmsg = pcall(ConfigChecker[cfgName], ConfigChecker, _G[cfgName])
            if errmsg then
                print(result, errmsg)
                ASSERT(false, '配置表出错' .. cfgName.. ", errmsg = "..errmsg)
            end
        end
    end

    -- 检查/特殊处理以及设为只读(再检查一遍配置)
    for cfgName, _ in pairs(FinallyCheckConfig) do
        if self.m_mapConfigList[cfgName] then
            if ConfigChecker[cfgName] then
                local result, errmsg = pcall(ConfigChecker[cfgName], ConfigChecker, _G[cfgName])
                if errmsg then
                    print(result, errmsg)
                    ASSERT(false, '配置表出错' .. cfgName .. ", errmsg = "..errmsg)
                end
            end
        end
    end

    -- 主键关联检查
    ConfigChecker:CheckPrimaryKey()
    ConfigChecker:CheckDungeon()

    -- 设置为只读
    -- for cfgName, _ in pairs(self.m_mapConfigList) do
    --     local cfgs = _G[cfgName]
    --     for k, cfg in pairs(cfgs) do
    --         cfgs[k] = table.ReadOnly(cfg)
    --     end

    --     _G[cfgName] = table.ReadOnly(cfgs)
    -- end


    

    -- print("xxxxxxxxxx")
    local mt = {
        __index = function(t,k) 
            -- print("ReadAllConfig", k)
            local val = rawget(t, k)
            if val == nil then
                local t = ConfigParser:LoadConfig(k)
                return t
            end
            return val
        end,
    }

    setmetatable(Cfgs, mt)

    return Cfgs
end

function ConfigParser:ClientConfig2()
    -- local this = {};
    -- _G.CfgBase = Loader:Require('CfgBase');

    if IS_CLIENT_TOOL then
        print("--------ClientConfig---------------", IS_CLIENT)

        for k, v in pairs(self.m_mapConfigList) do
            LogDebugEx('load config:' .. k)
            local initData = _G[k]
            if initData then
                Cfgs[k] = CfgBase:New(k)

                local fun = function ()
                    Cfgs[k]:Init(_G[k])

                end

                -- if _G[k][1] and _G[k][1].group then
                --     LogDebug(k)
                -- end
            else
                if LogError then
                    LogError('ConfigParser:ClientConfig()' .. k .. 'get nil')
                else
                    print('ConfigParser:ClientConfig() ', k, 'get nil')
                end
            end
        end
        
        local mt = {
            __index = function(t,k) 
                print("ReadAllConfig", k)
                local val = rawget(t, k)
                if val == nil then
                    local t = ConfigParser:LoadConfig(k)
                    return t
                end
                return val
            end,
        }

        setmetatable(Cfgs, mt)

        return Cfgs
    end
end

-- 做loading延迟, 在读完配置表后调用
function ConfigParser:ClientConfig3()
    print("--------ClientConfig---------------", IS_CLIENT)
    local count = 0
    local size = table.size(self.m_mapConfigList)
    if size <= 0 then size = 1 end
    local funlist = {}

    for k, v in pairs(self.m_mapConfigList) do
        LogDebugEx('load config:' .. k)
        local initData = _G[k]
        if initData then
            Cfgs[k] = CfgBase:New(k)

            local fun = function ()
                Cfgs[k]:Init(_G[k])

                count = count + 1 
                -- if IS_CLIENT then
                    local p = math.ceil((count/size)*50) + 50
                    print("ClientConfig", count, size,p)
                    EventMgr.Dispatch(EventType.Read_Cfg_Progress,p);
                -- end
                if count == size then 
                    -- 完成所有配置的生成, 结束loading
                    EventMgr.Dispatch(EventType.Read_Cfg_Complete);
                end
            end

            table.insert(funlist, fun)

            -- if _G[k][1] and _G[k][1].group then
            --     LogDebug(k)
            -- end
        else
            if LogError then
                LogError('ConfigParser:ClientConfig()' .. k .. 'get nil')
            else
                print('ConfigParser:ClientConfig() ', k, 'get nil')
            end
        end
    end


    function OnTimer()

        if #funlist == 0 then return end  
        local c = 50 
        if #funlist < c then 
            c=#funlist
        end

        for i=1,c do
            funlist[1]()
            table.remove(funlist, 1)
        end

        if #funlist > 0 then 
            FuncUtil:Call(OnTimer,nil,1);
        end
    end

    FuncUtil:Call(OnTimer,nil,1);

    -- print("xxxxxxxxxx")
    local mt = {
        __index = function(t,k) 
            print("ReadAllConfig", k)
            local val = rawget(t, k)
            if val == nil then
                local t = ConfigParser:LoadConfig(k)
                return t
            end
            return val
        end,
    }

    setmetatable(Cfgs, mt)

    return Cfgs
end

function ConfigParser:LoadConfig(filename)
    print("--------LoadConfig------------", filename)
    ConfigParser:ReadOneConfig(filename)
    Cfgs[filename] = CfgBase:New()
    Cfgs[filename]:Init(_G[filename])
    return Cfgs[filename]
    -- LogError(Cfgs[filename])
end


function LoadOneConfig(filename)
    -- print("--------LoadConfig2------------", filename)
    require("cfg"..filename)
    Cfgs[filename] = CfgBase:New()
    Cfgs[filename]:Init(_G[filename])
    return Cfgs[filename]
    -- LogError(Cfgs[filename])
end

function ConfigParser:LoadConfig2(filename)

    if not self.isClientInit then
        self.listClientConfig = self.listClientConfig or {}
        LoadOneConfig(filename)
    else
        -- 做loading延迟
        self.listClientConfig = self.listClientConfig or {}
        table.insert(self.listClientConfig, filename)
    end
end