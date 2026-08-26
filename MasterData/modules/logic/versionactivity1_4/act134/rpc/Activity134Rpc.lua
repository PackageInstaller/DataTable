-- chunkname: @modules/logic/versionactivity1_4/act134/rpc/Activity134Rpc.lua

module("modules.logic.versionactivity1_4.act134.rpc.Activity134Rpc", package.seeall)

local Activity134Rpc = class("Activity134Rpc", BaseRpc)

function Activity134Rpc:sendGet134InfosRequest(actId, callback, callbackObj)
	local req = Activity134Module_pb.Get134InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity134Rpc:onReceiveGet134InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity134Model.instance:onInitMo(msg)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnUpdateInfo, msg)
end

function Activity134Rpc:sendGet134BonusRequest(actId, bonusId)
	local req = Activity134Module_pb.Act134BonusRequest()

	req.activityId = actId
	req.id = bonusId

	self:sendMsg(req)
end

function Activity134Rpc:onReceiveAct134BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity134Model.instance:onReceiveBonus(msg.id)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnGetBonus, msg)
end

Activity134Rpc.instance = Activity134Rpc.New()

return Activity134Rpc
