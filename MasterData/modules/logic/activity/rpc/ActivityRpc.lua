-- chunkname: @modules/logic/activity/rpc/ActivityRpc.lua

module("modules.logic.activity.rpc.ActivityRpc", package.seeall)

local ActivityRpc = class("ActivityRpc", BaseRpc)

function ActivityRpc:sendGetActivityInfosRequest(callback, callbackObj)
	local req = ActivityModule_pb.GetActivityInfosRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function ActivityRpc:onReceiveGetActivityInfosReply(resultCode, msg)
	if resultCode == 0 then
		ActivityModel.instance:setActivityInfo(msg)
		ActivityController.instance:checkGetActivityInfo()
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState)
	end
end

function ActivityRpc:onReceiveUpdateActivityPush(resultCode, msg)
	if resultCode == 0 then
		ServerTime.update(msg.time)
		ActivityModel.instance:updateActivityInfo(msg.activityInfo)
		ActivityController.instance:updateAct101Infos(msg.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UpdateActivity, msg.activityInfo.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, msg.activityInfo.id)
	end
end

function ActivityRpc:onReceiveEndActivityPush(resultCode, msg)
	if resultCode == 0 then
		ActivityModel.instance:endActivity(msg.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, msg.id)
	end
end

function ActivityRpc:sendActivityNewStageReadRequest(actIdList, callback, callbackObj)
	if not actIdList then
		return
	end

	local needSendRpcActIdList = {}

	for _, actId in ipairs(actIdList) do
		local activityInfo = ActivityModel.instance:getActivityInfo()[actId]

		if activityInfo and activityInfo:isNewStageOpen() then
			table.insert(needSendRpcActIdList, actId)
		end
	end

	if #needSendRpcActIdList < 1 then
		if callback then
			callback(callbackObj)
		end

		return
	end

	local req = ActivityModule_pb.ActivityNewStageReadRequest()

	for _, v in pairs(needSendRpcActIdList) do
		if v ~= ActivityEnum.PlaceholderActivityId then
			table.insert(req.id, v)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function ActivityRpc:onReceiveActivityNewStageReadReply(code, msg)
	if code == 0 then
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function ActivityRpc:sendUnlockPermanentRequest(actId, callback, callbackObj)
	local req = ActivityModule_pb.UnlockPermanentRequest()

	req.id = actId

	self:sendMsg(req, callback, callbackObj)
end

function ActivityRpc:onReceiveUnlockPermanentReply(resultCode, msg)
	if resultCode == 0 then
		ActivityModel.instance:setPermanentUnlock(msg.id)
		ActivityController.instance:dispatchEvent(ActivityEvent.UnlockPermanent, msg.id)
	end
end

function ActivityRpc:sendGetActivityInfosWithParamRequest(actIds)
	actIds = actIds or {}

	local req = ActivityModule_pb.GetActivityInfosWithParamRequest()

	for _, id in ipairs(actIds) do
		table.insert(req.activityIds, id)
	end

	return self:sendMsg(req)
end

function ActivityRpc:onReceiveGetActivityInfosWithParamReply(resultCode, msg)
	if resultCode == 0 then
		for _, actInfo in ipairs(msg.activityInfos) do
			ActivityModel.instance:updateInfoNoRepleace(actInfo)
		end

		ActivityController.instance:dispatchEvent(ActivityEvent.GetActivityInfoWithParamSuccess)
	end
end

ActivityRpc.instance = ActivityRpc.New()

return ActivityRpc
