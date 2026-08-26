-- chunkname: @modules/logic/versionactivity1_7/doubledrop/rpc/Activity153Rpc.lua

module("modules.logic.versionactivity1_7.doubledrop.rpc.Activity153Rpc", package.seeall)

local Activity153Rpc = class("Activity153Rpc", BaseRpc)

function Activity153Rpc:sendGet153InfosRequest(activityId)
	local req = Activity153Module_pb.Get153InfosRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity153Rpc:onReceiveGet153InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(msg)
end

function Activity153Rpc:onReceiveAct153CountChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(msg)
end

Activity153Rpc.instance = Activity153Rpc.New()

return Activity153Rpc
