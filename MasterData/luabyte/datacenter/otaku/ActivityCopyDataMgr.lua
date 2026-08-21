-- 活动副本data
local ActivityCopyDataMgr = BaseClass("ActivityCopyDataMgr", Singleton)
local M = ActivityCopyDataMgr
local EActivityState = EnumConst.EActivityState
local MessageId = Proto.MessageId

function M:__init()
    self.redPointTaskCallBack = {}
    self.redPointRewardCallBack = {}
    self.redPointAchieveCallBack = {}
end

function M:SetActivity(activityId)
    self.activityId = activityId
end

function M:GetActivity()
    return self.activityId or 0
end

function M:OpenDefaultActivity()
    local activityId = self:GetActivity()
    if activityId <= 0 then
        return
    end

    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误：" .. activityId)
        return
    end
    local uiName = activityCopys[1].UIMain
    self:SetActivity(activityId)
    UIManager:GetInstance():Show(uiName, activityId)
end

-- 活动副本任务
function M:CheckTaskRedPointById(activityId, callBack)
    self.redPointTaskCallBack[activityId] = callBack
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, Bind(self, self._OnLoadTaskCallBack, activityId))
end

function M:_OnLoadTaskCallBack(activityId, cRoleActivitys)
    local redPointCallBack = self.redPointTaskCallBack[activityId]
    if not redPointCallBack then
        return
    end
    for _, CRoleActivity in pairs(cRoleActivitys) do
        if CRoleActivity.State == EActivityState.Finished then
            redPointCallBack(true)
            self.redPointTaskCallBack[activityId] = nil
            return
        end
    end
    redPointCallBack()
    self.redPointTaskCallBack[activityId] = nil
end

-- 活动副本成就红点
function M:CheckAchieveRedPointById(activityId, callBack)
    -- 成就详细信息
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误")
        callBack()
        return
    end
    self.redPointAchieveCallBack[activityId] = callBack
    local achievementGroupId = activityCopys[1].achievementGroupId
    if achievementGroupId and achievementGroupId > 0 then
        AchievementDataMgr:GetInstance():SendRequestAchievementGroupDetail(achievementGroupId, Bind(self, self._OnLoadAcheveCallBack, activityId))
    end
end

function M:_OnLoadAcheveCallBack(activityId, acheveData)
    local redPointCallBack = self.redPointAchieveCallBack[activityId]
    if not redPointCallBack then
        return
    end
    local tasks = acheveData:Tasks()
    for _, task in pairs(tasks) do
        local state = task:State()
        if state == EActivityState.Finished then
            redPointCallBack(true)
            self.redPointAchieveCallBack[activityId] = nil
            return
        end
    end
    redPointCallBack()
    self.redPointAchieveCallBack[activityId] = nil
end

-----------------------------全服奖励红点Start------------------------------------

function M:UpdateGlobalTimes(globalTimes)
    self._globalTimes = globalTimes
end

-- 活动副本大狂欢红点
function M:CheckRewardRedPointById(activityId, callBack)
    self.rewardActivityId = activityId
    self.redPointRewardCallBack[activityId] = callBack
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(activityId, Bind(self, self._OnLoadRewardCallBack, activityId))
end

-- 活动副本大狂欢红点
function M:_OnLoadRewardCallBack(activityId, cRoleActivitys)
    if cRoleActivitys and #cRoleActivitys > 0 then
        -- 已经领取的大狂欢奖励
        self._rewardNum = cRoleActivitys[1].Value1
    else
        self._rewardNum = 0
    end
    if self._globalTimes then
        self:_InitItemState()
        return
    end
    self._tempResponseGloalTimesCallback = NetPack:RegistResponse(MessageId.ResponseGlobalTimes, Bind(self, self.ResponseGloalTimesCallback))
    local request = {}
    request.ActivityId = activityId
    -- 请求全局次数Req
    NetPack:SendMessage(MessageId.RequestGlobalTimes, request)
end

-- 请求全局次数Ack
function M:ResponseGloalTimesCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseGlobalTimes, self._tempResponseGloalTimesCallback)
    self._tempResponseGloalTimesCallback = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self._globalTimes = msg.GlobalTimes
    self:_InitItemState()
end

function M:_InitItemState()
    local redPointCallBack = self.redPointRewardCallBack[self.rewardActivityId]
    if not redPointCallBack then
        return
    end
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=self.rewardActivityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误")
        redPointCallBack()
        return
    end
    local allRewardLimits = activityCopys[1].allRewardLimit
    for i = 1, 3 do
        if self._globalTimes >= allRewardLimits[i] then
            if not self:CheckReward(i - 1, self._rewardNum) then
                redPointCallBack(true)
                self.redPointRewardCallBack[self.rewardActivityId] = nil
                self.rewardActivityId = nil
                return
            end
        end
    end
    redPointCallBack()
    self.redPointRewardCallBack[self.rewardActivityId] = nil
    self.rewardActivityId = nil
end

-- 奖励是否领取
function M:CheckReward(idx, bitMask)
    return 1 << idx & bitMask > 0
end
-----------------------------全服奖励红点End------------------------------------
return ActivityCopyDataMgr
