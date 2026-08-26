-- chunkname: @modules/logic/versionactivity1_4/act133/rpc/Activity133Rpc.lua

module("modules.logic.versionactivity1_4.act133.rpc.Activity133Rpc", package.seeall)

local Activity133Rpc = class("Activity133Rpc", BaseRpc)

function Activity133Rpc:sendGet133InfosRequest(actId, callback, callbackObj)
	local req = Activity133Module_pb.Get133InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity133Rpc:onReceiveGet133InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity133Model.instance:setActivityInfo(msg)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnUpdateInfo)
end

function Activity133Rpc:sendAct133BonusRequest(actId, bonusId)
	local req = Activity133Module_pb.Act133BonusRequest()

	req.activityId = actId
	req.id = bonusId

	self:sendMsg(req)
end

function Activity133Rpc:onReceiveAct133BonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local function callback()
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnGetBonus, msg)
	end

	self.sendGet133InfosRequest(self, VersionActivity1_4Enum.ActivityId.ShipRepair, callback, self)
end

Activity133Rpc.instance = Activity133Rpc.New()

return Activity133Rpc
