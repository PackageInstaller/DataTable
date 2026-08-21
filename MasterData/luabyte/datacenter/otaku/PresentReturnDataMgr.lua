local PresentReturnDataMgr = BaseClass("PresentReturnDataMgr", Singleton)
local M = PresentReturnDataMgr
local MessageId = Proto.MessageId

function M:__init()
    self.isSending = false
    self.responseTriggerRepresentHandler = nil
    self.responseGetRepresentAwardHandler = nil
    self.OnNotifyStudioRepresentHandler = NetPack:RegistResponse(MessageId.NotifyStudioRepresent,
        Bind(self, self.OnNotifyStudioRepresent))
    self.curTimer = 0
end

--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestRepresentFixedLoad()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

function M:Cleanup()
end

--触发回礼通知
function M:OnNotifyStudioRepresent(messageId, result, msg)
    if result ~= 0 then
        return
    end
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    if not IsNull(rshd) then
        rshd:UpdateRepresentId(msg.Id)
    end
end

--请求触发回礼
function M:RequestTriggerRepresent(callback)
    if self.isSending then
        return
    end

    self.triggerRepresentCallback = callback
    self.isSending = true
    local request = {}
    NetPack:SendMessage(MessageId.RequestTriggerRepresent, request)
    self.responseTriggerRepresentHandler = NetPack:RegistResponse(MessageId.ResponseTriggerRepresent,
        Bind(self, self.OnResponseTriggerRepresent))
end

function M:OnResponseTriggerRepresent(messageId, result, msg)
    self.isSending = false
    if result ~= 0 then
        return
    end
    self.curTimer = Time.realtimeSinceStartup
    if msg.Id > 0 then
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
        rshd:UpdateRepresentId(msg.Id)
    end
    if self.triggerRepresentCallback then
        self.triggerRepresentCallback(msg)
    end
    self.triggerRepresentCallback = nil
end

--请求回礼奖励
function M:RequestGetRepresentAward(heroId, callback)
    if self.isSending then
        return
    end
    self.rePresentAwardHeroId = heroId
    self.getRepresentAwardCallback = callback
    self.isSending = true
    local request = {}
    request.HeroId = heroId
    NetPack:SendMessage(MessageId.RequestGetRepresentAward, request)
    self.responseGetRepresentAwardHandler = NetPack:RegistResponse(MessageId.ResponseGetRepresentAward,
        Bind(self, self.OnResponseGetRepresentAward))
end

function M:OnResponseGetRepresentAward(messageId, result, msg)
    self.isSending = false
    if result ~= 0 then
        return
    end
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.rePresentAwardHeroId)
    rshd:UpdateRepresentId(0)

    if self.getRepresentAwardCallback then
        self.getRepresentAwardCallback(msg)
    end
    self.getRepresentAwardCallback = nil
end

--请求后宅宿舍固定时段剧情数据
function M:RequestRepresentFixedLoad()
    local request = {}
    NetPack:SendMessage(MessageId.RequestRepresentFixedLoad, request)
    self.responseRepresentFixedLoadHandler = NetPack:RegistResponse(MessageId.ResponseRepresentFixedLoad,
        Bind(self, self.OnResponseRepresentFixedLoad))
end

--请求后宅宿舍固定时段剧情数据回调
function M:OnResponseRepresentFixedLoad(messageId, result, msg)
    self._dataLoaded = true
    self._isloading = false
    self.events = {}
    if result ~= 0 then
        return
    end

    for key, value in pairs(msg.Events) do
        if self:CheckRepresentFixedTime(value) then
            table.insert(self.events, value)
        end
    end
end

--触发宿舍固定时段剧情
function M:RequestRepresentFixedTrigger(eventId, callback)
    self.representFixedTriggerCallback = callback
    local request = {}
    request.EventId = eventId
    NetPack:SendMessage(MessageId.RequestRepresentFixedTrigger, request)
    self.responseRepresentFixedTriggerHandler = NetPack:RegistResponse(MessageId.ResponseRepresentFixedTrigger,
        Bind(self, self.OnResponseRepresentFixedTrigger))
end

--宿舍固定时段
function M:OnResponseRepresentFixedTrigger(messageId, result, msg)
    if result ~= 0 then
        return
    end
    table.insert(self.events, msg.Data)
    if self.representFixedTriggerCallback then
        self.representFixedTriggerCallback(msg)
    end
    self.representFixedTriggerCallback = nil
end

--领取宿舍固定时段剧情奖励
function M:RequestRepresentFixedReward(eventId, callback)
    self.representFixedRewardCallback = callback
    local request = {}
    request.EventId = eventId
    NetPack:SendMessage(MessageId.RequestRepresentFixedReward, request)
    self.responseRepresentFixedRewardHandler = NetPack:RegistResponse(MessageId.ResponseRepresentFixedReward,
        Bind(self, self.OnResponseRepresentFixedReward))
end

--领取宿舍固定时段剧情奖励回调
function M:OnResponseRepresentFixedReward(messageId, result, msg)
    if result ~= 0 then
        return
    end
    for key, value in pairs(self.events) do
        if value.EventId == msg.EventId then
            value.Reward = 1
        end
    end
    if self.representFixedRewardCallback then
        self.representFixedRewardCallback(msg)
    end
    self.representFixedRewardCallback = nil
end

--判断宿舍固定时段剧情是否过期
function M:CheckRepresentFixedTime(data)
    local cfg = ConfigHelper.GetCfgByLua("representDayTrigger", data.EventId)
    if cfg then
        local curtimer = TimeUtil.GetSecondIndexInDay()
        if curtimer >= cfg.timeStart and curtimer < cfg.timeEnd then
            return true
        end
    end
    return false
end

--判断是否有可触发的宿舍固定时段剧情
function M:CheckRepresentFixedTrigger()
    self:ClearOvertimeData()
    --判断当前时间段是否是特殊时间段
    local cfgs = ConfigHelper.GetCfgs("representDayTrigger")
    local curtimer = TimeUtil.GetSecondIndexInDay()
    local intime = false
    local cfg = nil
    for key, value in pairs(cfgs) do
        if curtimer >= value.timeStart and curtimer < value.timeEnd then
            intime = true
            cfg = value
        end
    end
    --当前时间段未触发
    if intime and cfg then
        local isTrigger = false
        for key, value in pairs(self.events) do
            if  value.EventId == cfg.id then
                isTrigger = true
            end
        end
        return not isTrigger, cfg.id
    end
    return false, nil
end

--清除超时数据
function M:ClearOvertimeData()
    local curtimer = TimeUtil.GetSecondIndexInDay()
    if self.events then 
        for key, value in pairs(self.events) do
            local cfg = ConfigHelper.GetCfgByLua("representDayTrigger", value.EventId)
            if TimeUtil.IsToday(value.Time) then    
                if curtimer >= cfg.timeEnd then
                    self.events[key] = nil
                end
            else
                self.events[key] = nil
            end
        end
    end
    
end

--获取当前英雄宿舍固定时段剧情
function M:GetRepresentFixedStoryByHeroId(heroId)
    if self.events then 
        for key, value in pairs(self.events) do
            if self:CheckRepresentFixedTime(value) then 
                local cfgs = ConfigHelper.GetCfgsByLua("roomStory", { groupId = value.Story})
                if #cfgs > 0 and cfgs[1].heroId == heroId and value.Reward == 0 then
                    return value
                end
            end 
        end
    end
    return nil
end

--判断是否有未触发回礼的英雄
function M:CheckHeroRePresent()
    local roleRoomCfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    for key, value in pairs(roleRoomCfgs) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(value.heroId)
        if not IsNull(rshd) then
            if rshd.DormActive == 1 and rshd.RepresentId == 0 then
                return true
            end
        end
    end
    return false
end

--判断是否有宿舍开启
function M:CheckHeroDormActive()
    local roleRoomCfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    for key, value in pairs(roleRoomCfgs) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(value.heroId)
        if not IsNull(rshd) then
            if rshd.DormActive == 1 then
                return true
            end
        end
    end
    return false
end

--判断是否有未读的提示
function M:CheckHeroRePresentTips()
    local roleRoomCfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    for key, value in pairs(roleRoomCfgs) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(value.heroId)
        if not IsNull(rshd) then
            if rshd.RepresentId ~= 0 then
                return true
            end
        end
    end
    return false
end

function M:Dispose()
    self.curTimer = 0
    NetPack:UnRegistResponse(MessageId.NotifyStudioRepresent, self.OnNotifyStudioRepresent)
end

return PresentReturnDataMgr
