-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamInviteTipView.lua

module("logic.extensions.formteam.view.FormTeamInviteTipView", package.seeall)

local FormTeamInviteTipView = class("FormTeamInviteTipView", ViewComponent)

function FormTeamInviteTipView:unbindEvents()
	FormTeamInviteTipView.super.unbindEvents(self)
end

function FormTeamInviteTipView:bindEvents()
	FormTeamInviteTipView.super.bindEvents(self)
end

function FormTeamInviteTipView:buildUI()
	FormTeamInviteTipView.super.buildUI(self)

	self._txtContent = self:getTxt("content/txt")
end

function FormTeamInviteTipView:onEnter()
	FormTeamInviteTipView.super.onEnter(self)

	local timeAutoClose = checkint(FormTeamConfig.instance:getCommonValue("INVITE_TIP_CLOSE_SEC"))

	settimer(timeAutoClose, self.close, self, false)

	self._txtContent.text = self:getFirstParam()
end

function FormTeamInviteTipView:onExit()
	FormTeamInviteTipView.super.onExit(self)
	removetimer(self.close, self)
end

return FormTeamInviteTipView
