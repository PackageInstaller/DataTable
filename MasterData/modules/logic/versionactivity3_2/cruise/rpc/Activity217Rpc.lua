-- chunkname: @modules/logic/versionactivity3_2/cruise/rpc/Activity217Rpc.lua

module("modules.logic.versionactivity3_2.cruise.rpc.Activity217Rpc", package.seeall)

local Activity217Rpc = class("Activity217Rpc", BaseRpc)

Activity217Rpc.instance = Activity217Rpc.New()

function Activity217Rpc:sendGet217InfosRequest(activityId, callback, callbackObj)
	local req = Activity217Module_pb.Get217InfosRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity217Rpc:onReceiveGet217InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity217Model.instance:setAct217Info(msg)
	Activity217Controller.instance:dispatchEvent(Activity217Event.onGetInfo)
end

function Activity217Rpc:onReceiveAct217CountChangePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity217Model.instance:updateAct217Info(msg)
	Activity217Controller.instance:dispatchEvent(Activity217Event.OnInfoChanged)
end

return Activity217Rpc
