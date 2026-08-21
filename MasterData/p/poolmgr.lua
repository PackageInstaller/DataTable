local baseFree = PoolManager.Free

---@class PoolMgr:PoolManager
local PoolMgr = class("PoolMgr", function (...)
    return PoolManager.Instance
end)

function PoolMgr:ctor(...)
    ---@type table<string, UnityEngine.GameObject> 使用LoadManager加载了的GameObject会被管理在这里，并利用PoolManager的SpawnTemplate来进行实例创建
    self.objList = {}
    ---@type table<string, boolean> 正在加载的GameObject列表
    self.loadingList = {}
    ---@type table<string, fun(obj:UnityEngine.GameObject)> 等待加载的GameObject列表
    self.waitList = {}
end

function PoolMgr:_CheckWaitList(path)
    local funcList = self.waitList[path]
    if funcList then
        for _, func in ipairs(funcList) do
            self:Get(path, func.callback, func.owner)
        end
        self.waitList[path] = nil
    end
end
---@param path string
---@param callback fun(obj:UnityEngine.GameObject)
function PoolMgr:Get(path, callback, owner)
    -- 始终使用 PoolMgr 专用 carrier，与 LuaMain 解耦
    owner = ResMgr:GetPoolResCarrier()

    local obj1 = self.objList[path]
    if obj1 then
        self.SpawnTemplateAsync(owner, obj1, function (obj)
            if (callback) then
                callback(obj)
            end
        end)

    elseif self.loadingList[path] == true then
        if self.waitList[path] == nil then
            self.waitList[path] = {}
        end
        local l = self.waitList[path]
        l[#l + 1] = {callback = callback, owner = owner}
    else 
        self.loadingList[path] = true
        ResMgr:LoadPrefabAsyncInOwner(path, function (obj)
            self.loadingList[path] = false
            if (obj) then

                local GenerateNext = function ()
                    local template = self.objList[path]
                    self.SpawnTemplateAsync(owner, template, function (newObj)
                        if (callback) then
                            callback(newObj)
                        end
                        self:_CheckWaitList(path)
                    end)
                end

                if self.objList[path] == nil then
                    -- self.InstantiateAsync(owner, obj, function (go, index)
                        if (obj) then
                            self.objList[path] = obj
                            -- self.objList[path].transform:SetParent(self.objRoot.transform, false)
                            -- self.objList[path]:SetActive(false)
                            GenerateNext()
                        end
                    -- end, 1)
                else
                    GenerateNext()
                end
            else
                if (callback) then
                    callback(obj)
                end
            end
        end, owner)
    end
end

function PoolMgr:InstantiateGameObjectAsync(owner, template, callback, num)

    if num == nil then
        num = 1
    end

    self.InstantiateAsync(owner, template, function (go, index)
        if (go) then
            if callback then
                callback(go, index)
            end
        else
            if callback then
                callback(nil, index)
            end
        end
    end, num)
end

-- function PoolMgr:AwaitGet(path, callback)
--     local obj1 = self.objList[path]
--     if obj1 then
--         if (callback) then
--             callback(self.SpawnTemplate(ResMgr:GetGlobalResCarrier(), obj1))
--         end
--     elseif self.loadingList[path] == true then
--         if self.waitList[path] == nil then
--             self.waitList[path] = {}
--         end
--         local l = self.waitList[path]
--         l[#l + 1] = callback
--     else
--         self.loadingList[path] = true
--         ResMgr:LoadPrefabAsyncInOwner(path, function (obj)
--         -- AssetManager.Instance:LoadGameObjectAsync(path, function (obj)
--             self.loadingList[path] = false
--             if (obj) then
--                 if self.objList[path] == nil then
--                     self.objList[path] = GameObject.Instantiate(obj).gameObject
--                 end
--                 local template = self.objList[path]
--                 template.transform:SetParent(self.objRoot.transform, false)
--                 template:SetActive(false)
--                 if (callback) then
--                     callback(self.SpawnTemplate(ResMgr:GetGlobalResCarrier(), template))
--                 end
--                 self:_CheckWaitList(path)
--             else
--                 if (callback) then
--                     callback(obj)
--                 end
--             end
--         end, ResMgr:GetGlobalResCarrier())
--     end
-- end

function PoolMgr:Preload(path, num, callback)
    local preloadList = {}
    local loadFinishCnt = 0
    local f = function(obj)
        -- table.insert(preloadList, obj)
        loadFinishCnt = loadFinishCnt + 1
        preloadList[loadFinishCnt] = obj
        if (loadFinishCnt >= num) then
            for _, loadedObj in ipairs(preloadList) do
                self.Free(loadedObj)
            end
            preloadList = {}
            if (callback) then
                callback()
            end
        end
    end
    for i = 1, num do
        self:Get(path, f) 
    end
end

function PoolMgr:Clear()
    self.objList = {}
    self.loadingList = {}
    self.waitList = {}
    -- ReleaseOwnerResources 会：
    --   1. 调用 ReleasePool(requestId)：销毁该 carrier 下所有 pool 实例，清理 requestMap/activeList
    --   2. 调用 GlobalResourceManager.ReleaseRes(carrier)：释放资产引用计数，允许资源被卸载
    self.ReleaseOwnerResources(ResMgr:GetPoolResCarrier())
end


function PoolMgr:LuaSpawn(path, func)
    self.Spawn(path, func)
end



function PoolMgr.Free(obj)
    if IsNull(obj) then
        LuaLogger.ws("物体对象已经被删除")
        return
    end
    --LuaLogger.ds(" PoolMgr.Free    name:" .. DLuaUtil.GetHierarchyPath(obj.transform))
    PoolManager.Free(obj)
end

return PoolMgr