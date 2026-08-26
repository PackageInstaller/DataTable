-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/rpc/Activity226Rpc.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.rpc.Activity226Rpc", package.seeall)

local Activity226Rpc = class("Activity226Rpc", BaseRpc)

Activity226Rpc.instance = Activity226Rpc.New()

function Activity226Rpc:sendGet226InfoRequest(activityId, callback, callbackObj)
	local req = Activity226Module_pb.GetAct226InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity226Rpc:onReceiveGetAct226InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ObserverBoxModel.instance:setPageInfos(msg.pages)
	ObserverBoxController.instance:dispatchEvent(ObserverBoxEvent.RewardInfoChanged)
end

function Activity226Rpc:sendReceiveAct226BonusRequest(activityId, pos, callback, callbackObj)
	local req = Activity226Module_pb.ReceiveAct226BonusRequest()

	req.activityId = activityId
	req.pos = pos

	self:sendMsg(req, callback, callbackObj)
end

function Activity226Rpc:onReceiveReceiveAct226BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ObserverBoxModel.instance:updatePosInfo(msg.posInfo)
	ObserverBoxController.instance:dispatchEvent(ObserverBoxEvent.RewardBonusGet, msg.pos)
end

return Activity226Rpc
