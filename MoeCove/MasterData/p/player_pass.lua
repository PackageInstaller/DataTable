-- Desc: 通行证相关逻辑
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


---获取当前通行证所有数据
---@return table<integer, PassData>
function Player:getPassDataMap()
    return self.passDataMap
end

---获取单个通行证数据
---@return PassData
function Player:getPassData(id)
    local passDataMap = self:getPassDataMap()
    return passDataMap[id]
end

--- 通行证开启调用
---@param passActivityId integer 通行证id
---@param proto any
function Player:passportOpen(passActivityId, proto)
    local passDataMap = self:getPassDataMap()
    local passData = self:getPassData(passActivityId)
    if passData ~= nil then
        LuaLogger.es("passData ~= nil", passActivityId)
        return
    end

    passDataMap[passActivityId] = {
        id = passActivityId,
        level = 0,
        levelExp = 0,
        openAdvance = 0,
        basePassRwdStates = {},
        advancePassRwdStates = {},
        openSuperAdvance = 0,
        isClosed = 0,
    }

    if proto then
        proto.passDataMap = passDataMap
    end
end

--- 通行证关闭调用
---@param passActivityId any
---@param proto any
function Player:passportClose(passActivityId, proto)
    local passData = self:getPassData(passActivityId)
    if passData == nil then
        LuaLogger.es("passData == nil", passActivityId)
        return
    end
    if passData.isClosed ~= nil and passData.isClosed == 1 then
        LuaLogger.es("passData.isClosed error")
        return
    end

    local cfgList = Config.GetPassportByPassportId(passActivityId)
    if not cfgList then
        LuaLogger.es("cfgList == nil", passActivityId)
        return
    end

    --补发奖励
    local totalRewardList = {}
    for _, cfg in pairs(cfgList) do
        if cfg.Level <= passData.level then
            if not tablex.find(passData.basePassRwdStates,cfg.Level) then
                local singleReward = cfg.Award
                totalRewardList = tablex.combine(totalRewardList, singleReward)
                tablex.insertproxy(passData.basePassRwdStates, cfg.Level)
            end
            if passData.openAdvance == 1 then
                if not tablex.find(passData.advancePassRwdStates,cfg.Level) then
                    local singleReward = cfg.AdvancedAward
                    totalRewardList = tablex.combine(totalRewardList, singleReward)
                    tablex.insertproxy(passData.advancePassRwdStates, cfg.Level)
                end
            end
        end
    end
    if not tablex.empty(totalRewardList) then
        local mailTable = Config.GetMailTableById(10001)
        if mailTable == nil then
            LuaLogger.es("mailTable == nil", 10001)
            return ActionFailReason.CfgNotFind
        end
        local mailData = {}
        mailData.title = mailTable.MailTitle
        mailData.content = mailTable.MailContent
        mailData.reward = totalRewardList
        mailData.sender = mailTable.MailSender
        self:createNewMail(mailData)
    end

    passData.isClosed = 1

    if proto then
        proto.passDataMap = self:getPassDataMap()
    end
end

--- 获取通行证奖励
---@param id integer 通行证id
---@param level integer 通行证等级
---@param rewardState integer 奖励状态
---@param proto any
---@return ActionFailReason
---@return table|nil
function Player:GetPassLevelReward(id, level, rewardState, proto)
    if not id or id <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    local passData = self:getPassData(id)
    if not passData then
        return ActionFailReason.PassNotExist
    end
    --通行证功能开启判断
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.PASSPORT)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end
    --1基础通行证奖励 2高级通行证奖励 其他 全部奖励
    if rewardState == 1 or rewardState == 2 then
        if not level or level < 1 then
            return ActionFailReason.ParameterInvalid
        end
        if passData.level < level then
            return ActionFailReason.PassRewardNotGet
        end
        local cfg = Config.GetPassportLevelInfoByPassportIdAndLevel(id, level)
        if not cfg then
            return ActionFailReason.PassConfigError
        end
        if rewardState == 1 then
            if tablex.find(passData.basePassRwdStates,level) then
                return ActionFailReason.PassRewardReceived
            end
        end
        if rewardState == 2 then
            if passData.openAdvance == 0 or passData.openAdvance == nil then
                return ActionFailReason.PassAdvanceNotOpen
            end
            if tablex.find(passData.advancePassRwdStates,level) then
                return ActionFailReason.PassRewardReceived
            end
        end
    end
    local cfgList = Config.GetPassportByPassportId(id)
    if not cfgList then
        return ActionFailReason.PassConfigError
    end

    --领取列表，日志用
    local receiveTable = {}
    local rewardList = {}
    if rewardState == 1 or rewardState == 2 then
        local cfg = Config.GetPassportLevelInfoByPassportIdAndLevel(id, level)
        if not cfg then
            return ActionFailReason.PassConfigError
        end
        if not tablex.find(passData.basePassRwdStates,level) then
            local singleReward = self:addRewardList(cfg.Award, proto, GE.EventItemType.PASS, level)
            rewardList = tablex.combine(rewardList, singleReward)
            tablex.insertproxy(passData.basePassRwdStates, level)
            table.insert(receiveTable, level)
        end
        if passData.openAdvance == 1 then
            if not tablex.find(passData.advancePassRwdStates,level) then
                local singleReward = self:addRewardList(cfg.AdvancedAward, proto, GE.EventItemType.PASS, level)
                rewardList = tablex.combine(rewardList, singleReward)
                tablex.insertproxy(passData.advancePassRwdStates, level)
                table.insert(receiveTable, 10000 + level)
            end
        end
    else
        for _, cfg in pairs(cfgList) do
            if cfg.Level <= passData.level then
                if not tablex.find(passData.basePassRwdStates, cfg.Level) then
                    local singleReward = self:addRewardList(cfg.Award, proto, GE.EventItemType.PASS, cfg.Level)
                    rewardList = tablex.combine(rewardList, singleReward)
                    tablex.insertproxy(passData.basePassRwdStates, cfg.Level)
                    table.insert(receiveTable, cfg.Level)
                end
                if passData.openAdvance == 1 then
                    if not tablex.find(passData.advancePassRwdStates, cfg.Level) then
                        local singleReward = self:addRewardList(cfg.AdvancedAward, proto, GE.EventItemType.PASS, cfg.Level)
                        rewardList = tablex.combine(rewardList, singleReward)
                        tablex.insertproxy(passData.advancePassRwdStates, cfg.Level)
                        table.insert(receiveTable, 10000 + cfg.Level)
                    end
                end
            end
        end
    end

    if proto then
        proto.passDataMap = self:getPassDataMap()
    end

    if DataLogMgr then
        DataLogMgr.LogPassport({
            id = id,
            exp = passData.levelExp,
            level = passData.level,
            premium = passData.openAdvance,
            receiveType = rewardState,
            receive = receiveTable,
        }, self)
    end
    --添加奖励合并
    rewardList = self:mergeRewardList(rewardList)
    return ActionFailReason.None, rewardList
end

---根据ActivityTag查找到当前的Activity
---@param pActivityTag integer 当前的ActivityTag活动标签
---@return PassData? 通行证数据
function Player:GetPassDataWithActivityTag(pActivityTag)
    if not pActivityTag or pActivityTag < 1 then
        return nil
    end

    local passDataMap = self:getPassDataMap()
    for id, value in pairs(passDataMap) do
        if value.isClosed == nil or value.isClosed == 0 then
            local cfg = Config.GetActivityInfo(id)
            local passportMainData = Config.GetPassportMainInfo(cfg.activityPara[1])

            if passportMainData and passportMainData.ActivityTag and passportMainData.ActivityTag == pActivityTag then
                return value
            end
        end
    end
    return nil
end

---解锁高级通行证
---@param pActivityTag integer 当前的ActivityTag活动标签
---@param proto any
function Player:UnlockAdvancePass(pActivityTag, proto)
    if pActivityTag == nil or pActivityTag <= 0 then
        LuaLogger.es("pActivityTag == nil or pActivityTag <= 0", pActivityTag)
        return ActionFailReason.ParameterInvalid
    end

    local passData = self:GetPassDataWithActivityTag(pActivityTag)
    if passData == nil then
        LuaLogger.es("passData == nil", pActivityTag)
        return ActionFailReason.PassNotExist
    end

    if passData.openAdvance == 1 then
        LuaLogger.es("passData.openAdvance == 1", pActivityTag)
        return ActionFailReason.PassAdvanceOpened
    end

    passData.openAdvance = 1
    if proto then
        proto.passDataMap = self:getPassDataMap()
    end

    return ActionFailReason.None
end

--- 增加通行证等级
---@param pActivityTag any
---@param addLevel any
---@param proto any
function Player:addSuperPassLevelExp(pActivityTag, addLevel, proto)
    if pActivityTag == nil or pActivityTag <= 0 then
        LuaLogger.es("pActivityTag == nil or pActivityTag <= 0", pActivityTag)
        return ActionFailReason.ParameterInvalid
    end

    local passData = self:GetPassDataWithActivityTag(pActivityTag)
    if passData == nil then
        LuaLogger.es("passData == nil", pActivityTag)
        return ActionFailReason.PassNotExist
    end

    local cfgList = Config.GetPassportByPassportId(passData.id)
    if not cfgList then
        LuaLogger.es("passRwdList == nil", pActivityTag)
        return ActionFailReason.PassConfigError
    end

    passData.level = passData.level + addLevel
    if passData.level > #cfgList then
        passData.level = #cfgList
    end

    if proto then
        proto.passDataMap = self:getPassDataMap()
    end

    return ActionFailReason.None
end

--- 增加通行证经验
---@param pActivityTag any
---@param pTaskExp any
---@param proto any
function Player:addPassTaskExp(pActivityTag, pTaskExp, proto)
    if pActivityTag == nil or pActivityTag <= 0 then
        LuaLogger.es("pActivityTag == nil or pActivityTag <= 0", pActivityTag)
        return ActionFailReason.ParameterInvalid
    end

    local passData = self:GetPassDataWithActivityTag(pActivityTag)
    if passData == nil then
        LuaLogger.es("passData == nil", pActivityTag)
        return ActionFailReason.PassNotExist
    end

    local cfgList = Config.GetPassportByPassportId(passData.id)
    if not cfgList then
        LuaLogger.es("passRwdList == nil", pActivityTag)
        return ActionFailReason.PassConfigError
    end

    local useTaskExp = pTaskExp
    while useTaskExp > 0 do
        local expUseLevel = passData.level + 1
        if expUseLevel > #cfgList then
            expUseLevel = #cfgList
            break
        end
        local cfg = Config.GetPassportLevelInfoByPassportIdAndLevel(passData.id, expUseLevel)
        if not cfg then
            break
        end
        if cfg.Exp - passData.levelExp > useTaskExp then
            passData.levelExp = passData.levelExp + useTaskExp
            useTaskExp = 0
        elseif cfg.Exp - passData.levelExp == useTaskExp then
            passData.level = passData.level + 1
            passData.levelExp = 0
            useTaskExp = 0
        else
            passData.level = passData.level + 1
            useTaskExp = useTaskExp - (cfg.Exp - passData.levelExp)
            passData.levelExp = 0
        end
    end

    if proto then
        proto.passDataMap = self:getPassDataMap()
    end
end

--- 解锁超级通行证
---@param pActivityTag any
---@param proto any
function Player:UnlockSuperPass(pActivityTag, proto)
    if pActivityTag == nil or pActivityTag <= 0 then
        LuaLogger.es("pActivityTag == nil or pActivityTag <= 0", pActivityTag)
        return ActionFailReason.ParameterInvalid
    end

    local passData = self:GetPassDataWithActivityTag(pActivityTag)
    if passData == nil then
        LuaLogger.es("passData == nil", pActivityTag)
        return ActionFailReason.PassNotExist
    end

    if passData.openSuperAdvance == 1 then
        LuaLogger.es("passData.openSuperAdvance == 1", pActivityTag)
        return ActionFailReason.PassSuperAdvanceOpened
    end

    passData.openSuperAdvance = 1
    if proto then
        proto.passDataMap = self:getPassDataMap()
    end

    return ActionFailReason.None
end

return Player
