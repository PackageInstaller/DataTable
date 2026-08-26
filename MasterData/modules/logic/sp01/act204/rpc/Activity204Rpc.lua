-- chunkname: @modules/logic/sp01/act204/rpc/Activity204Rpc.lua

module("modules.logic.sp01.act204.rpc.Activity204Rpc", package.seeall)

local Activity204Rpc = class("Activity204Rpc", BaseRpc)

function Activity204Rpc:sendGetAct204InfoRequest(activityId, callback, callbackObj)
	local req = Activity204Module_pb.GetAct204InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity204Rpc:onReceiveGetAct204InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:setActInfo(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.UpdateInfo)
	Activity204Controller.instance:dispatchEvent(Activity204Event.RefreshRed)
end

function Activity204Rpc:sendFinishAct204TaskRequest(activityId, taskId)
	local req = Activity204Module_pb.FinishAct204TaskRequest()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function Activity204Rpc:onReceiveFinishAct204TaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:onFinishAct204Task(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.FinishTask, msg)
end

function Activity204Rpc:sendGetAct204MilestoneRewardRequest(activityId)
	local req = Activity204Module_pb.GetAct204MilestoneRewardRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity204Rpc:onReceiveGetAct204MilestoneRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:onGetAct204MilestoneReward(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetMilestoneReward)
end

function Activity204Rpc:sendGetAct204DailyCollectionRequest(activityId)
	local req = Activity204Module_pb.GetAct204DailyCollectionRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity204Rpc:onReceiveGetAct204DailyCollectionReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:onGetAct204DailyCollection(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetDailyCollection)
end

function Activity204Rpc:onReceiveAct204TaskPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:onAct204TaskPush(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.UpdateTask)
end

function Activity204Rpc:sendGetAct204OnceBonusRequest(activityId)
	local req = Activity204Module_pb.GetAct204OnceBonusRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity204Rpc:onReceiveGetAct204OnceBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity204Model.instance:onGetOnceBonusReply(msg)
	Activity204Controller.instance:dispatchEvent(Activity204Event.GetOnceBonus)
end

Activity204Rpc.instance = Activity204Rpc.New()

return Activity204Rpc
