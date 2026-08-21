-- Desc: 触发器
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end

--触发器：根据玩家行为和配置中对应的概率触发，效果根据系统类型触发
-------------------------------------------数据获取 & 更新-------------------------------------------------------

--获取事件列表
---@return table 事件列表
function Player:getTriggerEventMap()
    return self.triggerEventMap
end

--获取触发器列表
---@param id integer 触发器ID
---@return table? 触发器列表
function Player:getTriggerListById(id)
    local triggerEventMap = self:getTriggerEventMap()
    if not triggerEventMap or not triggerEventMap[id] then
        return nil
    end
    return triggerEventMap[id]
end

--获取时间限制列表
---@return table 时间限制列表
function Player:getTimeLimitListLimitType(limitType)
    local timeLimitList = {}
    timeLimitList = Config.GetEventTriggerByLimitId(limitType)
    return timeLimitList
end

--获取事件触发器列表
---@return table 事件触发器列表
function Player:getEventTriggerListByTriggerType(triggerType)
    local eventTriggerList = {}
    eventTriggerList = Config.GetEventTriggerByType(triggerType)
    return eventTriggerList
end

---------------------------------------------触发器相关--------------------------------------------------------
--初始化触发器
---@param userinfo UserInfo 用户信息
function Player:initEventTriggerData(userinfo)
    local eventTriggerTable = Config.GetAllConfig("EventTriggerTable")
    local triggerEventMap = self:getTriggerEventMap()
    for _, eventData in pairs(eventTriggerTable) do
        --新建触发器，记录id 次数 进度默认是0
        local eventInfo = self:getTriggerListById(eventData.id)
        if eventInfo ~= nil then
            goto continue
        end
        local newEventInfo = {
            id = eventData.id,
            count = 0,
            progress = 0,           --进度默认是0
        }

        triggerEventMap[eventData.id] = newEventInfo
        ::continue::
    end
end

--激活触发器（用于埋入各个系统）
---@param triggerType EventTriggerType 事件触发器类型
---@param value integer 附加值
---@param userinfo UserInfo 用户信息
function Player:ActivateEventTrigger(triggerType,value, userinfo)
    local eventTriggerList = self:getEventTriggerListByTriggerType(triggerType)
    if not eventTriggerList then
        return
    end

    local triggerEventMap = self:getTriggerEventMap()
    --遍历列表，查询配置信息 处理所有同触发类型的触发器
    for _, triggerCfg in pairs(eventTriggerList) do
        local triggerInfo = self:getTriggerListById(triggerCfg.id)
        if triggerInfo then
            --触发器进度增加
            triggerInfo.progress = triggerInfo.progress + value
            --进度满时循环触发，直到进度不足或达到周期次数上限（次数已满时保留剩余进度，等待下次周期重置后继续）
            while triggerInfo.progress >= triggerCfg.num and triggerInfo.count < triggerCfg.limit[2] do
                --触发器进度满了，进行触发判定
                if triggerCfg.ExtraCondition and next(triggerCfg.ExtraCondition) then    --需要判断时间段
                    --判断是否在可触发的时间段内
                    local nowTime = DLuaUtil.GetGreenwichTime()
                    local date = os.date("*t", nowTime)
                    date.hour = 0
                    date.min = 0
                    date.sec = 0
                    local todayZero = os.time(date)
                    local scopeL = todayZero + triggerCfg.ExtraCondition[1] * 3600
                    local scopeR = todayZero + triggerCfg.ExtraCondition[2] * 3600
                    if nowTime >= scopeL and nowTime < scopeR then         --在时间内
                        triggerInfo.progress = triggerInfo.progress - triggerCfg.num
                        local success = self:executeTrigger(triggerCfg, triggerInfo, userinfo)
                        if not success then
                            triggerInfo.progress = triggerInfo.progress + triggerCfg.num
                            break
                        end
                    else
                        break   --时间不符合时，保留进度，等待时间窗口
                    end
                else
                    triggerInfo.progress = triggerInfo.progress - triggerCfg.num
                    local success = self:executeTrigger(triggerCfg, triggerInfo, userinfo)
                    if not success then
                        triggerInfo.progress = triggerInfo.progress + triggerCfg.num
                        break
                    end
                end
            end
            triggerEventMap[triggerCfg.id] = triggerInfo
        end
    end
end

--执行触发器
---@param eventConfig EventTriggerTable 事件配置
---@param triggerInfo EventTriggerInfo 触发器信息
---@param userinfo UserInfo 用户信息
---@return boolean 是否触发成功
function Player:executeTrigger(eventConfig, triggerInfo, userinfo)
    local ret = nil
    local random = self:getRandom()
    local roomList = self:getRandomAndSetWalkRoleList()
    local randomValue = DLuaUtil.randomByPercent(eventConfig.prop, random)
    if randomValue then
        --这里根据system类型进行不同的触发
        if eventConfig.system == GE.EventTriggerSystemType.Affection then
            --好感度系统额外受每日触发上限约束
            if self:getLimitCount() < Config.GetConfigInfo("HomeEventDaily") then
                ret = self:randomAffectionEventByHeroId(roomList, userinfo)
                if ret == ActionFailReason.None then
                    self:setLimitCount(self:getLimitCount() + 1)
                end
            end
        elseif eventConfig.system == GE.EventTriggerSystemType.Dispatch then
            ret = self:randomDispatchEvent(userinfo)
        elseif eventConfig.system == GE.EventTriggerSystemType.CombatIntellgence then
            ret = self:RandomCombatIntellgence(eventConfig.id, userinfo)
        elseif eventConfig.system == GE.EventTriggerSystemType.HomelandBattle then
            ret = self:RandomHomelandBattle(eventConfig.id, userinfo)
        end
        if ret == ActionFailReason.None then
            triggerInfo.count = triggerInfo.count + 1
            return true
        end
    end
    return false
end

--根据时间刷新类型 重置对应触发器
---@param triggerType EventTriggerRefreshType 触发器时间类型
---@param userinfo UserInfo 用户信息
function Player:resetTriggerByTimeType(triggerType, userinfo)
    local timeLimitList = self:getTimeLimitListLimitType(triggerType)
    if not timeLimitList then
        return
    end
    for _, triggerCfg in pairs(timeLimitList) do
        self:resetTriggerCount(triggerCfg.id, userinfo)
    end
    if triggerType == GE.EventTriggerlimitType.Daily then
        --每日重置时，重置好感度系统的每日触发次数
        self:setLimitCount(0)
    end
end

--根据触发器id重置触发器计数
---@param triggerId integer 触发器ID
---@param userinfo UserInfo 用户信息
function Player:resetTriggerCount(triggerId, userinfo)
    local triggerEventMap = self:getTriggerEventMap()
    local triggerData = triggerEventMap[triggerId]
    if triggerData then
        triggerData.count = 0
    end
end

return Player