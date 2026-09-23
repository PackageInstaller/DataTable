-- Loader 主要有以下作用
-- 1：记录需要批量重载的文件
-- 2：记录需要重载替换的文件
-- 3：记录文件祖册了那些全局变量
-- 4：设置重载完之后的回调函数
-- 5：主要重载操作放在 require_ex.lua 文件执行，因为可以这样，可以先重载那个文件

Loader = {
    m_files = {}, -- 所有文件名
    m_HadAddFileName = {}, -- 防止文件名重复
    m_replaceFiles = {}, -- 记录直接替换的文件名
    m_afterLoadFun = nil, -- 加载完的回调函数
    m_hadRegisterGobalVal = {}, -- 记录每个文件注册了那些全局模块
    m_preReloadTime = 0
}

-- 加载文件
function Loader:Require(file)
    local requireRet = require(file)
    if requireRet then
        self:AddFileName(file)
    end
    return requireRet
end

-- 添加文件名
function Loader:AddFileName(file)
    if self.m_HadAddFileName[file] then
        -- LogDebug("Loader:AddFileName(%s) repeat add, so ignore it! ", file)
        return false
    end

    table.insert(self.m_files, file)
    self.m_HadAddFileName[file] = true
    return true
end

-- 获取文件注册了那些全局变量
function Loader:GetHadRegisterGobalVal(sName)
    return self.m_hadRegisterGobalVal[sName]
end

-- 显示文件注册了那些全局变量
function Loader:ShowtHadRegisterGobalVal()
    LogTable(self.m_hadRegisterGobalVal, 'Loader:ShowtHadRegisterGobalVal()')
end

-- 显示那些文件时直接替换的
function Loader:ShowReplaceFiles()
    LogTable(self.m_replaceFiles, 'Loader:m_replaceFiles()')
end

-- 显示那些文件记录了
function Loader:ShowRegisterFiles()
    LogTable(self.m_files, 'Loader:ShowRegisterFiles()')
end

-- 添加替换文件
function Loader:AddReplaceFile(file)
    self.m_replaceFiles[file] = true
end

-- 判断是否直接替换
function Loader:IsReplaceFile(file)
    return self.m_replaceFiles[file]
end

-- 监听全局表的设置
function Loader:SetGobalTbMeta()
    local oMeta = getmetatable(_G) or {}

    -- 舰艇全局表的新建操作
    oMeta['__newindex'] = function(_, key, value)
        local info = debug.getinfo(2, 'S')
        -- for k, v in pairs(info) do
        --     print(k, v)
        -- end

        -- 记录文件名下所记载的函数
        local shortName = info.short_src
        local len = string.len(shortName)
        local moduleName = ''
        for i = len, 1, -1 do
            local char = string.sub(shortName, i, i)
            if char == '/' or char == '\\' then
                moduleName = string.sub(shortName, i + 1, len - 4)
                break
            end
        end

        -- print(info.short_src, "=>", moduleName)
        local hadLoadVals = Loader.m_hadRegisterGobalVal[moduleName]
        if not hadLoadVals then
            hadLoadVals = {}
            Loader.m_hadRegisterGobalVal[moduleName] = hadLoadVals
        end

        hadLoadVals[key] = type(value)

        return rawset(_G, key, value)
    end

    setmetatable(_G, oMeta)

    -- local mt = {
    --     __index = function(_, key)
    --         local info = debug.getinfo(2, "S")
    --         if info and info.what ~= "main" and info.what ~= "C" then
    --             print("访问不存在的全局变量：" .. key)
    --         end
    --         return rawget(_G, key)
    --     end,
    --     __newindex = function(_, key, value)
    --         local info = debug.getinfo(2, "S")
    --         if info and info.what ~= "main" and info.what ~= "C" then
    --             print("赋值不存在的全局变量：" .. key)
    --         end
    --         return rawset(_G, key, value)
    --     end
    -- }
    -- setmetatable(_G, mt)
end

-- 设置每次加载后的回调函数
function Loader:SetAfterReloadFun(fun)
    self.m_afterLoadFun = fun
end

-- nFile: 全部更新的时候，传 nil, 更新单个文件，传文件名
--
function Loader:AfterLoad(...)
    if self.m_afterLoadFun then
        self.m_afterLoadFun(self, ...)
    end
end

-- 获取记录的所有文件
function Loader:GetRegisterFiles()
    return self.m_files
end

function Loader:ResetRegisterFiles()
    self.m_files = {}
    self.m_HadAddFileName = {}
end

function Loader:PreReloadTime(setTime)
    if setTime then
        self.m_preReloadTime = setTime
    end

    return self.m_preReloadTime
end

function Loader:OnLoop()
    if self.m_onLoopFun then
        return xpcall(self.m_onLoopFun, XpcallCB)
    end
end

function Loader:SetOnLoop(onLoopFun)
    self.m_onLoopFun = onLoopFun
end

function Loader:OnStart()
    if self.m_onStartFun then
        return xpcall(self.m_onStartFun, XpcallCB)
    end

    return true
end

function Loader:SetOnStart(onStartFun)
    self.m_onStartFun = onStartFun
end

function Loader:OnStop()
    if self.m_onStopFun then
        return xpcall(self.m_onStopFun, XpcallCB)
    end
end

function Loader:SetOnStop(onStopFun)
    self.m_onStopFun = onStopFun
end
