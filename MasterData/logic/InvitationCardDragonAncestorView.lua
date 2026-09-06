-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/InvitationCardDragonAncestorView.lua

module("logic.extensions.activitypopup.view.InvitationCardDragonAncestorView", package.seeall)

local InvitationCardDragonAncestorView = class("InvitationCardDragonAncestorView", ViewComponent)

function InvitationCardDragonAncestorView:buildUI()
	InvitationCardDragonAncestorView.super.buildUI(self)
end

function InvitationCardDragonAncestorView:onEnter()
	InvitationCardDragonAncestorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._actId = checknumber(params[1])

	if self._actId == 0 then
		printError("缺少传入参数 活动Id")
		self:close()

		return
	end

	local path = "storyconfig/animations/shengzhupaidui.txt"

	AnimationPlayer.play(path, self._onAnimPlayFinish, self._onAnimPlayStart, self)
	ViewBlockMgr.instance:blockClick(true, self)
end

function InvitationCardDragonAncestorView:onExit()
	InvitationCardDragonAncestorView.super.onExit(self)
	ViewBlockMgr.instance:blockClick(false, self)
end

function InvitationCardDragonAncestorView:_onAnimPlayFinish()
	OpSummaryController.instance:acceptInvite(self._actId)
	self:close()
end

function InvitationCardDragonAncestorView:_onAnimPlayStart()
	return
end

return InvitationCardDragonAncestorView
