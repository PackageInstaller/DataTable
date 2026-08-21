local DormPuzzleActivityDataMgr = BaseClass("DormPuzzleActivityDataMgr", Singleton)
local M = DormPuzzleActivityDataMgr
local MessageId = Proto.MessageId

function M:__init()
    self.cards = {}
    self.rewards = {}
    self.activityData = nil
    self.activityId = nil
    self.activityRoomFlipCfg = nil
    self.ActivityCommonRewardHandle = EventMgr:AddListener(UIMessageNames.ACTIVITY_COMMON_REWARD, Bind(self, self.UpdateData))
end

function M:ClearData()
    self.cards = {}
    self.rewards = {}
    self.activityData = nil
    self.activityId = nil
end

function M:Dispose()
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_COMMON_REWARD, self.ActivityCommonRewardHandle)
end

function M:GetActivityData(activityId,callback)
    self.getActivityDataCallback = callback
    ActivityDataMgr:GetInstance():GetActivityByIdAsyn(activityId, Bind(self, self.GetActivityDataCallback))
end

function M:GetActivityDataCallback(activityData)
    self.activityData = activityData
    if self.getActivityDataCallback then
        self.getActivityDataCallback(self.activityData)
    end
    self.getActivityDataCallback = nil
    if self.activityData then
        self:UpdateData()
    end
end

--刷新数据
function M:UpdateData()
    self.cards = {}
    self.rewards = {}
    if self.activityData then
        if table.count(self.cards) == 0 or table.count(self.rewards) == 0 then
            self.activityId = self.activityData:ActivityId()
            self.activityRoomFlipCfg = ConfigHelper.GetCfgsByLua("activityRoomFlip",{ activityId = self.activityId })[1]
            local activityRoomFlipCardCfgs = ConfigHelper.GetCfgsByLua("activityRoomFlipCard",{ flipCardGroupId = self.activityRoomFlipCfg.flipCardGroupId })
            for key, value in pairs(activityRoomFlipCardCfgs) do
                local data = {}
                data.isActive = self.activityData:FlipCardActive(value.groupChildId)
                if data.isActive == false then
                    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(value.costItem)
                    data.canActive = itemNum >= value.costNum
                else
                    data.canActive = false
                end
                data.cfg = value
                self.cards[value.groupChildId] = data
            end
    
            local activityRoomFlipCfg = ConfigHelper.GetCfgsByLua("activityRoomFlipReward",{ activityId = self.activityId })
            for key, value in pairs(activityRoomFlipCfg) do
                local data = {}
                data.isReward = self.activityData:CheckReward(value.rewardChildId)
                data.canReward = self.activityData:CanReward(value.groupChildId)
                data.activeNum = self.activityData:GetActiveNum(value.groupChildId)
                data.cfg = value
                self.rewards[value.rewardChildId] = data
            end
        end
    end
end

--图片碎片激活
function M:RequestFlipCardActive(index, callback)
    if self._isSending then
        return
    end
    
    self.flipCardActiveCallback = callback
    self._isSending = true
    local request = {}
    request.ActId = self.activityId
    request.Idx = index
    NetPack:SendMessage(MessageId.RequestFlipCardActive, request)
    self._responseFlipCardActiveHandler = NetPack:RegistResponse(MessageId.ResponseFlipCardActive,
        Bind(self, self.ResponseFlipCardActive))
end

--图片碎片激活回调
function M:ResponseFlipCardActive(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseFlipCardActive, self._responseFlipCardActiveHandler)
    self._responseFlipCardActiveHandler = nil
    self._isSending = false

    if result ~= 0 then
        return
    end

    self:UpdateData()
    if self.flipCardActiveCallback then
        self.flipCardActiveCallback(msg.Idx)
    end
    self.flipCardActiveCallback = nil
    EventMgr:Broadcast(UIMessageNames.DORM_PUZZLE_ACTIVE)
    IRedPointMgr:ForceCheck(RedPointConst.DormPuzzleRedPointChecker)
end

--首次进入标记
function M:RequestFlipCardMaskFirstEnter(callback)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.ActId = self.activityId
    NetPack:SendMessage(MessageId.RequestFlipCardMaskFirstEnter, request)
    self._flipCardMaskFirstEnterCallback = callback
    self._responseFlipCardMaskFirstEnterHandler = NetPack:RegistResponse(MessageId.ResponseFlipCardMaskFirstEnter,
        Bind(self, self.ResponseFlipCardMaskFirstEnter))
end

--首次进入协议返回
function M:ResponseFlipCardMaskFirstEnter(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseFlipCardMaskFirstEnter, self._responseFlipCardMaskFirstEnterHandler)
    if result ~= 0 then
        return
    end

    if self._flipCardMaskFirstEnterCallback then
        self._flipCardMaskFirstEnterCallback(msg)
    end

    self._responseFlipCardMaskFirstEnterHandler = nil
end

--触发小剧场任务
function M:FlipCardStoryTrigger(eventType, callback)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.ActId = self.activityId
    request.EventType = eventType
    NetPack:SendMessage(MessageId.RequestFlipCardStoryTrigger, request)
    self.flipCardStoryTriggerCallback = callback
    self._responseFlipCardStoryTriggerHandler = NetPack:RegistResponse(MessageId.ResponseFlipCardStoryTrigger,
        Bind(self, self.OnResponseFlipCardStoryTrigger))
end

--触发小剧场任务返回
function M:OnResponseFlipCardStoryTrigger(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseFlipCardStoryTrigger, self._responseFlipCardStoryTriggerHandler)
    if result ~= 0 then
        return
    end

    if self.flipCardStoryTriggerCallback then
        self.flipCardStoryTriggerCallback(msg)
    end

    self._responseFlipCardStoryTriggerHandler = nil
end

--小剧场领奖协议
function M:FlipCardStoryCommit(callBack)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.ActId = self.activityId
    NetPack:SendMessage(MessageId.RequestFlipCardStoryCommit, request)
    self.flipCardStoryCommitCallback = callBack
    self._responseFlipCardStoryCommitHandler = NetPack:RegistResponse(MessageId.ResponseFlipCardStoryCommit,
        Bind(self, self.OnResponseFlipCardStoryCommit))
end

--小剧场领奖协议返回
function M:OnResponseFlipCardStoryCommit(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseFlipCardStoryCommit, self._responseFlipCardStoryCommitHandler)
    if result ~= 0 then
        return
    end

    if self.flipCardStoryCommitCallback then
        self.flipCardStoryCommitCallback(msg)
    end

    self._responseFlipCardStoryCommitHandler = nil
end

--是否激活所有碎片
function M:CheckAllComplete()
    local isComplete = false
    for key, value in pairs(self.cards) do
        if value.isActive then
            isComplete = value
        else
            return false
        end
    end
    return isComplete
end

function M:GetActiveNum()
    local num = 0
    for key, value in pairs(self.cards) do
        if value.isActive then
            num = num + 1
        end
    end
    return num
end 

--判断活动是否开放
function M:CheckActivityOpen()
    if self.activityData then
        local state = self.activityData:State()
        if state == 0 or state == 1 then
            return true
        end
    end
    return false
end

function M:CheckActivityOpenByData(activityData)
    if activityData then
        local state = activityData:State()
        if state == 0 or state == 1 then
            return true
        end
    end
    return false
end

function M:GetCardByGroupChildId(id)
    return self.cards[id]
end 

function M:GetRewardByRewardChildId(id)
    return self.rewards[id]
end 

function M:GetActivityRoomFlipCfg()
    return self.activityRoomFlipCfg
end

function M:CheckAllRedpoint(activityData)
    local ActivityId = activityData:ActivityId()
    --是否有可激活的碎片
    local activityRoomFlipCfg = ConfigHelper.GetCfgsByLua("activityRoomFlip",{ activityId = ActivityId })[1]
    local activityRoomFlipCardCfgs = ConfigHelper.GetCfgsByLua("activityRoomFlipCard",{ flipCardGroupId = activityRoomFlipCfg.flipCardGroupId })
    for key, value in pairs(activityRoomFlipCardCfgs) do
        local isActive = activityData:FlipCardActive(value.groupChildId)
        local canActive = ItemDataMgr:GetInstance():GetItemNumById(value.costItem) >= value.costNum
        if canActive and not isActive then
            return true
        end
    end
    --是否有可领取的奖励
    local activityRoomFlipCfg = ConfigHelper.GetCfgsByLua("activityRoomFlipReward",{ activityId = ActivityId })
    for key, value in pairs(activityRoomFlipCfg) do
        local canReward = activityData:CanReward(value.groupChildId)
        local isReward = activityData:CheckReward(value.rewardChildId)
        if canReward and not isReward then
            return true
        end
    end

    return false
end

function M:GetActivityTask()
    local task = 0
    if self.activityData then
        local eventNode = self.activityData:GetEventNode()
        if eventNode > 0 then
            local eventNodeType = self.activityData:GetEventNodeType()
            if eventNodeType == DormConst.EventType.LevelDoing then
                local cfgs = ConfigHelper.GetCfgsByLua("roomStory", { groupId = eventNode })
                for k, v in pairs(cfgs) do
                    if v.task > 0 then
                        task = v.task
                    end
                end
            end
        end
    end
    return task
end

function M:GetChapterId()
    if self.activityRoomFlipCfg then
        return self.activityRoomFlipCfg.chapterId
    end
    return 0
end

return DormPuzzleActivityDataMgr