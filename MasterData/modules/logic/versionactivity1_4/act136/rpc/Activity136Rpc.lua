-- chunkname: @modules/logic/versionactivity1_4/act136/rpc/Activity136Rpc.lua

module("modules.logic.versionactivity1_4.act136.rpc.Activity136Rpc", package.seeall)

local Activity136Rpc = class("Activity136Rpc", BaseRpc)

function Activity136Rpc:sendGet136InfoRequest(activityId)
	local req = Activity136Module_pb.Get136InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function Activity136Rpc:onReceiveGet136InfoReply(resultCode, msg)
	if resultCode == 0 then
		Activity136Model.instance:setActivityInfo(msg)
	end
end

function Activity136Rpc:sendAct136SelectRequest(activityId, selectCharacterId)
	local req = Activity136Module_pb.Act136SelectRequest()

	req.activityId = activityId
	req.selectHeroId = selectCharacterId

	return self:sendMsg(req)
end

function Activity136Rpc:onReceiveAct136SelectReply(resultCode, msg)
	if resultCode == 0 then
		Activity136Model.instance:setActivityInfo(msg)
		Activity136Controller.instance:confirmReceiveCharacterCallback()
	end
end

Activity136Rpc.instance = Activity136Rpc.New()

return Activity136Rpc
