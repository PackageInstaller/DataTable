-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeEnterView.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeEnterView", package.seeall)

local TwinDragonChallengeEnterView = class("TwinDragonChallengeEnterView", TongRuleView)

function TwinDragonChallengeEnterView:unbindEvents()
	TwinDragonChallengeEnterView.super.unbindEvents(self)
end

function TwinDragonChallengeEnterView:bindEvents()
	TwinDragonChallengeEnterView.super.bindEvents(self)
end

function TwinDragonChallengeEnterView:onExit()
	TwinDragonChallengeEnterView.super.onExit(self)
end

function TwinDragonChallengeEnterView:buildUI()
	TwinDragonChallengeEnterView.super.buildUI(self)
end

function TwinDragonChallengeEnterView:onEnter()
	local openParam = self:getOpenParam()

	self._planId = openParam[1]
	self._type = openParam[2]
	self._stageId = openParam[3]
	self._stageInfo = IntegrationChallengeConfig.instance:getStageByParam(self._planId, self._type, self._stageId)
	self._titleTxt.text = self._stageInfo.name
	self._descTxt.text = self._stageInfo.popExplanation
	self._condTxt.text = self._stageInfo.WinDesc
end

function TwinDragonChallengeEnterView:_onClickSureBtn()
	self:close()
	UIStateManager.instance:popByName(ViewName.TwinDragonChallengeView)
	UIStateManager.instance:push(ViewName.TwinDragonChallengeMissionView, self._stageInfo)
end

return TwinDragonChallengeEnterView
