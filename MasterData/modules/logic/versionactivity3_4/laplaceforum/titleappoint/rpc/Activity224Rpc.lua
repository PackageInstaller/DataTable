-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/rpc/Activity224Rpc.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.rpc.Activity224Rpc", package.seeall)

local Activity224Rpc = class("Activity224Rpc", BaseRpc)

Activity224Rpc.instance = Activity224Rpc.New()

function Activity224Rpc:sendGet224InfoRequest(activityId, callback, callbackObj)
	local req = Activity224Module_pb.GetAct224InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity224Rpc:onReceiveGetAct224InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	TitleAppointmentModel.instance:setHasGetRewardId(msg.hasGetId)
	TitleAppointmentModel.instance:setLoopRewardCount(msg.hasSpCount)
	TitleAppointmentController.instance:dispatchEvent(TitleAppointmentEvent.RewardInfoChanged)
end

function Activity224Rpc:sendReceiveAct224BonusRequest(activityId, callback, callbackObj)
	local req = Activity224Module_pb.ReceiveAct224BonusRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity224Rpc:onReceiveReceiveAct224BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	TitleAppointmentModel.instance:setHasGetRewardId(msg.hasGetId)
	TitleAppointmentModel.instance:setLoopRewardCount(msg.hasSpCount)
	TitleAppointmentController.instance:dispatchEvent(TitleAppointmentEvent.RewardInfoChanged)
end

return Activity224Rpc
