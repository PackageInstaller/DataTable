-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/TwinDragonChallengeMissionView.lua

module("logic.extensions.twindragonchallenge.view.TwinDragonChallengeMissionView", package.seeall)

local TwinDragonChallengeMissionView = class("TwinDragonChallengeMissionView", MissionView)

function TwinDragonChallengeMissionView:onExit()
	TwinDragonChallengeMissionView.super.onExit(self)
end

function TwinDragonChallengeMissionView:onEnter()
	self:onEnterInherit()
	MissionModel.instance:setForceResetOneKey(true)

	self._stageCfg = self:getFirstParam()
	self._titleTxt.text = self._stageCfg.name
	self._descTxt.text = self._stageCfg.WinDesc

	self:_setMaskBlock(false)

	self._fmtChanged = false

	self._videoButton.gameObject:SetActive(false)
	goutil.setActive(self._topDesc.gameObject, false)
	goutil.setActive(self._txtValidatorDesc.gameObject, false)

	if string.nilorempty(self._stageCfg.missionCondition) then
		goutil.setActive(self._txtDesc.gameObject, false)
	else
		goutil.setActive(self._txtDesc.gameObject, true)

		self._txtDesc.text = self._stageCfg.missionCondition
	end
end

function TwinDragonChallengeMissionView:_enterBattle()
	self:_setMaskBlock(false)

	if not FormationController.instance:SaveFormationEx(function()
		IntegrationChallengeController.instance:sendPM_ICChallengeReq(IntegrationChallengeModel.TwinDragon, self._stageCfg.type, self._stageCfg.stageId)
	end) then
		IntegrationChallengeController.instance:sendPM_ICChallengeReq(IntegrationChallengeModel.TwinDragon, self._stageCfg.type, self._stageCfg.stageId)
	end
end

return TwinDragonChallengeMissionView
