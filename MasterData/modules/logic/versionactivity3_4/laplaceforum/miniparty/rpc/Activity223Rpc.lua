-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/rpc/Activity223Rpc.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.rpc.Activity223Rpc", package.seeall)

local Activity223Rpc = class("Activity223Rpc", BaseRpc)

Activity223Rpc.instance = Activity223Rpc.New()

function Activity223Rpc:sendGetAct223InfoRequest(activityId, callback, callbackObj)
	local req = Activity223Module_pb.GetAct223InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity223Rpc:onReceiveGetAct223InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MiniPartyModel.instance:setAct223Info(msg)
	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.OnInfoChange)
end

function Activity223Rpc:sendAct223InviteRequest(activityId, inviteCode, uid, callback, callbackObj)
	local req = Activity223Module_pb.Act223InviteRequest()

	req.activityId = activityId
	req.inviteCode = inviteCode
	req.inviteUserId = uid

	self:sendMsg(req, callback, callbackObj)
end

function Activity223Rpc:onReceiveAct223InviteReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	GameFacade.showToast(ToastEnum.MiniPartyInviteCodeSend)
	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.OnInviteSend)
end

function Activity223Rpc:sendAct223HandleInviteRequest(activityId, uid, isAgree, callback, callbackObj)
	local req = Activity223Module_pb.Act223HandleInviteRequest()

	req.activityId = activityId
	req.inviteUserId = uid
	req.isAgree = isAgree

	self:sendMsg(req, callback, callbackObj)
end

function Activity223Rpc:onReceiveAct223HandleInviteReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	MiniPartyController.instance:dispatchEvent(MiniPartyEvent.InviteFriendAgreeBack, msg.inviteUserId, msg.isAgree)
end

return Activity223Rpc
