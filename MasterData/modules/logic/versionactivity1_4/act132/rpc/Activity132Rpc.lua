-- chunkname: @modules/logic/versionactivity1_4/act132/rpc/Activity132Rpc.lua

module("modules.logic.versionactivity1_4.act132.rpc.Activity132Rpc", package.seeall)

local Activity132Rpc = class("Activity132Rpc", BaseRpc)

function Activity132Rpc:sendGet132InfosRequest(actId, callback, callbackObj)
	local req = Activity132Module_pb.Get132InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity132Rpc:onReceiveGet132InfosReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(msg)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function Activity132Rpc:onReceiveAct132InfoUpdatePush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(msg)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function Activity132Rpc:sendAct132UnlockRequest(actId, contentIds)
	local req = Activity132Module_pb.Act132UnlockRequest()

	req.activityId = actId

	for i, v in ipairs(contentIds) do
		table.insert(req.contentId, v)
	end

	self:sendMsg(req)
end

function Activity132Rpc:onReceiveAct132UnlockReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity132Model.instance:setContentUnlock(msg)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnContentUnlock, msg.contentId)
end

Activity132Rpc.instance = Activity132Rpc.New()

return Activity132Rpc
