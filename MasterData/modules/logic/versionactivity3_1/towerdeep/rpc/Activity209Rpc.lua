-- chunkname: @modules/logic/versionactivity3_1/towerdeep/rpc/Activity209Rpc.lua

module("modules.logic.versionactivity3_1.towerdeep.rpc.Activity209Rpc", package.seeall)

local Activity209Rpc = class("Activity209Rpc", BaseRpc)

Activity209Rpc.instance = Activity209Rpc.New()

function Activity209Rpc:sendGetAct209InfoRequest(activityId, callback, callbackObj)
	local req = Activity209Module_pb.GetAct209InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity209Rpc:onReceiveGetAct209InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	TowerDeepOperActModel.instance:setMaxLayer(msg.maxLayer)
	TowerDeepOperActController.instance:dispatchEvent(TowerDeepOperActEvent.onAct209InfoGet)
end

function Activity209Rpc:onReceiveAct209InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	TowerDeepOperActModel.instance:setMaxLayer(msg.maxLayer)
	TowerDeepOperActController.instance:dispatchEvent(TowerDeepOperActEvent.OnAct209InfoUpdate)
end

return Activity209Rpc
