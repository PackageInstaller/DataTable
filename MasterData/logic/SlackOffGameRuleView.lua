-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffGameRuleView.lua

module("logic.extensions.slackoffgame.view.SlackOffGameRuleView", package.seeall)

local SlackOffGameRuleView = class("SlackOffGameRuleView", PopupImageRuleView)

function SlackOffGameRuleView:onExit()
	SlackOffGameRuleView.super.onExit(self)

	if self._activityId then
		SlackOffGameController.instance:sendGameStartReq(self._activityId)
	end
end

function SlackOffGameRuleView:onEnter()
	SlackOffGameRuleView.super.onEnter(self)

	self._activityId = self:getOpenParam()[3]
end

return SlackOffGameRuleView
