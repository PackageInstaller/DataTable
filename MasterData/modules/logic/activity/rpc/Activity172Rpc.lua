-- chunkname: @modules/logic/activity/rpc/Activity172Rpc.lua

module("modules.logic.activity.rpc.Activity172Rpc", package.seeall)

local Activity172Rpc = class("Activity172Rpc", BaseRpc)

function Activity172Rpc:sendGetAct172InfoRequest(activityId, cb, cbObj)
	local req = Activity172Module_pb.GetAct172InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, cb, cbObj)
end

function Activity172Rpc:onReceiveGetAct172InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ActivityType172Model.instance:setType172Info(msg.activityId, msg.info)
end

function Activity172Rpc:onReceiveAct172UseItemTaskIdsUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ActivityType172Model.instance:updateType172Info(msg.activityId, msg.useItemTaskIds)
	ActivityController.instance:dispatchEvent(ActivityEvent.Act172TaskUpdate)
end

Activity172Rpc.instance = Activity172Rpc.New()

return Activity172Rpc
