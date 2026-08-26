-- chunkname: @modules/logic/turnback/invitation/controller/TurnBackInvitationController.lua

module("modules.logic.turnback.invitation.controller.TurnBackInvitationController", package.seeall)

local TurnBackInvitationController = class("TurnBackInvitationController", BaseController)

function TurnBackInvitationController:onInit()
	return
end

function TurnBackInvitationController:reInit()
	return
end

function TurnBackInvitationController:onInitFinish()
	return
end

function TurnBackInvitationController:addConstEvents()
	return
end

function TurnBackInvitationController:getInvitationInfo(activityId, callBack, callBackObj)
	TurnBackInvitationRpc.instance:sendGet171InfoRequest(activityId, callBack, callBackObj)
end

function TurnBackInvitationController:openMainView(activityId)
	self.getInvitationInfo(self, activityId, self.onReceiveMsg, self)
end

function TurnBackInvitationController:onReceiveMsg(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackInvitationMainView, msg.activityId, true)
	end
end

TurnBackInvitationController.instance = TurnBackInvitationController.New()

return TurnBackInvitationController
