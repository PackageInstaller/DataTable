-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/view/QiChallengeHardFmtView.lua

module("logic.extensions.qichallenge.view.QiChallengeHardFmtView", package.seeall)

local QiChallengeHardFmtView = class("QiChallengeHardFmtView", ViewComponent)

function QiChallengeHardFmtView:buildUI()
	QiChallengeHardFmtView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
end

function QiChallengeHardFmtView:bindEvents()
	QiChallengeHardFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function QiChallengeHardFmtView:unbindEvents()
	QiChallengeHardFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function QiChallengeHardFmtView:onEnter()
	QiChallengeHardFmtView.super.onEnter(self)

	local params = self:getFirstParam()

	self._activityId = params:getActivityId()

	local list = QiChallengeModel.instance:getHardChallengePets()

	if #list > 0 and not QiChallengeModel.instance:getEnterHardChallenge() then
		self:_onClickTip()
		QiChallengeModel.instance:setEnterHardChallenge()
	end
end

function QiChallengeHardFmtView:onExit()
	QiChallengeHardFmtView.super.onExit(self)
end

function QiChallengeHardFmtView:_onClickTip()
	UIStateManager.instance:push(ViewName.QiChallengeSuppressView, self._activityId, true)
end

return QiChallengeHardFmtView
