-- baoruichang
-- 2022/11/16 14:54:25
local UIMasqueradeRewardContext = BaseClass("UIMasqueradeRewardContext", BaseContext)
local M = UIMasqueradeRewardContext
local MessageId = Proto.MessageId

function M:Init()
end

function M:Open(activityId)
    self._activityId = activityId
    self:RequestEnterActivityCopy()
end

function M:RedPointCheck(activityId)
end

------------------------------------Start-------------------------------------------
-- 请求进入活动副本Req
function M:RequestEnterActivityCopy()
    self._tempResponseEnterActivityCopyCallback = NetPack:RegistResponse(MessageId.ResponseEnterActivityCopy, Bind(self, self.ResponseEnterActivityCopyCallback))
    local request = {}
    request.ActivityId = self._activityId
    NetPack:SendMessage(MessageId.RequestEnterActivityCopy, request)
end

-- 请求全局次数Req
function M:RequestGloalTimes()
    self._tempResponseGloalTimesCallback = NetPack:RegistResponse(MessageId.ResponseGlobalTimes, Bind(self, self.ResponseGloalTimesCallback))
    local request = {}
    request.ActivityId = self._activityId
    NetPack:SendMessage(MessageId.RequestGlobalTimes, request)
end

---- 请求进入活动副本Ack
function M:ResponseEnterActivityCopyCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseEnterActivityCopy, self._tempResponseEnterActivityCopyCallback)
    self._tempResponseEnterActivityCopyCallback = nil
    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self:RequestGloalTimes()
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
    ActivityCopyDataMgr:GetInstance():UpdateGlobalTimes(msg.GlobalTimes)
    if UIContextMgr:GetInstance():IsShow(self.uiName) then
        self:GetCtrl():RefGloalTimes(msg.GlobalTimes)
    else
        ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(self._activityId, Bind(self, self._OnLoadTaskCallBack))
    end
end

function M:_OnLoadTaskCallBack(cRoleActivitys) 
    if cRoleActivitys and #cRoleActivitys > 0 then
        self._rewardNum = cRoleActivitys[1].Value1
    else
        self._rewardNum = 0
    end
    self:_Show(self._globalTimes, self._activityId)
end

function M:GetRewardNum()
    local data = ActivityDataMgr:GetInstance():GetActivityData(self._activityId)
    local cRoleActivitys = data:RoleActivity()
    if cRoleActivitys and #cRoleActivitys > 0 then
        self._rewardNum = cRoleActivitys[1].Value1
    else
        self._rewardNum = 0
    end
    return self._rewardNum
end

------------------------------------End-------------------------------------------
function M:OnClose()
    M.super.OnClose(self)
end

return UIMasqueradeRewardContext
