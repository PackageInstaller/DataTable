local M = BaseClass("JumpMgr", Singleton)
local UIPopUp = CS.GameX.UIFormsType.PopUp
local tCheckNull = table.isNullOrEmpty
local tInsert = table.insert
local tRemove = table.remove
local maxCommandCount = 3
function M:__init()
    self.m_commandDic = {} -- 命令字典
end

function M:Dispose()
    self.m_commandDic = nil
end

-- 检查是否跳转回上一级
function M:CheckJumpBack()
    -- 第一个是当前跳转
    if #self.m_commandDic < 2 then
        return false
    end
    local data = self.m_commandDic[#self.m_commandDic - 1]
    local result = data.Commander()
    if result then
        local uiMgr = UIManager:GetInstance()
        for _, value in ipairs(data.UINames) do uiMgr:Close(value) end
    end
    table.remove(self.m_commandDic, #self.m_commandDic)
    return result
end

--返回跳转队列有内容
function M:IsJumpBack()
    -- 第一个是当前跳转
    return #self.m_commandDic > 1
end

--重置跳转队列
function M:ResetJumpBack()
    self.m_commandDic = {}
end

--获得最后一个进入队列的命令
function M:GetTopBackCommand()
    if #self.m_commandDic <= 1 then
        return nil
    end
    return self.m_commandDic[#self.m_commandDic - 1].commandKey
end

--获得最后一个进入队列的命令名字
function M:GetLastCommandKey()
    local len = #self.m_commandDic
    if len > 0 then
        return self.m_commandDic[len].commandKey
    end
    return nil
end

--设置最后一个进入队列的命令内容
function M:SetLastCommand(handler, cfgCmd, names)
    local len = #self.m_commandDic
    if len > 0 then
        self.m_commandDic[len] = { commandKey = cfgCmd, Commander = handler, UINames = names }
        return true
    end
    return false
end

--清除特定命令的跳转内容
function M:ClearBackCommand(commandeKey)
    if #self.m_commandDic <= 0 then
        return false
    end
    for i = #self.m_commandDic, 1, -1 do
        if self.m_commandDic[i].commandKey == commandeKey then
            tRemove(self.m_commandDic, i)
            return true
        end
    end
    return false
end

--尝试替换最后的命令，只能commandKey相同才可以替换
--jumpId 跳转id
function M:TryReplaceLastCommand(jumpId, ...)
    local cfg = ConfigHelper.GetCfg("jump", jumpId)
    if cfg == nil then
        Logger.LogError(string.format("jump is nil. id = %d", jumpId))
        return false
    end

    local lockReason = self:CheckLockByJumpId(jumpId)
    if lockReason ~= 0 then
        local conditionCfg = ConfigHelper.GetCfg("openCondition", lockReason)
        if conditionCfg then
            GameHelper.TipsById(conditionCfg.tips)
        else
            Logger.LogError("openCondition is nil. id = " .. lockReason)
        end
        return false
    end

    local cfgCmd = cfg.command
    if self:GetLastCommandKey() ~= cfgCmd then
        return false
    end

    local cmdCtrl = JumpConst[cfgCmd]
    if not cmdCtrl then
        Logger.LogError(string.format("jump.command = %s is not exist ", cfgCmd))
        return false
    end
    cmdCtrl.beExecuted = true
    local args = { ... }
    tInsert(args, 1, cfg.param1)
    tInsert(args, 2, cfg.param2)
    tInsert(args, 3, cfg.param3)

    local handler = Bind(cmdCtrl, cmdCtrl.Execute, args)
    local names = cmdCtrl.closeOtherUI
    return self:SetLastCommand(handler, cfgCmd, names)
end

--执行跳转功能
--jumpId 跳转id
function M:Execute(jumpId, ...)
    local cfg = ConfigHelper.GetCfg("jump", jumpId)
    if cfg == nil then
        Logger.LogError(string.format("jump is nil. id = %d", jumpId))
        return false
    end

    local lockReason = self:CheckLockByJumpId(jumpId)
    if lockReason ~= 0 then
        local conditionCfg = ConfigHelper.GetCfg("openCondition", lockReason)
        if conditionCfg then
            GameHelper.TipsById(conditionCfg.tips)
        else
            Logger.LogError("openCondition is nil. id = " .. lockReason)
        end
        return false
    end

    local cfgCmd = cfg.command
    local cmdCtrl = JumpConst[cfgCmd]
    if not cmdCtrl then
        Logger.LogError(string.format("jump.command = %s is not exist ", cfgCmd))
        return false
    end
    if cfgCmd ~= "OpenStage" then GameHelper.ClearItemJump() end
    cmdCtrl.beExecuted = false
    local args = { ... }
    tInsert(args, 1, cfg.param1)
    tInsert(args, 2, cfg.param2)
    tInsert(args, 3, cfg.param3)
    local callbackObj = {}
    local handler = Bind(cmdCtrl, cmdCtrl.Execute, args)
    local names = cmdCtrl.closeOtherUI
    cmdCtrl.onComplete = function()
        if cmdCtrl.beExecuted == false then
            UIContextMgr:GetInstance():CloseUIByType(UIPopUp)
            local uiMgr = UIManager:GetInstance()
            for _, value in ipairs(names) do uiMgr:Close(value) end
            if cmdCtrl.isJumpBack then self:_PushJumpStack(handler, cfgCmd, names) end
            cmdCtrl.beExecuted = true
            if callbackObj.callback then
                callbackObj.callback()
            end
        end
    end
    return handler(), callbackObj
end

--执行跳转功能
--jumpId 跳转id
function M:ExecuteFromGeneral(jumpId, ...)
    local cfg = ConfigHelper.GetCfg("jump", jumpId)
    if cfg == nil then
        Logger.LogError(string.format("jump is nil. id = %d", jumpId))
        return false
    end

    local lockReason = self:CheckLockByJumpId(jumpId)
    if lockReason ~= 0 then
        local conditionCfg = ConfigHelper.GetCfg("openCondition", lockReason)
        if conditionCfg then
            GameHelper.TipsById(conditionCfg.tips)
        else
            Logger.LogError("openCondition is nil. id = " .. lockReason)
        end
        return false
    end

    local cfgCmd = cfg.command
    local cmdCtrl = JumpConst[cfgCmd]
    if not cmdCtrl then
        Logger.LogError(string.format("jump.command = %s is not exist ", cfgCmd))
        return false
    end
    cmdCtrl.beExecuted = false
    local args = {}
    tInsert(args, cfg.param1)
    tInsert(args, cfg.param2)
    tInsert(args, cfg.param3)

    local handler = Bind(cmdCtrl, cmdCtrl.Execute, args, ...)
    local names = cmdCtrl.closeOtherUI
    cmdCtrl.onComplete = function()
        if cmdCtrl.beExecuted == false then
            UIContextMgr:GetInstance():CloseUIByType(UIPopUp)
            local uiMgr = UIManager:GetInstance()
            for _, value in ipairs(names) do uiMgr:Close(value) end
            self:ResetJumpBack()
            UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):Init()
            if cmdCtrl.isJumpBack then self:_PushJumpStack(handler, cfgCmd, names) end
            cmdCtrl.beExecuted = true
        end
    end
    return handler()
end

---逻辑优化：跳转缓存池存入元素，与上一个不同则存入，每次存入后仅保留最后两位
function M:_PushJumpStack(handler, cfgCmd, names)
    if cfgCmd == "OpenMainScene" then
        self:ResetJumpBack()
    else
        if #self.m_commandDic > 0 and self.m_commandDic[#self.m_commandDic].commandKey == cfgCmd then
            self.m_commandDic[#self.m_commandDic] = { commandKey = cfgCmd, Commander = handler, UINames = names }
            return
        end
        table.insert(self.m_commandDic, { commandKey = cfgCmd, Commander = handler, UINames = names })
        local beyond = #self.m_commandDic - maxCommandCount
        if beyond <= 0 then
            return
        end
        for i = 1, beyond do
            table.remove(self.m_commandDic, 1)
        end
    end
end

--根据jumpId获得第一个未达成的解锁条件
--jumpId 跳转id
function M:CheckLockByJumpId(jumpId)
    local cfg = ConfigHelper.GetCfg("jump", jumpId)
    if not cfg then
        Logger.LogError(string.format("jump is nil. id = %d", jumpId))
        return 0
    end

    --多项条件必须全达成的unlockIds
    local OCMgr = OpenConditionMgr:GetInstance()
    for _, unlockId in ipairs(cfg.unlockIds or {}) do
        if not OCMgr:Execute(unlockId) then return unlockId end
    end

    if cfg.unlockIdsAtLastOne ~= nil and #cfg.unlockIdsAtLastOne > 0 then
        local mustOpenNum = cfg.unlockIdsAtLastOne[1]
        local curOpenNum = 0
        local unOpenId = 0
        for index, unlockId in ipairs(cfg.unlockIdsAtLastOne or {}) do
            if index ~= 1 then
                if OCMgr:Execute(unlockId) then
                    curOpenNum = curOpenNum + 1
                else
                    unOpenId = unlockId
                end
            end
        end
        if curOpenNum < mustOpenNum then
            return unOpenId
        end
    end

    if not JumpConst[cfg.command] then
        Logger.LogError(string.format("jump.command = %s is not exist ", cfg.command))
        return 0
    end
    return 0
end

--根据jumpId获得第一个未达成的 跳转显示限制 条件
function M:CheckShowLimitById(jumpId)
    local cfg = ConfigHelper.GetCfg("jump", jumpId)
    if not cfg then
        Logger.LogError(string.format("jump is nil. id = %d", jumpId))
        return 0
    end

    --多项条件必须全达成的unlockIds
    local OCMgr = OpenConditionMgr:GetInstance()
    for _, lockId in ipairs(cfg.showLimit or {}) do
        if not OCMgr:Execute(lockId) then return lockId end
    end

    return 0
end

--根据解锁条件id判断此id条件是否达成
--openConditionId 解锁条件id
function M:CheckLockByOpenConditionId(openConditionId, args)
    return OpenConditionMgr:GetInstance():Execute(openConditionId, args)
end

--判断多个解锁条件是否都达成
--openConditionIds 解锁条件数组
function M:CheckLockByOpenConditionIds(openConditionIds, args)
    if openConditionIds == nil then return true end

    local OCMgr = OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds) do
        if not OCMgr:Execute(openId, args) then return false end
    end
    return true
end

--判断多个解锁条件至少有一个达成
--openConditionIds 解锁条件数组
function M:CheckAtLastOneOpenConditionUnLock(openConditionIds)
    if openConditionIds == nil then return true end

    local OCMgr = OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds) do
        if OCMgr:Execute(openId) then return true end
    end
    return false
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
--判断多个解锁条件至少有一个达成
--openConditionIds 解锁条件数组
function M:CSCheckAtLastOneOpenConditionUnLock(openConditionIds)
    if openConditionIds == nil then return true end

    local OCMgr = OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if OCMgr:Execute(openId) then return true end
    end
    return false
end

--判断functionOpen表对应id是否解锁
function M:CheckUnlockByFunctionOpenId(id)
    local functionOpenCfg = ConfigHelper.GetCfg("functionOpen", id)
    local result, openCondition = false, functionOpenCfg and functionOpenCfg.openCondition or nil
    if not tCheckNull(openCondition) then result = self:CheckLockByOpenConditionIds(openCondition) end
    return result
end

--获得未达到解锁条件的数组
--openConditionIds 解锁条件数组
function M:GetLockConditions(openConditionIds)
    if openConditionIds == nil then return {} end

    local arr, OCMgr = {}, OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds) do
        if not OCMgr:Execute(openId) then tInsert(arr, openId) end
    end
    return arr
end

--获得未解锁条件的数量
--openConditionIds 解锁条件数组
function M:GetLockCount(openConditionIds)
    if openConditionIds == nil then return 0 end

    local count, OCMgr = 0, OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds) do
        if not OCMgr:Execute(openId) then count = count + 1 end
    end
    return count
end

--获得第一个未解锁条件
--openConditionIds 解锁条件数组
function M:GetFirstLockReason(openConditionIds)
    local OCMgr = OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds or {}) do
        if not OCMgr:Execute(openId) then return openId end
    end
    return 0
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
--判断多个解锁条件是否都达成
--openConditionIds 解锁条件数组
function M:CSCheckLockByOpenConditionIds(openConditionIds)
    if openConditionIds == nil then return true end

    local OCMgr = OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if not OCMgr:Execute(openId) then return false end
    end
    return true
end

---前缀为CS为专门提供给C#代码调用的
---CS 由于C#传入lua的为数组的userdata，需要遍历时采用不同的方法
--判断多个解锁条件是否都达成
--openConditionIds 解锁条件数组
-- args 参数
function M:CSCheckLockByOpenConditionIdsWithArgs(openConditionIds, args)
    if openConditionIds == nil then return true end

    local OCMgr = OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if not OCMgr:Execute(openId, args) then return false end
    end
    return true
end

--获得未达到解锁条件的数组
--openConditionIds 解锁条件数组
function M:CSGetLockConditions(openConditionIds)
    if openConditionIds == nil then return {} end

    local arr, OCMgr = {}, OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if not OCMgr:Execute(openId) then tInsert(arr, openId) end
    end
    return arr
end

--获得未解锁条件的数量
--openConditionIds 解锁条件数组
function M:CSGetLockCount(openConditionIds)
    if openConditionIds == nil then return 0 end

    local count, OCMgr = 0, OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if not OCMgr:Execute(openId) then count = count + 1 end
    end

    return count
end

function M:GetUnLockCount(openConditionIds)
    if openConditionIds == nil then return 0 end

    local count, OCMgr = 0, OpenConditionMgr:GetInstance()
    for _, openId in ipairs(openConditionIds) do
        if OCMgr:Execute(openId) then count = count + 1 end
    end
    return count
end

--获得已解锁条件的数量
--openConditionIds 解锁条件数组
function M:CSGetUnLockCount(openConditionIds)
    if openConditionIds == nil then return 0 end

    local count, OCMgr = 0, OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if OCMgr:Execute(openId) then count = count + 1 end
    end
    return count
end

--获得第一个未解锁条件
--openConditionIds 解锁条件数组
function M:CSGetFirstLockReason(openConditionIds)
    if openConditionIds == nil then return 0 end

    local OCMgr = OpenConditionMgr:GetInstance()
    for i = 0, openConditionIds.Length - 1 do
        local openId = openConditionIds[i] or 0
        if not OCMgr:Execute(openId) then return openId end
    end
    return 0
end

return M
