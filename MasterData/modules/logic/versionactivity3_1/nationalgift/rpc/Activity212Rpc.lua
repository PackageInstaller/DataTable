-- chunkname: @modules/logic/versionactivity3_1/nationalgift/rpc/Activity212Rpc.lua

module("modules.logic.versionactivity3_1.nationalgift.rpc.Activity212Rpc", package.seeall)

local Activity212Rpc = class("Activity212Rpc", BaseRpc)

Activity212Rpc.instance = Activity212Rpc.New()

function Activity212Rpc:sendGetAct212InfoRequest(activityId, callback, callbackObj)
	local req = Activity212Module_pb.GetAct212InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity212Rpc:onReceiveGetAct212InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	NationalGiftModel.instance:setActInfo(msg.act212Info)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.onAct212InfoGet)
end

function Activity212Rpc:sendAct212ReceiveBonusRequest(activityId, bonusId, callback, callbackObj)
	local req = Activity212Module_pb.Act212ReceiveBonusRequest()

	req.activityId = activityId
	req.id = bonusId

	self:sendMsg(req, callback, callbackObj)
end

function Activity212Rpc:onReceiveAct212ReceiveBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	NationalGiftModel.instance:updateBonusStatus(msg.id, msg.status, msg.activityId)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.onAct212InfoUpdate)
end

function Activity212Rpc:onReceiveAct212BonusPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	NationalGiftModel.instance:setActInfo(msg.act212Info)
	NationalGiftController.instance:dispatchEvent(NationalGiftEvent.OnAct212BonusUpdate)
end

return Activity212Rpc
