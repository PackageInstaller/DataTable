-- chunkname: @modules/logic/partygamelobby/rpc/PartyOutSideRpc.lua

module("modules.logic.partygamelobby.rpc.PartyOutSideRpc", package.seeall)

local PartyOutSideRpc = class("PartyOutSideRpc", BaseRpc)

function PartyOutSideRpc:sendGetPartyOutSideInfoRequest(activityId, callback, callbackObj)
	local req = PartyOutSideModule_pb.GetPartyOutSideInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function PartyOutSideRpc:onReceiveGetPartyOutSideInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

PartyOutSideRpc.instance = PartyOutSideRpc.New()

return PartyOutSideRpc
