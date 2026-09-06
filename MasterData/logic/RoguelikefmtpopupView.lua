-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikefmtpopupView.lua

module("logic.extensions.roguelike.view.RoguelikefmtpopupView", package.seeall)

local RoguelikefmtpopupView = class("RoguelikefmtpopupView", ViewComponent)

function RoguelikefmtpopupView:buildUI()
	RoguelikefmtpopupView.super.buildUI(self)

	self._btnBuff = self:getBtn("btnBuff")
end

function RoguelikefmtpopupView:bindEvents()
	RoguelikefmtpopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function RoguelikefmtpopupView:unbindEvents()
	RoguelikefmtpopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function RoguelikefmtpopupView:onEnter()
	RoguelikefmtpopupView.super.onEnter(self)

	self._rogueFmtMo = self:getFirstParam()
	self._activityId = self._rogueFmtMo:getActivityId()
	self._phaseId = self._rogueFmtMo:getPhaseId()
end

function RoguelikefmtpopupView:onExit()
	RoguelikefmtpopupView.super.onExit(self)
end

function RoguelikefmtpopupView:_onClickBuff()
	UIStateManager.instance:push(ViewName.RoguelikebufflookView, self._activityId, self._phaseId)
end

return RoguelikefmtpopupView
