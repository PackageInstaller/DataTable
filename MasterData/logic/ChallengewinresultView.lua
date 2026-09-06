-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/ChallengewinresultView.lua

module("logic.extensions.twindragonchallenge.view.ChallengewinresultView", package.seeall)

local ChallengewinresultView = class("ChallengewinresultView", ViewComponent)

function ChallengewinresultView:unbindEvents()
	ChallengewinresultView.super.unbindEvents(self)
	self._replaceBtn:RemoveClickListener()
	self._retainBtn:RemoveClickListener()
end

function ChallengewinresultView:bindEvents()
	ChallengewinresultView.super.bindEvents(self)
	self._replaceBtn:AddClickListener(self._onClickReplace, self)
	self._retainBtn:AddClickListener(self._onClickRetain, self)
end

function ChallengewinresultView:buildUI()
	ChallengewinresultView.super.buildUI(self)

	self._round = self:getTxt("bg/round")
	self._replaceBtn = self:getBtn("replaceBtn")
	self._retainBtn = self:getBtn("retainBtn")
	self._oldRound = self:getTxt("retainBtn/oldRound")
end

function ChallengewinresultView:onExit()
	ChallengewinresultView.super.onExit(self)
	GlobalDispatcher:removeListener(IntegrationChallengeController.PM_ICSetNewRoundsRes, self.close, self)
end

function ChallengewinresultView:onEnter()
	ChallengewinresultView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._challengeId = openParam[1]
	self._stageId = openParam[2]
	self._round.text = string.format(lang("twin_dragon_challenge_6"), openParam[3])
	self._oldRound.text = string.format(lang("twin_dragon_challenge_7"), openParam[4])

	GlobalDispatcher:addListener(IntegrationChallengeController.PM_ICSetNewRoundsRes, self.close, self)
end

function ChallengewinresultView:_onClickReplace()
	IntegrationChallengeController:sendPM_ICSetNewRoundsReq(self._challengeId, self._stageId, true)
end

function ChallengewinresultView:_onClickRetain()
	IntegrationChallengeController:sendPM_ICSetNewRoundsReq(self._challengeId, self._stageId, false)
end

return ChallengewinresultView
