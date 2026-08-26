-- chunkname: @modules/logic/activity/rpc/Activity101Rpc.lua

module("modules.logic.activity.rpc.Activity101Rpc", package.seeall)

local Activity101Rpc = class("Activity101Rpc", BaseRpc)

function Activity101Rpc:sendGet101InfosRequest(actId, cb, cbObj)
	local req = Activity101Module_pb.Get101InfosRequest()

	req.activityId = actId

	self:sendMsg(req, cb, cbObj)
end

function Activity101Rpc:onReceiveGet101InfosReply(resultCode, msg)
	if resultCode == 0 then
		ActivityType101Model.instance:setType101Info(msg)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function Activity101Rpc:sendGet101BonusRequest(actId, rewardId, cb, cbObj)
	local req = Activity101Module_pb.Get101BonusRequest()

	req.activityId = actId
	req.id = rewardId

	self:sendMsg(req, cb, cbObj)
end

function Activity101Rpc:onReceiveGet101BonusReply(resultCode, msg)
	if resultCode == 0 then
		ActivityType101Model.instance:setBonusGet(msg)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function Activity101Rpc:sendGet101BonusListRequest(activityId, ids, callback, callbackObj)
	local req = Activity101Module_pb.Get101BonusListRequest()

	req.activityId = activityId

	if ids and next(ids) then
		for _, id in ipairs(ids) do
			table.insert(req.ids, id)
		end
	end

	self:sendMsg(req, callback, callbackObj)
end

function Activity101Rpc:onReceiveGet101BonusListReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local ids = msg.ids
	local activityId = msg.activityId

	ActivityType101Model.instance:setBonusListGet(activityId, ids)
	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
end

function Activity101Rpc:sendGet101SpBonusRequest(actId, id, cb, cbObj)
	local req = Activity101Module_pb.Get101SpBonusRequest()

	req.activityId = actId
	req.id = id

	self:sendMsg(req, cb, cbObj)
end

function Activity101Rpc:onReceiveGet101SpBonusReply(resultCode, msg)
	if resultCode == 0 then
		ActivityType101Model.instance:setSpBonusGet(msg)
		ActivityController.instance:dispatchEvent(ActivityEvent.RefreshNorSignActivity)
	end
end

function Activity101Rpc:sendGetAct186SpBonusInfoRequest(activityId, act186ActivityId, cb, cbObj)
	local req = Activity101Module_pb.GetAct186SpBonusInfoRequest()

	req.activityId = activityId
	req.act186ActivityId = act186ActivityId

	self:sendMsg(req, cb, cbObj)
end

function Activity101Rpc:onReceiveGetAct186SpBonusInfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity186Model.instance:onGetAct186SpBonusInfo(msg)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
	end
end

function Activity101Rpc:sendAcceptAct186SpBonusRequest(activityId, act186ActivityId, cb, cbObj)
	local req = Activity101Module_pb.AcceptAct186SpBonusRequest()

	req.activityId = activityId
	req.act186ActivityId = act186ActivityId

	self:sendMsg(req, cb, cbObj)
end

function Activity101Rpc:onReceiveAcceptAct186SpBonusReply(resultCode, msg)
	if resultCode == 0 then
		Activity186Model.instance:onAcceptAct186SpBonus(msg)
		Activity186Controller.instance:dispatchEvent(Activity186Event.SpBonusStageChange)
		Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
	end
end

Activity101Rpc.instance = Activity101Rpc.New()

return Activity101Rpc
