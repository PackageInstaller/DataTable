---@class UIBase:LuaMonoBehavior
local UIBase = class("UIBase", LuaMonoBehavior)


function UIBase:ctor(data)
    self.msgEventHandler = {}
    self.SortingOrderT = {}
    self.SortingOrderRelationT = {}
    self.sortingOrderIndex = 0
    UIBase.Init(self, data)
end

function UIBase:Init(data)
    
end

function UIBase:AfterInit()
    table.insert(self.msgEventHandler, {GameMsgType.UIMgrOnUIOpen, self.OnUIOpen})
end

function UIBase:SetSortingOrderByRelatio(node, preNode, postNode)
    local SortingOrderT = self:GetProperty("SortingOrderRelationT")
    local function initialNode( currNode, pre, post )
        if currNode == nil then
            return
        end
        local index = nil
        for i,v in ipairs(SortingOrderT) do
            if v.node == currNode then
                index = i
                break
            end
        end
        local function getIndex(node)
            for i,v in ipairs(SortingOrderT) do
                if v.node == node then
                    return i
                end
            end
        end
        local currIndex = index
        if index == nil then
            table.insert(SortingOrderT, {node = currNode, pre = pre, post = post})
            index = #SortingOrderT
        end
        local t = SortingOrderT[index]
        table.remove(SortingOrderT, index)
        local preIndex1 = nil
        local postIndex1 = nil
        local preIndex2 = nil
        local postIndex2 = nil 
        if t.pre then
            preIndex1 = getIndex(t.pre)
            if preIndex1 == nil then
                preIndex1 = 0
            end
        else
            preIndex1 = 0
        end
        if t.post then
            postIndex1 = getIndex(t.post)
            if postIndex1 == nil then
                postIndex1 = 10000
            end
        else
            postIndex1 = 10000
        end

        if pre then
            preIndex2 = getIndex(pre)
            if preIndex2 == nil then
                preIndex2 = 0
            end
        else
            preIndex2 = 0
        end
        
        if post then
            postIndex2 = getIndex(post)
            if postIndex2 == nil then
                postIndex2 = 10000
            end
        else
            postIndex2 = 10000
        end
        if (preIndex1 <= postIndex2 and postIndex2 <= postIndex1) or (postIndex1 >= preIndex2 and preIndex2 <= postIndex1) then
            if currIndex == nil then
                currIndex = preIndex2 + 1
            end
        else
            currIndex = preIndex2 + 1
            if preIndex1 < preIndex2 then
                t.pre = pre
            end
            if postIndex1 > postIndex2 then
                t.post = post
            end
        end
        table.insert(SortingOrderT, currIndex, t)
    end
    initialNode(preNode, nil, node)
    initialNode(node, preNode, postNode)
    initialNode(postNode, node, nil)

    self:FlushSortingOrder()
end

function UIBase:SetSortingOrder(node, orderIndex)
    local SortingOrderT = self:GetProperty("SortingOrderT")
    if SortingOrderT[node] == nil then
        SortingOrderT[node] = orderIndex
    else
        SortingOrderT[node] = orderIndex
    end
    self:FlushSortingOrder(node, orderIndex)
end

function UIBase:SetSortingOrderIndex(newOrderIndex)
    -- 脏检查：值未变化时跳过，避免 resetRenderHierarchy 多次调用同一值时
    -- 触发冗余的 FlushSortingOrder 和 OnSortingOrderChange
    if self.sortingOrderIndex == newOrderIndex then
        return
    end
    self.sortingOrderIndex = newOrderIndex
    self:FlushSortingOrder()
end

function UIBase:FlushSortingOrder(node, orderIndex)
    local sortingOrderIndex = self:GetProperty("sortingOrderIndex")
    if node then
        EngineUtil.SetSortingOrder(node, sortingOrderIndex + orderIndex)
    else
        local t = self:GetProperty("SortingOrderT")
        for k,v in pairs(t) do
            EngineUtil.SetSortingOrder(k, sortingOrderIndex + v)
        end
    end
    
    local t = self:GetProperty("SortingOrderRelationT")
    for k,v in pairs(t) do
        EngineUtil.SetSortingOrder(v.node, sortingOrderIndex + k)
    end
    self:SortingOrderChange()
end

function UIBase:SortingOrderChange()
    self:OnSortingOrderChange()
end

function UIBase:Refresh(data)
    self:DoAfter(0.01, function()
        if self:CheckSelfHasNotBeDestory() then
            self:OnRefresh(data)
        end
    end)
end

function UIBase:Close(bRemove)
    if bRemove then
        UIMgr:removeUI(self)
    else
        UIMgr:closeUI(self)
    end
end

function UIBase:OnOpenStart(data, initiative)
    -- initiative=true 表示界面被"新建"或"Singleton 重用"，Lua 对象不会重新 ctor，
    -- SortingOrderT / SortingOrderRelationT 可能残留上次打开时注册的旧节点引用。
    -- 在 OnOpen 重新注册之前清空，避免 FlushSortingOrder 对过期节点设置错误层级。
    if initiative then
        self.SortingOrderT = {}
        self.SortingOrderRelationT = {}
    end

    local uiCfg = Config.GetUIConfigInfo(self:getClassName())
    if uiCfg == nil then
        return
    end
    if uiCfg.UIType == UIType.Wnd then
        GameMsgMgr:sendEvent(GameMsgType.UIMgrOnUIOpen)
    end

    self:OnOpen(data, initiative)
    self:Refresh(data)
end

function UIBase:StartCreating(time)
end

function UIBase:StartEnter(time)
end


function UIBase:StartRemoving(time)
end

function UIBase:StartExit(time)
end

function UIBase:OnOpen(data, initiative)
end

function UIBase:OnClose()
end

function UIBase:OnRefresh(data)
end

function UIBase:OnSortingOrderChange()
end

function UIBase:OnUIOpen()
    local uiCfg = Config.GetUIConfigInfo(self:getClassName())
    if uiCfg == nil then
        return
    end
    if uiCfg.UIType == UIType.Wnd then
        local exUIData = UIMgr:getExtensionUIData(self:getClassName())
        -- if exUIData and exUIData.name ~= UIMgr:getCurUIName() and not exUIData.isCovered then
        --     UIMgr:hideUI(self)
        -- end
        if not exUIData or exUIData.name == UIMgr:getCurUIName() then
            return
        end
        local dontHide = false
        local coverList = UIMgr:getCurrentUICoverGroup()
        if #coverList > 0 then
            for _, v in ipairs(coverList) do
                if v.name == self:getClassName() then
                    dontHide = true
                    break
                end
            end
        end
        if not dontHide then
            UIMgr:hideUI(self)
        end
    end
end

function UIBase:GetProperty(propertyName)
    local property = nil
    local tmpSelf = self
    while tmpSelf ~= nil and property == nil do
    	if tmpSelf[propertyName] ~= nil then
    		property = tmpSelf[propertyName]
    	else
    		tmpSelf = tmpSelf.super
    	end
    end
    return property
end

function UIBase:UnRegAllMsg(msgMgr)
    if self.msgEventHandler then
        for k,v in pairs(self.msgEventHandler) do
            -- LuaLogger.ds("unreg", v[1], v[2])
            msgMgr:unRegEvent(v[1], self, v[2])
        end
    end
end

function UIBase:RemoveAllTimers()
    self:AutoReleaseTimers()
end

function UIBase:AutoReleaseTimers()
    if not self.autoReleaseTimers then
        return
    end
    
    for i, ti in pairs(self.autoReleaseTimers) do
        DTimer.Instance:RemoveTimer(ti)
    end
    
    tablex.clear(self.autoReleaseTimers)
end

function UIBase:RemoveAutoReleaseTimer(timer)
    if not self.autoReleaseTimers then
        return
    end

    for i, v in ipairs(self.autoReleaseTimers) do
        if v == timer then
            table.remove(self.autoReleaseTimers, i)
            return true
        end
    end
    
    return false
end

function UIBase:DoAfter(delayTime, callback, ...)
    local timer = DLuaTimer:DoAfterIfValid(self.gameObject, delayTime, callback, ...)
    self:AddAutoReleaseTimer(timer)
    return timer
end

function UIBase:DoRepeat(interval, times, callback)
    local timer = DLuaTimer:DoRepeatIfValid(self.gameObject, interval, times, callback)
    self:AddAutoReleaseTimer(timer)
    return timer
end

function UIBase:DoRepeatForever(interval, callback)
    local timer = DLuaTimer:DoRepeatForeverIfValid(self.gameObject, interval, callback)
    self:AddAutoReleaseTimer(timer)
    return timer
end

function UIBase:AddAutoReleaseTimer(timer)
    if not self.autoReleaseTimers then
        self.autoReleaseTimers = {}
    end
    
    table.insert(self.autoReleaseTimers, timer)
    
    return timer
end

function UIBase:CheckSelfHasNotBeDestory()
    local name = self:getClassName()
    local uiData = UIMgr:getUIData(name)
    return uiData ~= nil
end

---异步加载GameObject
---@param path string 资源路径
---@param callback function 加载完成回调
function UIBase:LoadGameObjectAsync(path, callback)
    local f = function (s)
        if self:CheckSelfHasNotBeDestory() then
            if callback then
                callback(s)
            end
        else
            GameObject.Destroy(s)
        end
    end
    -- AssetManager.Instance:LoadGameObjectAsync(path, f)
    self:LoadInstantiatePrefab(path, f)
end

---异步加载图片
---@param path string 图片路径
---@param image UnityEngine.UI.Image
---@param callback function 加载完成回调
function UIBase:LoadSpriteAsync(path, image, callback)
    if not self.autoReleaseAssets then
        self.autoReleaseAssets = {}
    end
    if type(image) == "function" then
        callback = image
        image = nil
    end
    local f = function (s)
        if self:CheckSelfHasNotBeDestory() then
            if callback then
                callback(s)
            end
            table.insert(self.autoReleaseAssets, path)
        else
            -- AssetManager.Instance:ReleaseAsset(path)
        end
    end
    -- AssetManager.Instance:LoadSpriteAsync(path, f)
    self:LoadSprite(path, image, f)
end

---自动释放资源
function UIBase:AutoReleaseAssets()
    if not self.autoReleaseAssets then
        return
    end
    --print("AssetManager AutoReleaseAssets",self.autoReleaseAssets)
    -- 使用 ipairs 遍历数组，而不是 pairs
    -- for i, as in ipairs(self.autoReleaseAssets) do
    --     AssetManager.Instance:ReleaseAsset(as)
    -- end
    
    tablex.clear(self.autoReleaseAssets)
end

function UIBase:SetUpdateInterval(interval)
    if not self.LuaMonoIns then
        self.LuaMonoIns = self.gameObject:GetComponent("LuaMono")
    end
    if self.LuaMonoIns then
        self.LuaMonoIns:SetUpdateInterval(interval)
    end
end

return UIBase