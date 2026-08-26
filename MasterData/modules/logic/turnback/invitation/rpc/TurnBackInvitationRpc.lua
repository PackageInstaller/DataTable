-- chunkname: @modules/logic/turnback/invitation/rpc/TurnBackInvitationRpc.lua

module("modules.logic.turnback.invitation.rpc.TurnBackInvitationRpc", package.seeall)

local TurnBackInvitationRpc = class("TurnBackInvitationRpc", BaseRpc)

TurnBackInvitationRpc.instance = TurnBackInvitationRpc.New()

function TurnBackInvitationRpc:sendGet171InfoRequest(activityId, callBack, callBackObj)
	local req = Activity171Module_pb.Get171InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callBack, callBackObj)
end

function TurnBackInvitationRpc:onReceiveGet171InfoReply(resultCode, msg)
	if resultCode == 0 then
		TurnBackInvitationModel.instance:setActivityInfo(msg)
		TurnBackInvitationController.instance:dispatchEvent(TurnBackInvitationEvent.OnGetInfoSuccess)
	end
end

return TurnBackInvitationRpc
